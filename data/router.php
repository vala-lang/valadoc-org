<?php
// NOTE: ONLY FOR DEVELOPMENT! DO NOT USE IN PRODUCTION

//	ini_set("display_errors","1");
//	ERROR_REPORTING(E_ALL);

// If the file exists, return it!
$requestUri = parse_url($_SERVER["REQUEST_URI"], PHP_URL_PATH);

if ($requestUri === '' || $requestUri === '/') {
    include __DIR__."/index.php";
} else if (file_exists(__DIR__."/".$requestUri)) {
    return false;
} else {
    include __DIR__."/index.php";
}
