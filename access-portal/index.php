<?php
include_once('doctype.inc');
include_once('analytics.inc');
print '<script src="change-theme.js"></script>';
include_once('strip-commas.inc');
include_once('backend/stringFunctions.inc');
include_once('backend/cachingFunctions.inc');
$causeAreaFilterString = '';
$causeAreaFilterStringHelper = '';
if (!empty($_REQUEST['cause_area_filter'])) {
  $causeAreaFilterString = $_REQUEST['cause_area_filter'];
  $causeAreaFilterStringHelper = " (filtered to cause areas matching $causeAreaFilterString)";
}
print "<title>Donations list website $causeAreaFilterStringHelper</title>";
print '<link href="style.css" rel="stylesheet" type="text/css" />'."\n";
include_once("style.inc");
print '<script type="text/javascript" src="./jquery-3.1.1.min.js"></script>'."\n";
print '<script type="text/javascript" src="./jquery.tablesorter.js"></script>'."\n";
print '</head>';
include_once("backend/globalVariables/passwordFile.inc");
include_once("backend/globalVariables/lists.inc");
print '<body>';
print '<script>$(document).ready(function()
    {
        $("#myTableDonationAmountsByCauseAreaAndYear").tablesorter({textExtraction: stripCommas});
        $("#myTableDonationAmountsByDonorAndYear").tablesorter({textExtraction: stripCommas});
        $("#myTableDonationAmountsByDoneeAndYear").tablesorter({textExtraction: stripCommas});
        $("#myTableDonationAmountsByInfluencerAndYear").tablesorter({textExtraction: stripCommas});
        $("#myTableDonationAmountsByCountryAndYear").tablesorter({textExtraction: stripCommas});
        $("#myTableDonationAmountsByDisclosuresAndYear").tablesorter({textExtraction: stripCommas});
    }
); </script>'."\n";
print "<h3>Donations recorded by Vipul Naik $causeAreaFilterStringHelper</h3>";
print '<p><span id="changeThemeMenu" style="display: none;">Change <a href="javascript:;" onclick="change_theme_color()">color</a></span>   &thinsp;<!-- blank space to prevent cumulative layout shift --></p>';
include_once('preamble.inc');
print '<h4>Table of contents</h4>';
print '<ul>';
print '<li><a href="#donationAmountsByCauseAreaAndYear">Donation amounts by cause area and year</a></li>';
print '<li><a href="#donationAmountsByDonorAndYear">Donation amounts by donor and year</a></li>';
print '<li><a href="#donationAmountsByDoneeAndYear">Donation amounts by donee and year</a></li>';
print '<li><a href="#donationAmountsByInfluencerAndYear">Donation amounts by influencer and year</a></li>';
print '<li><a href="#donationAmountsByCountryAndYear">Donation amounts by country and year</a></li>';
print '<li><a href="#donationAmountsByDisclosuresAndYear">Donation amounts by disclosures and year</a></li>';

print '</ul>';

$cache_location = "cache/" . md5($_SERVER['REQUEST_URI']) . ".html";
if (needToRegenerate($cache_location)) {
  ob_start();

  include_once('backend/yearlyGraph.inc');
  include_once('backend/yearlyGroupings.inc');
  include_once('backend/yearlyDisclosures.inc');
  include ("backend/donationAmountsByCauseAreaAndYear.inc");
  include ("backend/donationAmountsByDonorAndYear.inc");
  include ("backend/donationAmountsByDoneeAndYear.inc");
  include ("backend/donationAmountsByInfluencerAndYear.inc");
  include ("backend/donationAmountsByCountryAndYear.inc");

  $output = ob_get_clean();
  file_put_contents($cache_location, $output);
}
include($cache_location);

include_once("anchorjs.inc");
print '</body>';
?>
