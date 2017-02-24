using Compose.HTML5;
using Valum;
using Valum.ContentNegotiation;
using VSGI;

namespace Valadoc.App {

	public struct DocCacheEntry {
		uint8[] contents;
		string? etag;
	}

	public int main (string[] args) {
		var app = new Router ();
		var docroot = File.new_for_path ("valadoc.org");

		var doc_cache = new GLru.Cache<string, DocCacheEntry?> (str_hash, str_equal, (path) => {
			uint8[] contents;
			string etag;
			docroot.resolve_relative_path (path).load_contents (null, out contents, out etag);
			contents.length += 1; /* include null-terminator from 'load_contents' */
			return {contents, etag};
		});

		doc_cache.max_size = 512;

		app.use (basic ());

		app.use (status (404, (req, res, next, ctx, err) => {
			return accept ("text/html", (req, res, next, ctx) => {
				DocCacheEntry navi;
				try {
					navi = doc_cache["index.htm.navi.tpl"];
				} catch (Error cache_err) {
					critical ("%s, (%s, %d)", cache_err.message, cache_err.domain.to_string (), cache_err.code);
					throw err;
				}
				res.status = 404;
				return render_template ("Page not found", (string) navi.contents,
					div ({"id=site_content"},
						 h1 ({"class=main_title"}, "404"),
						 hr ({"class=main_hr"}),
						 h2 ({}, "Page not found"),
						 p ({}, e (err.message)))) (req, res, next, ctx);
		}) (req, res, next, ctx); }));

		app.get ("/favicon.ico", () => {
			throw new Redirection.MOVED_PERMANENTLY ("/images/favicon.ico");
		});

		app.register_type ("path", /(?:\.?[\w-\s\/@])+/);

		app.get ("/<path:path>", Static.serve_from_file (docroot, Static.ServeFlags.ENABLE_ETAG, (req, res, next, ctx, file) => {
			if (file.get_basename ().has_suffix (".tpl")) {
				res.headers.set_content_type ("text/html", null);
			}
			return next ();
		}));

		app.register_type ("pkg", /[\w-.]+/);
		app.register_type ("sym", /[\w.@]+/);

		app.get ("/(<pkg:package>/(<sym:symbol>.html)?)?(index.htm)?", accept ("text/html", (req, res, next, ctx) => {
			var title = new StringBuilder ("Valadoc.org");
			DocCacheEntry navi;
			DocCacheEntry content;
			try {
				if ("package" in ctx) {
					title.append_printf (" &dash; %s", ctx["package"].get_string ());
					if ("symbol" in ctx) {
						// symbol
						title.append_printf (" &dash; %s", ctx["symbol"].get_string ());
						navi    = doc_cache["%s/%s.html.navi.tpl".printf (ctx["package"].get_string (), ctx["symbol"].get_string ())];
						content = doc_cache["%s/%s.html.content.tpl".printf (ctx["package"].get_string (), ctx["symbol"].get_string ())];
					} else {
						// package index
						navi    = doc_cache["%s/index.htm.navi.tpl".printf (ctx["package"].get_string ())];
						content = doc_cache["%s/index.htm.content.tpl".printf(ctx["package"].get_string ())];
					}
				} else {
					// index
					title.append (" &dash; Stays crunchy. Even in milk.");
					navi    = doc_cache["index.htm.navi.tpl"];
					content = doc_cache["index.htm.content.tpl"];
				}
			} catch (Error err) {
				throw new ClientError.NOT_FOUND ("The page you are looking for cannot be found.");
			}

			return render_template (title.str, (string) navi.contents, (string) content.contents, navi.etag + content.etag) (req, res, next, ctx);
		}));

		app.get ("/<path:template>.htm", accept ("text/html", (req, res, next, ctx) => {
			var navi    = doc_cache["index.htm.navi.tpl"];
			var content = doc_cache["templates/%s.htm.content.tpl".printf (ctx["template"].get_string ())];
			return render_template ("Markup", (string) navi.contents, (string) content.contents, navi.etag + content.etag) (req, res, next, ctx);
		}));

		Database db;
		try {
			db = new Database ("127.0.0.1", 51413);
		} catch (Error err) {
			critical ("%s (%s, %d)", err.message, err.domain.to_string (), err.code);
			return 1;
		}

    var database_mutex = Mutex ();
		app.use ((req, res, next) => {
			database_mutex.lock ();
			try {
				db.ping (); /* keep-alive */
				return next ();
			} finally {
				database_mutex.unlock ();
			}
		});

		app.use ((req, res, next) => {
			try {
				return next ();
			} catch (Redirection err) {
				throw err;
			} catch (ClientError err) {
				throw err;
			} catch (Error err) {
				critical ("%s (%s, %d)", err.message, err.domain.to_string (), err.code);
				res.status = 500;
				res.headers.set_content_type ("text/plain", null);
				return res.expand_utf8 ("Query failed: (%s) ".printf (err.message));
			}
		});

		app.get ("/search", accept ("text/html, application/json, text/plain", (req, res, next, ctx) => {
			var query = req.lookup_query ("query");
			if (query == null) {
				throw new ClientError.BAD_REQUEST ("The 'query' field is required.");
			}

			string[] options = {"ranker=proximity"};

			var package = req.lookup_query ("package");
			if (package != null && package != "") {
				options += "index_weights=(%s=2)".printf ("stable" + package.replace ("-", "").replace (".", ""));
			}

			var offset = req.lookup_query ("offset") ?? "0";
			if (!uint64.try_parse (offset)) {
				throw new ClientError.BAD_REQUEST ("The 'offset' field is not a valid integer.");
			}

			string[] all_packages = {};
			foreach (var row in db.query ("SHOW TABLES")) {
				if (row.get ("Index").has_prefix ("stable")) {
					all_packages += row.get ("Index");
				}
			}

			// escape character for Sphinx's match
			query = new Regex ("[\\()|\\-!@~\"&/^$=]").replace_eval (query, -1, 0, 0, (match_info, builder) => {
				builder.append_printf ("\\%s", match_info.fetch (0));
				return false;
			});

			// don't consider dots
			query = query.replace (".", " << . << ") + "*";

			var result = db.query ("""
			SELECT type, name, shortdesc, path
			FROM %s
			WHERE MATCH(?)
			GROUP BY name
			ORDER BY WEIGHT() DESC, typeorder ASC, namelen ASC, shortdesc DESC
			LIMIT ?,20 OPTION %s""".printf (string.joinv (", ", all_packages), string.joinv (",", options)),
			"@(shortname,ftsname) %s".printf (query),
			offset);

			if (res.headers.get_content_type (null) == "text/html") {
				uint8[] search_result_navi;
				if (package != null) {
					docroot.get_child (package).get_child ("index.htm.navi.tpl").load_contents (null, out search_result_navi, null);
				} else {
					docroot.get_child ("index.htm.navi.tpl").load_contents (null, out search_result_navi, null);
				}
				var search_result_content = new StringBuilder ();
				search_result_content.append (h1 ({}, "Search Results for ", e ("\"" + req.lookup_query ("query") + "\""), Compose.when (package != null, () => { return " in " + package; })));
				search_result_content.append (hr ());
				foreach (var row in result) {
					var html_regex  = new Regex("<.*?>");
					var path        = row["path"];
					var pkg         = path.substring (1, path.last_index_of_char ('/') - 1);
					var symbol      = path.substring (path.last_index_of_char ('/') + 1);
					var description = html_regex.replace (row["shortdesc"], row["shortdesc"].length, 0, "");
					search_result_content.append (
						div ({"class=highlight search-result %s".printf (row["type"].down ())},
						a (path, {},
						   span ({"class=search-name"},
								 e (row["name"]),
								 span ({"class=search-package"}, " ", "(", e (pkg), ")")),
						   span ({"class=search-desc"}, e (description)))));
				}
				return render_template ("Search Results", (string) search_result_navi, search_result_content.str) (req, res, next, ctx);
			} else if (res.headers.get_content_type (null) == "text/plain") {
				foreach (var row in result) {
					var html_regex  = new Regex("<.*?>");
					var path        = row["path"];
					var pkg         = path.substring (1, path.last_index_of_char ('/') - 1);
					var symbol      = path.substring (path.last_index_of_char ('/') + 1);
					var description = html_regex.replace (row["shortdesc"], row["shortdesc"].length, 0, "");
					res.append_utf8 (
						li ({"class=search-result %s".printf (row["type"].down ())},
						a (path, {},
						   span ({"class=search-name"},
								 e (row["name"]),
								 span ({"class=search-package"}, " ", "(", e (pkg), ")")),
						   span ({"class=search-desc"}, e (description)))));
				}
			} else {
				var builder = new Json.Builder ();

				builder.begin_array ();
				foreach (var row in result) {
					builder.begin_object ();

					builder.set_member_name ("type");
					builder.add_string_value (row["type"]);

					builder.set_member_name ("path");
					builder.add_string_value (row["path"]);

					builder.set_member_name ("name");
					builder.add_string_value (row["name"]);

					builder.set_member_name ("description");
					builder.add_string_value (row["shortdesc"]);

					builder.end_object ();
				}
				builder.end_array ();

				var gen = new Json.Generator ();

				gen.root = builder.get_root ();

				return gen.to_stream (res.body);
			}

			return res.end ();
		}));

		app.get ("/tooltip", accept ("text/plain", (req, res) => {
			var fullname = req.lookup_query ("fullname") ?? "/";
			if (fullname == null) {
				throw new ClientError.BAD_REQUEST ("The 'fullname' field is required.");
			}
			if (fullname.index_of_char ('/') == -1) {
				throw new ClientError.BAD_REQUEST ("The 'fullname' field is not correctly formed.");
			}

			var package = fullname.split ("/")[0];
			var name    = fullname.split ("/")[1];

			var result = db.query ("""
			SELECT shortdesc, signature
			FROM %s
			WHERE MATCH(?) AND namelen=?
			LIMIT 1 OPTION max_matches=1,ranker=none""".printf ("stable" + package.replace ("-", "").replace (".", "")),
			name.replace (".", " << . << "),
			name.length.to_string ());

			var result_iter = result.iterator ();

			if (result_iter.next ()) {
				return res.expand_utf8 (p ({}, result_iter.get ()["signature"]) + result_iter.get ()["shortdesc"]);
			} else {
				return res.expand_utf8 (p ({}, "No results for ", e (name), " in ", e (package), "."));
			}
		}));

		return Server.@new ("http", handler: app).run (args);
	}

	public HandlerCallback render_template (string title, string navi, string content, string? etag = null) {
		return (req, res, next, ctx) => {
			if (etag != null) {
				var _etag = "\"%s\"".printf (etag);
				if (_etag == req.headers.get_one ("If-None-Match")) {
					throw new Redirection.NOT_MODIFIED ("");
				} else {
					res.headers.replace ("ETag", _etag);
				}
			}
			return res.expand_utf8 ("""<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta itemprop="image" content="http://valadoc.org/images/preview.png">
  <meta name="fragment" content="!">
  <meta name="twitter:card" content="summary_large_image" />
  <meta name="theme-color" content="#403757">
  <meta property="og:description" content="The canonical source for Vala API references.">
  <meta property="og:image" content="http://valadoc.org/images/preview.png">
  <meta property="og:title" content="%s">
  <meta property="og:type" content="website">
  <title>%s</title>
  <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Open+Sans:300,400|Droid+Serif:400|Roboto+Mono:400,500,700,400italic">
  <link rel="stylesheet" href="/styles/main.css" type="text/css">
  <link rel="apple-touch-icon" href="/images/icon.png" />
  <link rel="shortcut icon" href="/images/favicon.ico">
</head>
<body>
  <nav>
    <form id="search-box" action="/search">
      <input id="search-field" name="query" type="text" placeholder="Search" autocompletion="off" autosave="search" /><img id="search-field-clear" src="/images/clean.svg" />
      <input name="package" type="hidden" value="%s">
    </form>
    <a class="title" href="/index.htm"><img alt="Valadoc" src="/images/logo.svg"/></a>
    <span class="subtitle">Stays crunchy, even in milk.</span>
    <div id="links">
      <ul>
        <li><a href="/markup.htm">Markup</a></li>
      </ul>
    </div>
  </nav>
  <div id="sidebar">
    <ul class="navi_main" id="search-results"></ul>
    <div id="navigation-content">
      %s
    </div>
  </div>
  <div id="content-wrapper">
    <div id="content">
      %s
    </div>
    <div id="comments" />
  </div>
  <footer>
    Copyright © %d Valadoc.org | Documentation is licensed under the same terms as its upstream |
    <a href="https://github.com/Valadoc/valadoc-org/issues" target="_blank">Report an Issue</a> |
    Powered by <a href="https://github.com/valum-framework/valum" target="_blank">Valum</a>
  </footer>
  <script type="text/javascript" src="/scripts/jquery.min.js"></script>
  <script type="text/javascript" src="/scripts/jquery.ba-hashchange.min.js"></script>
  <script type="text/javascript" src="/scripts/wtooltip.js"></script>
  <script type="text/javascript" src="/scripts/valadoc.js"></script>
  <script type="text/javascript" src="/scripts/main.js"></script>
</body>
</html>""".printf (title, title, "package" in ctx ? ctx["package"].get_string () : "", navi, content, new DateTime.now_local ().get_year ()));
		};
	}
}
