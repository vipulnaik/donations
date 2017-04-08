<?php
print '<!doctype html public "-//W3C//DTD HTML 4.01 Transitional//EN"><html><head><meta http-equiv="Content-Type" content="text/html;charset=utf-8" >';
print '<title>Donations recorded by Vipul Naik</title>';
include_once('analytics.inc');
include_once('backend/stringFunctions.inc');
$causeAreaFilterString = '';
$causeAreaFilterStringHelper = '';
$causeAreaFilterQueryComponent = "";
if (!empty($_REQUEST['cause_area_filter'])) {
  $causeAreaFilterString = $_REQUEST['cause_area_filter'];
  $causeAreaFilterStringHelper = " (filtered to cause areas matching $causeAreaFilterStringHelper)";
  $causeAreaFilterQueryComponent = " where cause_area REGEXP '$causeAreaFilterString' ";
}
print '<link href="style.css" rel="stylesheet" type="text/css" />'."\n";
print '<script type="text/javascript" src="./jquery-3.1.1.min.js"></script>'."\n";
print '<script type="text/javascript" src="./jquery.tablesorter.js"></script>'."\n";
print '</head>';
include_once("backend/globalVariables/passwordFile.inc");
print '<body>';
print '<script>$(document).ready(function()
    {
        $("#myTableDonationAmountsByCauseAreaAndYear").tablesorter();
        $("#myTableDonationAmountsByDonorAndYear").tablesorter();	
        $("#myTableDonationAmountsByDoneeAndYear").tablesorter();	
    }
); </script>'."\n";
print '<h3>Donations recorded for Vipul Naik</h3>';
include_once('preamble.inc');
print '<h4>Table of contents</h4>';
print '<ul>';
print '<li><a href="#donationAmountsByCauseAreaAndYear">Donation amounts by cause area and year</a></li>';
print '<li><a href="#donationAmountsByDonorAndYear">Donation amounts by donor and year</a></li>';
print '<li><a href="#donationAmountsByDoneeAndYear">Donation amounts by donee and year</a></li>';
print '</ul>';

include ("backend/donationAmountsByCauseAreaAndYear.inc");
include ("backend/donationAmountsByDonorAndYear.inc");
include ("backend/donationAmountsByDoneeAndYear.inc");

print '</body>';
?>
