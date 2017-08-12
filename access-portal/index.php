<?php
print '<!doctype html public "-//W3C//DTD HTML 4.01 Transitional//EN"><html><head><meta http-equiv="Content-Type" content="text/html;charset=utf-8" >';
include_once('analytics.inc');
include_once('strip-commas.inc');
include_once('backend/stringFunctions.inc');
$causeAreaFilterString = '';
$causeAreaFilterStringHelper = '';
$causeAreaFilterQueryComponent = "";
if (!empty($_REQUEST['cause_area_filter'])) {
  $causeAreaFilterString = $_REQUEST['cause_area_filter'];
  $causeAreaFilterStringHelper = " (filtered to cause areas matching $causeAreaFilterString)";
  $causeAreaFilterQueryComponent = " where cause_area REGEXP '$causeAreaFilterString' ";
}
print "<title>Donations recorded by Vipul Naik $causeAreaFilterStringHelper</title>";
print '<link href="style.css" rel="stylesheet" type="text/css" />'."\n";
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
    }
); </script>'."\n";
print "<h3>Donations recorded by Vipul Naik $causeAreaFilterStringHelper</h3>";
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

include_once('backend/yearlyGraph.inc');
include_once('backend/yearlyGroupings.inc');
include_once('backend/yearlyDisclosures.inc');
include ("backend/donationAmountsByCauseAreaAndYear.inc");
include ("backend/donationAmountsByDonorAndYear.inc");
include ("backend/donationAmountsByDoneeAndYear.inc");
include ("backend/donationAmountsByInfluencerAndYear.inc");
include ("backend/donationAmountsByCountryAndYear.inc");
include ("backend/donationAmountsByDisclosuresAndYear.inc");

print '</body>';
?>
