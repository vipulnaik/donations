<?php
print '<!doctype html public "-//W3C//DTD HTML 4.01 Transitional//EN"><html><head><meta http-equiv="Content-Type" content="text/html;charset=utf-8" >';
$donee = 'Vipul Naik';
if (!empty($_REQUEST['donee'])) {
  $donee = $_REQUEST['donee'];
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
        $("#myTableDoneeInfo").tablesorter();
        $("#myTableDoneeDonationAmountsByDonorAndYear").tablesorter();
    }
); </script>'."\n";
print '<h3>Donations recorded by Vipul Naik for donee '.$donee.'</h3>';
include_once('preamble.inc');
print '<h4>Table of contents</h4>';
print '<ul>';
print '<li><a href="#doneeInfo">Basic donee information</a></li>';
print '<li><a href="#doneeDonationAmountsByDonorAndYear">Donee donation amounts by donor and year</a></li>';
print '</ul>';

include ("backend/doneeInfo.inc");
include ("backend/doneeDonationAmountsByDonorAndYear.inc");

print '</body>';
?>
