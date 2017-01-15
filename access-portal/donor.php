<?php
print '<!doctype html public "-//W3C//DTD HTML 4.01 Transitional//EN"><html><head><meta http-equiv="Content-Type" content="text/html;charset=utf-8" >';
$donor = 'Vipul Naik';
if (!empty($_REQUEST['donor'])) {
  $donor = $_REQUEST['donor'];
}
print '<title>Donations recorded by Vipul Naik for donor '.$donor.'</title>';
include_once('analytics.inc');
print '<link href="style.css" rel="stylesheet" type="text/css" />'."\n";
print '<script type="text/javascript" src="./jquery-3.1.1.min.js"></script>'."\n";
print '<script type="text/javascript" src="./jquery.tablesorter.js"></script>'."\n";
print '</head>';
include_once("backend/globalVariables/passwordFile.inc");
print '<body>';
print '<script>$(document).ready(function()
    {
        $("#myTableDonorInfo").tablesorter();
        $("#myTableDonorDonationAmountsByDoneeAndYear").tablesorter();
    }
); </script>'."\n";
print '<h3>Donations recorded by Vipul Naik for donor '.$donor.'</h3>';
include_once('preamble.inc');
print '<h4>Table of contents</h4>';
print '<ul>';
print '<li><a href="#donorInfo">Basic donor info</a></li>';
print '<li><a href="#donorDonationAmountsByDoneeAndYear">Donor donation amounts by donee and year</a></li>';
print '</ul>';

include ("backend/donorInfo.inc");
include ("backend/donorDonationAmountsByDoneeAndYear.inc");

print '</body>';
?>
