using Valum;
using Valum.ContentNegotiation;
using VSGI;

namespace Valadoc {

	public int main (string[] args) {
		var app = new Router ();
		var docroot = File.new_for_path ("valadoc.org");

		app.use (basic ());
		app.use (accept ("text/html"));

		app.use (status (404, (req, res, next, ctx) => {
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
		}));

		var serve_flags = Static.ServeFlags.ENABLE_ETAG;

		app.get ("/styles/<path:path>",  Static.serve_from_file (docroot.get_child ("styles"),  serve_flags));
		app.get ("/images/<path:path>",  Static.serve_from_file (docroot.get_child ("images"),  serve_flags));
		app.get ("/scripts/<path:path>", Static.serve_from_file (docroot.get_child ("scripts"), serve_flags));

		app.register_type ("pkg", /[\w-.]+/);
		app.register_type ("sym", /[\w.]+/);

		app.get ("/(<pkg:package>(/<sym:symbol>.html)?)?(/index.htm)?", (req, res, next, ctx) => {
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
			try {
				navi_file.load_contents (null, out navi, out navi_etag);
			} catch (IOError.NOT_FOUND err) {
				throw new ClientError.NOT_FOUND ("...");
			}

			uint8[] content;
			string  content_etag;
			try {
				content_file.load_contents (null, out content, out content_etag);
			} catch (IOError.NOT_FOUND err) {
				throw new ClientError.NOT_FOUND ("...");
			}

			// TODO: Generate 'ETag' header

			return render_template (title.str, (string) navi, (string) content) (req, res, next, ctx);
		});

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
    Copyright © 2016 Valadoc.org | Documentation is licensed under the same terms as its upstream |
    <a href="https://github.com/Valadoc/valadoc-org/issues" target="_blank">Report an Issue</a>
  </footer>
  <script type="text/javascript" src="/scripts/jquery.min.js"></script>
  <script type="text/javascript" src="/scripts/jquery.ba-hashchange.min.js"></script>
  <script type="text/javascript" src="/scripts/wtooltip.js"></script>
  <script type="text/javascript" src="/scripts/valadoc.js"></script>
  <script type="text/javascript" src="/scripts/main.js"></script>
</body>
</html>""".printf (title, title, navi, content));
		};
	}
}
