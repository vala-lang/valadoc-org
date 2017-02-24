<?php

$FWD_TOOLTIP = getenv('FWD_TOOLTIP');
if (!empty($FWD_TOOLTIP)) {
  $curl = curl_init();
  curl_setopt_array($curl, [
    CURLOPT_URL => 'https://valadoc.org/search.php',
    CURLOPT_POST => true,
    CURLOPT_POSTFIELDS => $_POST,
  ]);
  curl_exec($curl);
  curl_close($curl);
  return;
}

include 'constants.php';

function escapestring($str) {
  $from = array ( '\\', '(',')','|','-','!','@','~','"','&', '/', '^', '$', '=' );
  $to   = array ( '\\\\', '\(','\)','\|','\-','\!','\@','\~','\"', '\&', '\/', '\^', '\$', '\=' );
  return str_replace ($from, $to, $str);
}

$query = $_POST["query"];
$curpkg = trim($_POST["curpkg"]);
$offset = 0;
if (isset ($_POST["offset"])) {
  $offset = intval ($_POST["offset"]);
}

$trimmedquery = trim($query);
$query = trim($trimmedquery, ".");
$tokens = preg_split ("/([\s.])/", $query, -1, PREG_SPLIT_DELIM_CAPTURE | PREG_SPLIT_NO_EMPTY);
foreach ($tokens as &$token) {
  if (trim($token) != "") {
    if ($token == ".") {
      $token = "<< . <<";
    } else {
      $token = "*".escapestring($token)."*";
    }
  }
}
$query = implode (" ", $tokens);
if ($trimmedquery[0] == '.') {
  $query = ". << ".$query;
}
if ($trimmedquery[strlen($trimmedquery)-1] == '.') {
  $query = $query." << .";
}

$orderby = null;
if (strpos ($trimmedquery, ".") !== false || strpos ($trimmedquery, " ") !== false) {
  $query = "@ftsname ".$query;
  $orderby = "namelen";
} else {
  $query = "@shortname ".$query;
  $orderby = "shortnamelen";
}

$indexweights = '';
if ($curpkg != '') {
  if (preg_match ("/[^+0-9A-Za-z.-]/", $curpkg))
    die ("invalid curpkg");

  $curindex = str_replace('.', '', str_replace ('-', '', str_replace ('+', '', $curpkg)));
  $indexweights = ",index_weights=({$curindex}=2)";
}

$query = $mysqli->real_escape_string ($query);

$qq = "SELECT type, name, path, signature, type, typeorder,
       {$orderby}
       FROM {$allpkgs}
       WHERE MATCH('{$query}')
       ORDER BY WEIGHT() DESC, {$orderby} ASC, typeorder ASC
       LIMIT {$offset},20 OPTION ranker=proximity{$indexweights}";

if (!($q = $mysqli->query($qq)))
  die("Query failed: (" . $mysqli->errno . ") " . $mysqli->error);

while ($row = $q->fetch_assoc()) {
  $splitted = explode ("/", $row["path"]);
  $pkg = $splitted[1];
  $class = strtolower($row["type"]);

  echo '<li class="search-result '.$class.'"><a href="'.$row["path"].'">';
  echo '<span class="search-name">'.$row["name"].' <span class="search-package">('.$pkg.')</span></span>';
  echo '</a></li>';
}

$q->close ();
$mysqli->close ();

?>
