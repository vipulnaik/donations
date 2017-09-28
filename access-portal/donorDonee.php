<?php
print '<!doctype html public "-//W3C//DTD HTML 4.01 Transitional//EN"><html><head><meta http-equiv="Content-Type" content="text/html;charset=utf-8" >';
$donor = 'Vipul Naik';
if (!empty($_REQUEST['donor'])) {
  $donor = $_REQUEST['donor'];
}
$donee = 'GiveDirectly';
if (!empty($_REQUEST['donee'])) {
  $donee = $_REQUEST['donee'];
}

print "<title>$donor donations made to $donee $causeAreaFilterStringHelper</title>";
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
        $("table").tablesorter({textExtraction: stripCommas});
    }
); </script>'."\n";
print "<h3>$donor donations made to $donee $causeAreaFilterStringHelper</h3>";
include_once('preamble.inc');
print '<h4>Table of contents</h4>';
print '<ul>';
print '<li><a href="#donorInfo">Basic donor info</a></li>';
print '<li><a href="#doneeInfo">Basic donee info</a></li>';
print '<li><a href="#donorDocumentList">Donor document list</a></li>';
print '<li><a href="#donorDonationList">Donor donation list</a></li>';
print '</ul>';

include ("backend/donorInfo.inc");
include ("backend/doneeInfo.inc");
include ("backend/donorDoneeDonationList.inc");

print '</body>';
?>
