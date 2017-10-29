<?php
include_once('doctype.inc');
$donor = 'Vipul Naik';
if (!empty($_REQUEST['donor'])) {
  $donor = $_REQUEST['donor'];
}
$donee = 'GiveDirectly';
if (!empty($_REQUEST['donee'])) {
  $donee = $_REQUEST['donee'];
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
include_once('backend/yearlyGraph.inc');
print '<link href="style.css" rel="stylesheet" type="text/css" />'."\n";
print '<script type="text/javascript" src="./jquery-3.1.1.min.js"></script>'."\n";
print '<script type="text/javascript" src="./jquery.tablesorter.js"></script>'."\n";
print '</head>';
include_once("backend/globalVariables/passwordFile.inc");
include_once("backend/globalVariables/lists.inc");
print '<body>';
print '<script>$(document).ready(function()
    {
        $("table").tablesorter({textExtraction: stripCommas});
    }
); </script>'."\n";
print "<h3>$donor donations made to $donee"
  . ($causeAreaFilterString ? " (filtered to cause areas matching $causeAreaFilterString)" : '')
 . "</h3>";
include_once('preamble.inc');
print '<h4>Table of contents</h4>';
print '<ul>';
print '<li><a href="#donorInfo">Basic donor info</a></li>';
print '<li><a href="#doneeInfo">Basic donee info</a></li>';
print '<li><a href="#donorDoneeDonationAmountsByCauseAreaAndYear">Donation amounts by cause area and year</a></li>';
print '<li><a href="#donorDoneeDonationList">Donor donation list</a></li>';
print '<li><a href="#donorDoneeDocumentList">Donor document list</a></li>';
print '</ul>';

include ("backend/donorInfo.inc");
print '<p><a href="/donor.php?donor='.urlencode($donor).'">Full donor page for donor $donor</a></p>'."\n";
include ("backend/doneeInfo.inc");
print '<p><a href="/donee.php?donee='.urlencode($donee).'">Full donee page for donee $donee</a></p>'."\n";
include ("backend/donorDoneeDonationAmountsByCauseAreaAndYear.inc");
include ("backend/donorDoneeDonationList.inc");
include ("backend/donorDoneeDocumentList.inc");

include_once("anchorjs.inc");
print '</body>';
?>
