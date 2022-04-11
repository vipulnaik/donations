<?php
include_once('doctype.inc');
$keyword = "Giving Tuesday";
if (($_REQUEST['keyword'] ?? '') != '') {
  $keyword = $_REQUEST['keyword'];
}

print "<title>All donations matching “" . htmlspecialchars($keyword) . "”</title>\n";
include_once('analytics.inc');
print '<script src="change-theme.js"></script>';
include_once('strip-commas.inc');
include_once('backend/stringFunctions.inc');
include_once('backend/cachingFunctions.inc');
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
        $("#myTableSearchDocumentList").tablesorter({textExtraction: stripCommas});
        $("#myTableSearchDonationList").tablesorter({textExtraction: stripCommas});
    }
); </script>'."\n";
print "<h3>All donations matching “" . htmlspecialchars($keyword) . "”</h3>\n";
print '<p> <!-- blank space to prevent cumulative layout shift --><span id="changeThemeMenu" style="display: none;">Change <a href="javascript:;" onclick="change_theme_color()">color</a></span></p>';
include_once('preamble.inc');
print '<h4>Table of contents</h4>';
print '<ul>';
print '<li><a href="#searchDocumentList">List of documents</a></li>';
print '<li><a href="#searchDonationList">List of donations</a></li>';
print '</ul>';

include ("backend/searchDocumentList.inc");
include ("backend/searchDonationList.inc");

include_once('anchorjs.inc');
print '</body>';
