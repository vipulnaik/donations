<?php
include_once('doctype.inc');
print '<script src="change-theme.js"></script>';
include_once("backend/globalVariables/passwordFile.inc");
include_once("backend/globalVariables/lists.inc");
$donor = 'Vipul Naik';
if (!empty($_REQUEST['donor'])) {
  $donor = $_REQUEST['donor'];
}

// If the current $donor is an alias (e.g. is a former name of an organization)
// then redirect to the correct location.
$query = "select donor from donors where other_names REGEXP ?";
$stmt = $mysqli->prepare($query);
$exactMatchRegex = '(^|\\|)'.$donor.'(\\||$)';
$stmt->bind_param("s", $exactMatchRegex);
$stmt->execute();
$result = $stmt->get_result();
if ($result->num_rows > 0) {
  $row = $result->fetch_assoc();
  $donorCanonicalName = $row['donor'];
  $url_params = array();
  parse_str($_SERVER['QUERY_STRING'], $url_params);
  $url_params['donor'] = $donorCanonicalName;
  header("Location: " . $_SERVER['SCRIPT_NAME'] . '?' . http_build_query($url_params));
  die();
}

$causeAreaFilterString = '';
$causeAreaFilterStringHelper = '';
if (!empty($_REQUEST['cause_area_filter'])) {
  $causeAreaFilterString = $_REQUEST['cause_area_filter'];
  $causeAreaFilterStringHelper = " (filtered to cause areas matching $causeAreaFilterString)";
}
print "<title>$donor donations made $causeAreaFilterStringHelper</title>";
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
        $("#myTableDonorInfo").tablesorter({textExtraction: stripCommas});
        $("#myTableDonorStatistics").tablesorter({textExtraction: stripCommas});
        $("#myTableDonorDonationAmountsByDoneeAndYear").tablesorter({textExtraction: stripCommas});
        $("#myTableDonorDonationAmountsByCauseAreaAndYear").tablesorter({textExtraction: stripCommas});
        $("#myTableDonorDonationAmountsByInfluencerAndYear").tablesorter({textExtraction: stripCommas});
        $("#myTableDonorDonationAmountsByCountryAndYear").tablesorter({textExtraction: stripCommas});
        $("#myTableDonorDonationAmountsByDisclosuresAndYear").tablesorter({textExtraction: stripCommas});
        $("#myTableDonorDocumentList").tablesorter({textExtraction: stripCommas});
        $("#myTableDonorDonationList").tablesorter({textExtraction: stripCommas});
        $("#myTableDonorSimilarDonors").tablesorter({textExtraction: stripCommas});
    }
); </script>'."\n";
print "<h3>$donor donations made $causeAreaFilterStringHelper</h3>";
?>

<p><span id="changeThemeMenu" style="display: none;">Set color scheme to:
         <span id="auto-menu-option" style="cursor: pointer;" class="unselectable" onclick="change_theme.set_color('auto')">auto</span>,
         <span id="light-menu-option" style="cursor: pointer;" class="unselectable" onclick="change_theme.set_color('light')">light</span>,
         <span id="dark-menu-option" style="cursor: pointer;" class="unselectable" onclick="change_theme.set_color('dark')">dark</span>
</span>&thinsp;<!-- blank space to prevent cumulative layout shift --></p>
<script>change_theme.set_theme_from_local_storage();</script>

<?php
include_once('preamble.inc');
print '<h4>Table of contents</h4>';
print '<ul>';
print '<li><a href="#donorInfo">Basic donor info</a></li>';
print '<li><a href="#donorStatistics">Donor statistics</a></li>';
print '<li><a href="#donorDonationAmountsByCauseAreaAndYear">Donor donation amounts by cause area and year</a></li>';
print '<li><a href="#donorDonationAmountsBySubcauseAreaAndYear">Donor donation amounts by subcause area and year</a></li>';
print '<li><a href="#donorDonationAmountsByDoneeAndYear">Donor donation amounts by donee and year</a></li>';
print '<li><a href="#donorDonationAmountsByInfluencerAndYear">Donor donation amounts by influencer and year</a></li>';
print '<li><a href="#donorDonationAmountsByCountryAndYear">Donor donation amounts by country and year</a></li>';
print '<li><a href="#donorDonationAmountsByDisclosuresAndYear">Donor donation amounts by disclosures and year</a></li>';
print '<li><a href="#donorDocumentList">Donor document list</a></li>';
print '<li><a href="#donorDonationList">Donor donation list</a></li>';
print '<li><a href="#donorSimilarDonors">Similar donors</a></li>';
print '</ul>';

$cache_location = "cache/" . md5($_SERVER['REQUEST_URI']) . ".html";
if (needToRegenerate($cache_location)) {
  ob_start();
  include_once('backend/yearlyGraph.inc');
  include_once('backend/yearlyGroupings.inc');
  include_once('backend/yearlyDisclosures.inc');
  include ("backend/donorInfo.inc");
  include ("backend/donorStatistics.inc");
  include ("backend/donorDonationAmountsByCauseAreaAndYear.inc");
  include ("backend/donorDonationAmountsBySubcauseAreaAndYear.inc");
  include ("backend/donorDonationAmountsByDoneeAndYear.inc");
  include ("backend/donorDonationAmountsByInfluencerAndYear.inc");
  include ("backend/donorDonationAmountsByDisclosuresAndYear.inc");
  include ("backend/donorDonationAmountsByCountryAndYear.inc");
  include ("backend/donorDocumentList.inc");
  include ("backend/donorDonationList.inc");
  include ("backend/donorSimilarDonors.inc");
  $output = ob_get_clean();
  file_put_contents($cache_location, $output);
}
include($cache_location);
include_once('anchorjs.inc');
print '</body>';
?>
