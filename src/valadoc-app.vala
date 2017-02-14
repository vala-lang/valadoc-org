using Valum;
using Valum.ContentNegotiation;
using VSGI;

namespace Valadoc.App {

	public int main (string[] args) {
		var app = new Router ();
		var docroot = File.new_for_path ("valadoc.org");

		app.use (basic ());

		app.use (status (404, forward_with<Error> (accept ("text/html", (req, res, next, ctx, err) => {
			uint8[] navi_contents;
			string  navi_etag;
			docroot.get_child ("index.htm.navi.tpl").load_contents (null, out navi_contents, out navi_etag);
			res.status = 404;
			res.headers.append ("ETag", navi_etag);
			return render_template ("Page not found", (string) navi_contents, """<div id="site_content">
  <h1 class="main_title">404</h1>
  <hr class="main_hr">
  <h2>Page not found</h2>
  <p>The page your are looking for can not be found.</p>
</div>""") (req, res, next, ctx);
		}))));

		app.get ("/<path:path>", Static.serve_from_file (docroot, Static.ServeFlags.ENABLE_ETAG));

		app.register_type ("pkg", /[\w-.]+/);
		app.register_type ("sym", /[\w.]+/);

		app.get ("/(<pkg:package>/(<sym:symbol>.html)?)?(index.htm)?", accept ("text/html", (req, res, next, ctx) => {
			var title = new StringBuilder ("Valadoc.org");
			File navi_file;
			File content_file;
			if ("package" in ctx) {
				title.append_printf (" &dash; %s", ctx["package"].get_string ());
				if ("symbol" in ctx) {
					// symbol
					title.append_printf (" &dash; %s", ctx["symbol"].get_string ());
					navi_file    = docroot.get_child (ctx["package"].get_string ()).get_child ("%s.html.navi.tpl".printf (ctx["symbol"].get_string ()));
					content_file = docroot.get_child (ctx["package"].get_string ()).get_child ("%s.html.content.tpl".printf (ctx["symbol"].get_string ()));
				} else {
					// package index
					navi_file    = docroot.get_child (ctx["package"].get_string ()).get_child ("index.htm.navi.tpl");
					content_file = docroot.get_child (ctx["package"].get_string ()).get_child ("index.htm.content.tpl");
				}
			} else {
				// index
				title.append (" &dash; Stays crunchy. Even in milk.");
				navi_file    = docroot.get_child ("index.htm.navi.tpl");
				content_file = docroot.get_child ("index.htm.content.tpl");
			}

			uint8[] navi;
			string  navi_etag;
			uint8[] content;
			string  content_etag;
			try {
				navi_file.load_contents (null, out navi, out navi_etag);
				content_file.load_contents (null, out content, out content_etag);
			} catch (IOError.NOT_FOUND err) {
				throw new ClientError.NOT_FOUND (""); // ignored in the 404 handler
			}

			if (navi_etag != null && content_etag != null) {
				var etag = "\"%s\"".printf (navi_etag + content_etag);
				if (etag == req.headers.get_one ("If-None-Match")) {
					throw new Redirection.NOT_MODIFIED ("");
				} else {
					res.headers.replace ("ETag", etag);
				}
			}

			return render_template (title.str, (string) navi, (string) content) (req, res, next, ctx);
		}));

		Database db;
		try {
			db = new Database ("127.0.0.1", 51413);
		} catch (Error err) {
			critical ("%s (%s, %d)", err.message, err.domain.to_string (), err.code);
			return 1;
		}

		app.use ((req, res, next) => {
			db.ping (); /* keep-alive */
			return next ();
		});

		app.use ((req, res, next) => {
			try {
				return next ();
			} catch (Error err) {
				critical ("%s (%s, %d)", err.message, err.domain.to_string (), err.code);
				res.headers.set_content_type ("text/plain", null);
				return res.expand_utf8 ("Query failed: (%s) ".printf (err.message));
			}
		});

		app.post ("/search", accept ("text/html", (req, res) => {
			var form = Soup.Form.decode (req.flatten_utf8 ());

			string[] allpkgs = {"stablezlib"}; // TODO: move that into the query

			var result = db.query ("""
			SELECT type, name, shortdesc, path, signature, typeorder, %s
			FROM %s
			WHERE MATCH(?)
			ORDER BY WEIGHT() DESC, namelen ASC, typeorder ASC
			LIMIT ?,20 OPTION ranker=proximity,index_weights=(%s=2)""".printf ("namelen", string.joinv (",", allpkgs), "stablezlib"),
			form.lookup ("query"), form.lookup ("offset") ?? "0");

			foreach (var row in result) {
				var path    = row["path"];
				var package = path.substring (0, path.index_of_char ('/'));
				var symbol  = path.substring (path.index_of_char ('/') + 1);
				res.append_utf8 ("""<li class="search-result %s">
				                      <a href="%s">
				                        <span class="search-name">
				                          %s
				                          <span class="search-package">%s</span>
				                        </span>
				                        <span class="search-desc">%s</span>
				                      </a>
				                    </li>""".printf (row["type"].down (),
				                                     path,
				                                     row["name"],
				                                     package,
				                                     row["shortdesc"]));
			}

			return res.end ();
		}));

		app.post ("/tooltip", accept ("text/html", (req, res) => {
			var form = Soup.Form.decode (req.flatten_utf8 ());

			var result = db.query ("""
			SELECT type, name, shortdesc, path, signature, namelen
			FROM %s
			WHERE MATCH(?) AND namelen=?
			LIMIT 1 OPTION max_matches=1,ranker=none""", form.lookup ("index"), 
			form.lookup ("name"),
			form.lookup ("namelen"));

			if (result.is_empty ()) {
				return res.expand_utf8 ("no result");
			}

			foreach (var row in result) {
				res.append_utf8 ("<p>%s</p>%s".printf (row["signature"], 
				                                       row["shortdesc"]));
			}

			return res.end ();
		}));

		return Server.@new ("http", handler: app, interface: new Soup.Address.any (Soup.AddressFamily.IPV4, 7777)).run (args);
	}

	public HandlerCallback render_template (string title, string navi, string content) {
		return (req ,res) => {
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
    <div id="search-box">
      <input id="search-field" type="text" placeholder="Search" autocompletion="off" autosave="search" /><img id="search-field-clear" src="/images/clean.svg" />
    </div>
    <a class="title" href="/index.htm"><img alt="Valadoc" src="/images/logo.svg"/></a>
    <span class="subtitle">Stays crunchy, even in milk.</span>
    <div id="links">
      <ul>
        <li><a href="/markup.htm">Markup</a></li>
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
</html>""".printf (title, title, navi, content, new DateTime.now_local ().get_year ()));
		};
	}
}
