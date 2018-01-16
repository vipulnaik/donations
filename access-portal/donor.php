<?php
include_once('doctype.inc');
$donor = 'Vipul Naik';
if (!empty($_REQUEST['donor'])) {
  $donor = $_REQUEST['donor'];
}
$causeAreaFilterString = '';
$causeAreaFilterStringHelper = '';
$causeAreaFilterQueryComponent = "";
if (!empty($_REQUEST['cause_area_filter'])) {
  $causeAreaFilterString = $_REQUEST['cause_area_filter'];
  $causeAreaFilterStringHelper = " (filtered to cause areas matching $causeAreaFilterString)";
  $causeAreaFilterQueryComponent = " and cause_area REGEXP ".'"'.str_replace('"','\"',$causeAreaFilterString).'" ';
}
print "<title>$donor donations made $causeAreaFilterStringHelper</title>";
include_once('analytics.inc');
include_once('strip-commas.inc');
include_once('backend/stringFunctions.inc');
print '<link href="style.css" rel="stylesheet" type="text/css" />'."\n";
print '<script type="text/javascript" src="./jquery-3.1.1.min.js"></script>'."\n";
print '<script type="text/javascript" src="./jquery.tablesorter.js"></script>'."\n";
print '</head>';
include_once("backend/globalVariables/passwordFile.inc");
include_once("backend/globalVariables/lists.inc");
print '<body>';
print '<script>$(document).ready(function()
    {
        $("#myTableDonorInfo").tablesorter({textExtraction: stripCommas});
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
include_once('preamble.inc');
print '<h4>Table of contents</h4>';
print '<ul>';
print '<li><a href="#donorInfo">Basic donor info</a></li>';
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

include_once('backend/yearlyGraph.inc');
include_once('backend/yearlyGroupings.inc');
include_once('backend/yearlyDisclosures.inc');
include ("backend/donorInfo.inc");
include ("backend/donorDonationAmountsByCauseAreaAndYear.inc");
include ("backend/donorDonationAmountsBySubcauseAreaAndYear.inc");
include ("backend/donorDonationAmountsByDoneeAndYear.inc");
include ("backend/donorDonationAmountsByInfluencerAndYear.inc");
include ("backend/donorDonationAmountsByDisclosuresAndYear.inc");
include ("backend/donorDonationAmountsByCountryAndYear.inc");
include ("backend/donorDocumentList.inc");
include ("backend/donorDonationList.inc");
include ("backend/donorSimilarDonors.inc");
include_once('anchorjs.inc');
print '</body>';
?>
