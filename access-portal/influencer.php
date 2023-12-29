<?php
include_once('doctype.inc');
$influencer = 'GiveWell';
if (!empty($_REQUEST['influencer'])) {
  $influencer = $_REQUEST['influencer'];
}
print "<title>$influencer money moved</title>";
include_once('analytics.inc');
print '<script src="change-theme.js"></script>';
include_once('strip-commas.inc');
include_once('backend/stringFunctions.inc');
include_once('backend/cachingFunctions.inc');
include_once('backend/yearlyGraph.inc');
print '<link href="style.css" rel="stylesheet" type="text/css" />'."\n";
include_once("style.inc");
print '<script type="text/javascript" src="./jquery-3.7.1.min.js"></script>'."\n";
print '<script type="text/javascript" src="./jquery.tablesorter.js"></script>'."\n";
print '</head>';
include_once("backend/globalVariables/passwordFile.inc");
include_once("backend/globalVariables/lists.inc");
print '<body>';
print '<script>$(document).ready(function()
    {
        $("#myTableInfluencerDocumentList").tablesorter({textExtraction: stripCommas});
        $("#myTableInfluencerMoneyMovedList").tablesorter({textExtraction: stripCommas});
        $("#myTableInfluencerDonationList").tablesorter({textExtraction: stripCommas});
        $("#myTableInfluencerDonationAmountsByDoneeAndYear").tablesorter({textExtraction: stripCommas});
        $("#myTableInfluencerDonationAmountsByDonorAndYear").tablesorter({textExtraction: stripCommas});
    }
); </script>'."\n";
print "<h3>$influencer money moved</h3>";
print '<p><span id="changeThemeMenu" style="display: none;">Change <a href="javascript:;" onclick="change_theme_color()">color</a></span>   &thinsp;<!-- blank space to prevent cumulative layout shift --></p>';
include_once('preamble.inc');
print '<h4>Table of contents</h4>';
print '<ul>';
print '<li><a href="#influencerDocumentList">Influencer document list</a></li>';
print '<li><a href="#influencerMoneyMovedList">Influencer money moved list</a></li>';
print '<li><a href="#influencerDonationList">Influencer donation list</a></li>';
print '<li><a href="#influencerDonationAmountsByDoneeAndYear">Influencer donation amounts by donee and year</a></li>';
print '<li><a href="#influencerDonationAmountsByDonorAndYear">Influencer donation amounts by donor and year</a></li>';
print '</ul>';

$cache_location = "cache/" . md5($_SERVER['REQUEST_URI']) . ".html";
if (needToRegenerate($cache_location)) {
  ob_start();
  if ($stmt = $mysqli->prepare("select donor from donations where donor = ?")) {
    $stmt->bind_param("s", $influencer);
    $stmt->execute();
    $result = $stmt->get_result();
    if ($result->num_rows > 0) {
      print '<p><a href="/donor.php?donor=' . urlencode($influencer)
        . '">This entity is also a donor</a>.</p>' . "\n";
    }
  }

  if ($stmt = $mysqli->prepare("select donee from donations where donee = ?")) {
    $stmt->bind_param("s", $influencer);
    $stmt->execute();
    $result = $stmt->get_result();
    if ($result->num_rows > 0) {
      print '<p><a href="/donee.php?donee=' . urlencode($influencer)
        . '">This entity is also a donee</a>.</p>' . "\n";
    }
  }

  include ("backend/influencerDocumentList.inc");
  include ("backend/influencerMoneyMovedList.inc");
  include ("backend/influencerDonationList.inc");
  include ("backend/influencerDonationAmountsByDoneeAndYear.inc");
  include ("backend/influencerDonationAmountsByDonorAndYear.inc");
  $output = ob_get_clean();
  file_put_contents($cache_location, $output);
}
include($cache_location);
include_once("anchorjs.inc");
print "</body>\n";
print "</html>\n";
?>
