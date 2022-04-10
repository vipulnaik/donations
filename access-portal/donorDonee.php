<?php
include_once('doctype.inc');
print '<script src="change-theme.js"></script>';
include_once("backend/globalVariables/passwordFile.inc");
include_once("backend/globalVariables/lists.inc");
$donor = 'Vipul Naik';
if (!empty($_REQUEST['donor'])) {
  $donor = $_REQUEST['donor'];
}
$donee = 'GiveDirectly';
if (!empty($_REQUEST['donee'])) {
  $donee = $_REQUEST['donee'];
}

// If the current $donor or $donee is an alias (e.g. is a former name of an
// organization) then redirect to the correct location.
$query = "select donor from donors where other_names REGEXP ?";
$stmt = $mysqli->prepare($query);
$exactMatchRegex = '(^|\\|)'.$donor.'(\\||$)';
$stmt->bind_param("s", $exactMatchRegex);
$stmt->execute();
$result = $stmt->get_result();
$donorCanonicalName = "";
if ($result->num_rows > 0) {
  $row = $result->fetch_assoc();
  $donorCanonicalName = $row['donor'];
}
$query = "select donee from donees where other_names REGEXP ?";
$stmt = $mysqli->prepare($query);
$exactMatchRegex = '(^|\\|)'.$donee.'(\\||$)';
$stmt->bind_param("s", $exactMatchRegex);
$stmt->execute();
$result = $stmt->get_result();
$doneeCanonicalName = "";
if ($result->num_rows > 0) {
  $row = $result->fetch_assoc();
  $doneeCanonicalName = $row['donee'];
}
if ($donorCanonicalName || $doneeCanonicalName) {
  $url_params = array();
  parse_str($_SERVER['QUERY_STRING'], $url_params);
  if ($donorCanonicalName) {
    $url_params['donor'] = $donorCanonicalName;
  }
  if ($doneeCanonicalName) {
    $url_params['donee'] = $doneeCanonicalName;
  }
  header("Location: " . $_SERVER['SCRIPT_NAME'] . '?' . http_build_query($url_params));
  die();
}

if (!empty($_REQUEST['cause_area_filter'])) {
  $causeAreaFilterString = $_REQUEST['cause_area_filter'];
} else {
  $causeAreaFilterString = '';
}

print "<title>$donor donations made to $donee"
  . ($causeAreaFilterString ? " (filtered to cause areas matching $causeAreaFilterString)" : '')
  . "</title>";
include_once('analytics.inc');
include_once('strip-commas.inc');
include_once('backend/stringFunctions.inc');
include_once('backend/cachingFunctions.inc');
include_once('backend/yearlyGraph.inc');
print '<link href="style.css" rel="stylesheet" type="text/css" />'."\n";
include_once("style.inc");
print '<script type="text/javascript" src="./jquery-3.1.1.min.js"></script>'."\n";
print '<script type="text/javascript" src="./jquery.tablesorter.js"></script>'."\n";
print '</head>';
print '<body>';
print '<script>$(document).ready(function()
    {
        $("table").tablesorter({textExtraction: stripCommas});
    }
); </script>'."\n";
print "<h3>$donor donations made to $donee"
  . ($causeAreaFilterString ? " (filtered to cause areas matching $causeAreaFilterString)" : '')
 . "</h3>";
print '<span id="changeThemeMenu" style="display: none;">Change <a href="#" onclick="change_theme_color()">color</a></span>';
include_once('preamble.inc');
print '<h4>Table of contents</h4>';
print '<ul>';
print '<li><a href="#donorInfo">Basic donor info</a></li>';
print '<li><a href="#doneeInfo">Basic donee info</a></li>';
print '<li><a href="#donorDoneeRelationship">Donor&ndash;donee relationship</a></li>';
print '<li><a href="#donorDoneeStatistics">Donor&ndash;donee donation statistics</a></li>';
print '<li><a href="#donorDoneeDonationAmountsByCauseAreaAndYear">Donation amounts by cause area and year</a></li>';
print '<li><a href="#donorDoneeDocumentList">Donor&ndash;donee document list</a></li>';
print '<li><a href="#donorDoneeDonationList">Donor&ndash;donee donation list</a></li>';
print '</ul>';

$cache_location = "cache/" . md5($_SERVER['REQUEST_URI']) . ".html";
if (needToRegenerate($cache_location)) {
  ob_start();
  include ("backend/donorInfo.inc");
  print '<p><a href="/donor.php?donor='.urlencode($donor).'">Full donor page for donor '.$donor.'</a></p>'."\n";
  include ("backend/doneeInfo.inc");
  print '<p><a href="/donee.php?donee='.urlencode($donee).'">Full donee page for donee '.$donee.'</a></p>'."\n";
  include ("backend/donorDoneeRelationship.inc");
  include ("backend/donorDoneeStatistics.inc");
  include ("backend/donorDoneeDonationAmountsByCauseAreaAndYear.inc");
  include ("backend/donorDoneeDocumentList.inc");
  include ("backend/donorDoneeDonationList.inc");
  $output = ob_get_clean();
  file_put_contents($cache_location, $output);
}
include($cache_location);

include_once("anchorjs.inc");
print '</body>';
?>
