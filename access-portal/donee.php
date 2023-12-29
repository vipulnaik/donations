<?php
include_once('doctype.inc');
print '<script src="change-theme.js"></script>';
include_once("backend/globalVariables/passwordFile.inc");
include_once("backend/globalVariables/lists.inc");
$donee = 'Vipul Naik';
if (!empty($_REQUEST['donee'])) {
  $donee = $_REQUEST['donee'];
}

// If the current $donee is an alias (e.g. is a former name of an organization)
// then redirect to the correct location.
$query = "select donee from donees where other_names REGEXP ?";
$stmt = $mysqli->prepare($query);
$exactMatchRegex = '(^|\\|)'.$donee.'(\\||$)';
$stmt->bind_param("s", $exactMatchRegex);
$stmt->execute();
$result = $stmt->get_result();
if ($result->num_rows > 0) {
  $row = $result->fetch_assoc();
  $doneeCanonicalName = $row['donee'];
  $url_params = array();
  parse_str($_SERVER['QUERY_STRING'], $url_params);
  $url_params['donee'] = $doneeCanonicalName;
  header("Location: " . $_SERVER['SCRIPT_NAME'] . '?' . http_build_query($url_params));
  die();
}

print "<title>$donee donations received</title>";
include_once('analytics.inc');
include_once('strip-commas.inc');
include_once('backend/stringFunctions.inc');
include_once('backend/cachingFunctions.inc');
print '<link href="style.css" rel="stylesheet" type="text/css" />'."\n";
include_once("style.inc");
print '<script type="text/javascript" src="./jquery-3.7.1.min.js"></script>'."\n";
print '<script type="text/javascript" src="./jquery.tablesorter.js"></script>'."\n";
print '</head>';
print '<body>';
print '<script>$(document).ready(function()
    {
        $("#myTableDoneeInfo").tablesorter({textExtraction: stripCommas});
        $("#myTableDoneeStatistics").tablesorter({textExtraction: stripCommas});
        $("#myTableDoneeDonationAmountsByDonorAndYear").tablesorter({textExtraction: stripCommas});
        $("#myTableDoneeDocumentList").tablesorter({textExtraction: stripCommas});
        $("#myTableDoneeDonationList").tablesorter({textExtraction: stripCommas});
    }
); </script>'."\n";
print "<h3>$donee donations received</h3>";
print '<p><span id="changeThemeMenu" style="display: none;">Change <a href="javascript:;" onclick="change_theme_color()">color</a></span>   &thinsp;<!-- blank space to prevent cumulative layout shift --></p>';
include_once('preamble.inc');
print '<h4>Table of contents</h4>';
print '<ul>';
print '<li><a href="#doneeInfo">Basic donee information</a></li>';
print '<li><a href="#doneeStatistics">Donee donation statistics</a></li>';
print '<li><a href="#doneeDonationAmountsByDonorAndYear">Donee donation amounts by donor and year</a></li>';
print '<li><a href="#doneeDocumentList">Donee document list</a></li>';
print '<li><a href="#doneeDonationList">Donee donation list</a></li>';
print '</ul>';

$cache_location = "cache/" . md5($_SERVER['REQUEST_URI']) . ".html";
if (needToRegenerate($cache_location)) {
  ob_start();
  include ("backend/doneeInfo.inc");
  include ("backend/doneeStatistics.inc");
  include ("backend/doneeDonationAmountsByDonorAndYear.inc");
  include ("backend/doneeDocumentList.inc");
  include ("backend/doneeDonationList.inc");
  $output = ob_get_clean();
  file_put_contents($cache_location, $output);
}
include($cache_location);

include_once("anchorjs.inc");

print '</body>';
?>
