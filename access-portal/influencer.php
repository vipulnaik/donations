<?php
print '<!doctype html public "-//W3C//DTD HTML 4.01 Transitional//EN"><html><head><meta http-equiv="Content-Type" content="text/html;charset=utf-8" >';
$influencer = 'GiveWell';
if (!empty($_REQUEST['influencer'])) {
  $influencer = $_REQUEST['influencer'];
}
print "<title>$donor donations made</title>";
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
        $("#myTableInfluencerDocumentList").tablesorter({textExtraction: stripCommas});
        $("#myTableMoneyMovedList").tablesorter({textExtraction: stripCommas});
    }
); </script>'."\n";
print "<h3>$influencer money moved</h3>";
include_once('preamble.inc');
print '<h4>Table of contents</h4>';
print '<ul>';
print '<li><a href="#influencerDocumentList">Influencer document list</a></li>';
print '<li><a href="#influencerMoneyMovedList">Influencer money moved list</a></li>';
print '</ul>';

include ("backend/influencerDocumentList.inc");
include ("backend/influencerMoneyMovedList.inc");
print '</body>';
?>
