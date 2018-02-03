<?php
include_once('doctype.inc');
$donee = 'Vipul Naik';
if (!empty($_REQUEST['donee'])) {
  $donee = $_REQUEST['donee'];
}
print "<title>$donee donations received</title>";
include_once('analytics.inc');
include_once('strip-commas.inc');
include_once('backend/stringFunctions.inc');
include_once('backend/cachingFunctions.inc');
print '<link href="style.css" rel="stylesheet" type="text/css" />'."\n";
print '<script type="text/javascript" src="./jquery-3.1.1.min.js"></script>'."\n";
print '<script type="text/javascript" src="./jquery.tablesorter.js"></script>'."\n";
print '</head>';
include_once("backend/globalVariables/passwordFile.inc");
include_once("backend/globalVariables/lists.inc");
print '<body>';
print '<script>$(document).ready(function()
    {
        $("#myTableDoneeInfo").tablesorter({textExtraction: stripCommas});
        $("#myTableDoneeDonationAmountsByDonorAndYear").tablesorter({textExtraction: stripCommas});
        $("#myTableDoneeDocumentList").tablesorter({textExtraction: stripCommas});
        $("#myTableDoneeDonationList").tablesorter({textExtraction: stripCommas});
    }
); </script>'."\n";
print "<h3>$donee donations received</h3>";
include_once('preamble.inc');
print '<h4>Table of contents</h4>';
print '<ul>';
print '<li><a href="#doneeInfo">Basic donee information</a></li>';
print '<li><a href="#doneeDonationAmountsByDonorAndYear">Donee donation amounts by donor and year</a></li>';
print '<li><a href="#doneeDocumentList">Donee document list</a></li>';
print '<li><a href="#doneeDonationList">Donee donation list</a></li>';
print '</ul>';

$cache_location = "cache/" . md5($_SERVER['REQUEST_URI']) . ".html";
if (needToRegenerate($cache_location)) {
  ob_start();
  include ("backend/doneeInfo.inc");
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
