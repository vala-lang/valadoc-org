<?php

//	ini_set("display_errors","1");
//	ERROR_REPORTING(E_ALL);

/**
 * get_title
 * Returns a string to be used as page title
 *
 * @param String $page path of internal page
 * @return String HTML page title
 */
function get_title ($page) {
  $pages = explode('/', $page);

  if (count($pages) === 2 && $pages[0] !== "templates") { // We are on an API page

    if (substr($pages[1], -9) === "index.html") { // An API index page
      return $pages[0];
    } else { // A normal API page
      return basename ($pages[1], ".html") . ' &ndash; ' . $pages[0];
    }

  } else {
    return  "Valadoc.org";
  }
}

// Page parsing
$requestUri = parse_url($_SERVER["REQUEST_URI"], PHP_URL_PATH);
$segments = explode('/', $requestUri);
$first = str_replace(['.html', '.htm'], '', $segments[1] ?? '');
$second = str_replace(['.html', '.htm'], '', $segments[2] ?? '');

if ($first == null || $first === "index") { // Homepage
  $page = "index.htm";
} else if ($second === "index") { // An API index page
  $page = "$first/index.htm";
} else if (file_exists(__DIR__."/$first/$second.html.content.tpl")) { // An API info page
  $page = "$first/$second.html";
} else if (file_exists(__DIR__."/templates/$first.htm.content.tpl")) { // A template page
  $page = "templates/$first.htm";
} else { // 404 page
  header('HTTP/1.1 404 Not Found');
  $page = "templates/404.htm";
}

?>
<!doctype html>
<html lang="en" itemscope itemtype="http://schema.org/WebSite">
<head>
  <meta charset="UTF-8">
  <meta itemprop="image" content="https://valadoc.org/images/preview.png">
  <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1">
  <meta name="fragment" content="!">
  <meta name="twitter:card" content="summary_large_image" />
  <meta name="theme-color" content="#403757">
  <meta itemprop="url" content="https://valadoc.org/"/>
  <meta property="og:description" content="The canonical source for Vala API references.">
  <meta property="og:image" content="https://valadoc.org/images/preview.png">
  <meta property="og:title" content="<?php echo get_title ($page); ?>">
  <meta property="og:type" content="website">
  <title><?php echo get_title ($page); ?></title>
  <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Open+Sans:300,400%7CDroid+Serif:400%7CRoboto+Mono:400,500,700,400italic">
  <link rel="stylesheet" href="/styles/main.css" type="text/css">
  <link rel="apple-touch-icon" href="/images/icon.png">
  <link rel="shortcut icon" href="/images/favicon.ico">
  <link rel="search" type="application/opensearchdescription+xml" title="Valadoc" href="/opensearch.xml">
</head>
<body>
  <nav>
    <div id="hamburger-icon" onclick="toggle_mobile_nav(this)">
      <div class="bar1"></div>
      <div class="bar2"></div>
      <div class="bar3"></div>
    </div>
    <a id="nav-title" href="/index.htm"><img alt="Valadoc" src="/images/purple-logo.svg"/></a>
  </nav>
  <div id="overlay-background"></div>
  <div id="mobile-menu-overlay">
    <a href="/index.htm">Home</a>
    <form action="/">
      <div class="search-box" itemscope itemprop="potentialAction" itemtype="http://schema.org/SearchAction">
        <meta itemprop="target" content="/?q={query}">
        <meta itemprop="query-input" content="required name=query">
        <input itemprop="query-input" class="search-field" type="search" placeholder="Search" autocomplete="off" name="q" />
        <img class="search-logo" src="/images/magnifier.svg" alt="Search Logo" />
        <img class="search-field-clear" src="/images/clean.svg" alt="Clear search" />
      </div>
    </form>
    <ul class="navi_main search-results"></ul>
    <div class="navigation-content">
      <?php @readfile (__DIR__ . "/" . $page . ".navi.tpl"); ?>
    </div>
  </div>
  <div id="sidebar">
    <a class="title" href="/index.htm"><img alt="Valadoc" src="/images/purple-logo.svg"/></a>
    <form action="/">
      <div class="search-box" itemscope itemprop="potentialAction" itemtype="http://schema.org/SearchAction">
        <meta itemprop="target" content="/?q={query}">
        <meta itemprop="query-input" content="required name=query">
        <input itemprop="query-input" class="search-field" type="search" placeholder="Search" autocomplete="off" name="q" />
        <img class="search-logo" src="/images/magnifier.svg" alt="Search Logo" />
        <img class="search-field-clear" src="/images/clean.svg" alt="Clear search" />
      </div>
    </form>
    <ul class="navi_main search-results"></ul>
    <div class="navigation-content">
      <?php @readfile (__DIR__ . "/" . $page . ".navi.tpl"); ?>
    </div>
  </div>
  <div id="content-wrapper">
    <div id="content">
      <?php @readfile (__DIR__ . "/" . $page . ".content.tpl"); ?>
    </div>
  </div>
  <footer>
    <p>Check out these resources and follow the Vala project across social media!</p>
    <ul>
      <li><a href="https://vala.dev/" target="_blank" title="Vala Official Website"><svg xmlns="http://www.w3.org/2000/svg" class="social-link" width="1.27em" height="1em" viewBox="0 0 1664 1312"><path fill="currentColor" d="M1408 768v480q0 26-19 45t-45 19H960V928H704v384H320q-26 0-45-19t-19-45V768q0-1 .5-3t.5-3l575-474l575 474q1 2 1 6m223-69l-62 74q-8 9-21 11h-3q-13 0-21-7L832 200L140 777q-12 8-24 7q-13-2-21-11l-62-74q-8-10-7-23.5T37 654L756 55q32-26 76-26t76 26l244 204V64q0-14 9-23t23-9h192q14 0 23 9t9 23v408l219 182q10 8 11 21.5t-7 23.5"/></svg></a>
      <li><a href="https://discourse.gnome.org/tag/vala" target="_blank" title="Discourse (Forums)"><svg xmlns="http://www.w3.org/2000/svg" class="social-link" width="0.88em" height="1em" viewBox="0 0 448 512"><path fill="currentColor" d="M225.9 32C103.3 32 0 130.5 0 252.1C0 256 .1 480 .1 480l225.8-.2c122.7 0 222.1-102.3 222.1-223.9C448 134.3 348.6 32 225.9 32M224 384c-19.4 0-37.9-4.3-54.4-12.1L88.5 392l22.9-75c-9.8-18.1-15.4-38.9-15.4-61c0-70.7 57.3-128 128-128s128 57.3 128 128s-57.3 128-128 128"/></svg></a>
      <li><a href="https://matrix.to/#/#vala:gnome.org" target="_blank" title="Matrix"><svg xmlns="http://www.w3.org/2000/svg" class="social-link" width="1.13em" height="1em" viewBox="0 0 1728 1536"><path fill="currentColor" d="m959 896l64-256H769l-64 256zm768-504l-56 224q-7 24-31 24h-327l-64 256h311q15 0 25 12q10 14 6 28l-56 224q-5 24-31 24h-327l-81 328q-7 24-31 24H841q-16 0-26-12q-9-12-6-28l78-312H633l-81 328q-7 24-31 24H296q-15 0-25-12q-9-12-6-28l78-312H32q-15 0-25-12q-9-12-6-28l56-224q7-24 31-24h327l64-256H168q-15 0-25-12q-10-14-6-28l56-224q5-24 31-24h327l81-328q7-24 32-24h224q15 0 25 12q9 12 6 28l-78 312h254l81-328q7-24 32-24h224q15 0 25 12q9 12 6 28l-78 312h311q15 0 25 12q9 12 6 28"/></svg></a>
      <li><a href="https://discord.gg/YFAzjSVHt7" target="_blank" title="Discord"><svg xmlns="http://www.w3.org/2000/svg" class="social-link" width="1.25em" height="1em" viewBox="0 0 640 512"><path fill="currentColor" d="M524.531 69.836a1.5 1.5 0 0 0-.764-.7A485.065 485.065 0 0 0 404.081 32.03a1.816 1.816 0 0 0-1.923.91a337.461 337.461 0 0 0-14.9 30.6a447.848 447.848 0 0 0-134.426 0a309.541 309.541 0 0 0-15.135-30.6a1.89 1.89 0 0 0-1.924-.91a483.689 483.689 0 0 0-119.688 37.107a1.712 1.712 0 0 0-.788.676C39.068 183.651 18.186 294.69 28.43 404.354a2.016 2.016 0 0 0 .765 1.375a487.666 487.666 0 0 0 146.825 74.189a1.9 1.9 0 0 0 2.063-.676A348.2 348.2 0 0 0 208.12 430.4a1.86 1.86 0 0 0-1.019-2.588a321.173 321.173 0 0 1-45.868-21.853a1.885 1.885 0 0 1-.185-3.126a251.047 251.047 0 0 0 9.109-7.137a1.819 1.819 0 0 1 1.9-.256c96.229 43.917 200.41 43.917 295.5 0a1.812 1.812 0 0 1 1.924.233a234.533 234.533 0 0 0 9.132 7.16a1.884 1.884 0 0 1-.162 3.126a301.407 301.407 0 0 1-45.89 21.83a1.875 1.875 0 0 0-1 2.611a391.055 391.055 0 0 0 30.014 48.815a1.864 1.864 0 0 0 2.063.7A486.048 486.048 0 0 0 610.7 405.729a1.882 1.882 0 0 0 .765-1.352c12.264-126.783-20.532-236.912-86.934-334.541M222.491 337.58c-28.972 0-52.844-26.587-52.844-59.239s23.409-59.241 52.844-59.241c29.665 0 53.306 26.82 52.843 59.239c0 32.654-23.41 59.241-52.843 59.241m195.38 0c-28.971 0-52.843-26.587-52.843-59.239s23.409-59.241 52.843-59.241c29.667 0 53.307 26.82 52.844 59.239c0 32.654-23.177 59.241-52.844 59.241"/></svg></a>
      <li><a href="https://mastodon.social/@vala_lang" target="_blank" title="Mastodon"><svg xmlns="http://www.w3.org/2000/svg" class="social-link" width="0.88em" height="1em" viewBox="0 0 448 512"><path fill="currentColor" d="M433 179.11c0-97.2-63.71-125.7-63.71-125.7c-62.52-28.7-228.56-28.4-290.48 0c0 0-63.72 28.5-63.72 125.7c0 115.7-6.6 259.4 105.63 289.1c40.51 10.7 75.32 13 103.33 11.4c50.81-2.8 79.32-18.1 79.32-18.1l-1.7-36.9s-36.31 11.4-77.12 10.1c-40.41-1.4-83-4.4-89.63-54a102.54 102.54 0 0 1-.9-13.9c85.63 20.9 158.65 9.1 178.75 6.7c56.12-6.7 105-41.3 111.23-72.9c9.8-49.8 9-121.5 9-121.5m-75.12 125.2h-46.63v-114.2c0-49.7-64-51.6-64 6.9v62.5h-46.33V197c0-58.5-64-56.6-64-6.9v114.2H90.19c0-122.1-5.2-147.9 18.41-175c25.9-28.9 79.82-30.8 103.83 6.1l11.6 19.5l11.6-19.5c24.11-37.1 78.12-34.8 103.83-6.1c23.71 27.3 18.4 53 18.4 175z"/></svg></a>
      <li><a href="https://www.reddit.com/r/vala/" target="_blank" title="Reddit"><svg xmlns="http://www.w3.org/2000/svg" class="social-link" width="1em" height="1em" viewBox="0 0 1792 1792"><path fill="currentColor" d="M1095 1167q16 16 0 31q-62 62-199 62t-199-62q-16-15 0-31q6-6 15-6t15 6q48 49 169 49q120 0 169-49q6-6 15-6t15 6M788 986q0 37-26 63t-63 26t-63.5-26t-26.5-63q0-38 26.5-64t63.5-26t63 26.5t26 63.5m395 0q0 37-26.5 63t-63.5 26t-63-26t-26-63t26-63.5t63-26.5t63.5 26t26.5 64m251-120q0-49-35-84t-85-35t-86 36q-130-90-311-96l63-283l200 45q0 37 26 63t63 26t63.5-26.5T1359 448t-26.5-63.5T1269 358q-54 0-80 50l-221-49q-19-5-25 16l-69 312q-180 7-309 97q-35-37-87-37q-50 0-85 35t-35 84q0 35 18.5 64t49.5 44q-6 27-6 56q0 142 140 243t337 101q198 0 338-101t140-243q0-32-7-57q30-15 48-43.5t18-63.5m358 30q0 182-71 348t-191 286t-286 191t-348 71t-348-71t-286-191t-191-286T0 896t71-348t191-286T548 71T896 0t348 71t286 191t191 286t71 348"/></svg></a>
      <li><a href="/markup.htm" title="Markup Info"><svg xmlns="http://www.w3.org/2000/svg" class="social-link" width="1em" height="1em" viewBox="0 0 1536 1536"><path fill="currentColor" d="M1024 1248v-160q0-14-9-23t-23-9h-96V544q0-14-9-23t-23-9H544q-14 0-23 9t-9 23v160q0 14 9 23t23 9h96v320h-96q-14 0-23 9t-9 23v160q0 14 9 23t23 9h448q14 0 23-9t9-23M896 352V192q0-14-9-23t-23-9H672q-14 0-23 9t-9 23v160q0 14 9 23t23 9h192q14 0 23-9t9-23m640 416q0 209-103 385.5T1153.5 1433T768 1536t-385.5-103T103 1153.5T0 768t103-385.5T382.5 103T768 0t385.5 103T1433 382.5T1536 768"/></svg></a>
    </ul>
    <p>Copyright © <?php echo date('Y'); ?> Valadoc.org | Documentation is licensed under the same terms as its upstream |
    <a href="https://github.com/vala-lang/valadoc-org/issues" target="_blank">Report an Issue</a></p>
  </footer>
  <script type="text/javascript" src="/scripts/fetch.js"></script>
  <script type="text/javascript" src="/scripts/valadoc.js"></script>
  <script type="text/javascript" src="/scripts/main.js"></script>
</body>
</html>
