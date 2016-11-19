<?php

$FWD_TOOLTIP = getenv('FWD_TOOLTIP');
if (!empty($FWD_TOOLTIP)) {
  $url = 'https://valadoc.org/tooltip.php?fullname=' . urlencode($_GET['fullname']);
  $curl = curl_init($url);
  curl_exec($curl);
  curl_close($curl);
  return;
}

include 'constants.php';

function strip_links ($str) {
		if ($str === '' || $str === null) {
				return '';
		}

		$dom = new DOMDocument();
        $dom->loadHTML($str);
        $xpath = new DOMXPath($dom);
        foreach ($xpath->query('//a | //body | //html') as $link) {
                while($link->hasChildNodes()) {
                        $child = $link->removeChild($link->firstChild);
                        $link->parentNode->insertBefore($child, $link);
                }
                $link->parentNode->removeChild($link);
        }

        $arr = explode ("\n", $dom->saveXML(), 2);
        return $arr[1];
}



$fullname = str_replace ('@', '', $_GET['fullname']);
$splitted = explode ('/', $fullname);
$pkg = $splitted[0];
if (preg_match ("/[^+0-9A-Za-z.-]/", $pkg))
  die ("invalid");

$name = $splitted[1];
$namelen = strlen($name);
$index = str_replace('.', '', str_replace ('-', '', str_replace ('+', '', $prefix.$pkg)));

$name = str_replace (".", " << . << ", $name);
$name = $mysqli->real_escape_string ($name);
if (!($q = $mysqli->query("SELECT type, name, shortdesc, path, signature, namelen FROM {$index} WHERE MATCH('{$name}') AND namelen={$namelen} LIMIT 1 OPTION max_matches=1,ranker=none")))
  die("Query failed: (" . $mysqli->errno . ") " . $mysqli->error);

$row = $q->fetch_assoc ();
if ($row) {
  echo '<p>' . strip_links ($row['signature']) . '</p>';
  echo strip_links ($row['shortdesc']);
} else {
  echo "no result";
}

$q->close ();
$mysqli->close ();

?>
