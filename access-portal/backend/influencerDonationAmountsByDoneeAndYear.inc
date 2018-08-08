<?php

function linkDonors(string $donorList, string $donee) {
  $donors = array_map(function ($donor) use ($donee) {
                        return '<a href="/donor.php?donor=' . urlencode($donor)
                          . '">' . htmlspecialchars($donor) . '</a>'
                          . ' (<a href="/donorDonee.php?donor=' . urlencode($donor)
                          . "&amp;donee=" . urlencode($donee) . '">filter this donor</a>)';
                      },
                      explode("|", $donorList));
  return implode(", ", $donors);
}

$query = "select donee, group_concat(distinct donor order by donor separator '|') as donor_list from donations where influencer regexp ?";
$paramStr = "s";
$params = array($influencer);
if ($_REQUEST['cause_area_filter'] ?? '') {
  $query .= " and cause_area regexp ?";
  $paramStr .= "s";
  $params[] = $_REQUEST['cause_area_filter'];
}
$query .= " group by donee";
if ($stmt = $mysqli->prepare($query)) {
  $stmt->bind_param($paramStr, ...$params);
  $stmt->execute();
  $result = $stmt->get_result();
}

$donees = array();
$donorsByDonee = array();

while ($row = $result->fetch_assoc()) {
  $donees[] = $row['donee'];
  $donorsByDonee[$row['donee']] = $row['donor_list'];
}
$grandTotalDonationAmount = 0;
foreach($donees as $donee) {
  $doneeDonationAmount[$donee] = 0;
  foreach($years as $year) {
    $yearDonationAmount[$year] = 0;
    $donationAmountByDoneeAndYear[$donee][$year] = 0;
  }
}

// Query donee metadata
if ($stmt = $mysqli->prepare("select * from donees")) {
  $stmt->execute();
  $result = $stmt->get_result();
}
while ($row = $result->fetch_assoc()) {
  $facebookUsername[$row['donee']] = $row['facebook_username'];
  $twitterUsername[$row['donee']] = $row['twitter_username'];
  $wikipediaPage[$row['donee']] = $row['wikipedia_page'];
  $website[$row['donee']] = $row['website'];
  $causeAreaForDonee[$row['donee']] = $row['cause_area'];
  $charityNavigatorPage[$row['donee']] = $row['charity_navigator_page'];
  $guidestarPage[$row['donee']] = $row['guidestar_page'];
  $timelinesWikiPage[$row['donee']] = $row['timelines_wiki_page'];
  $givewellReview[$row['donee']] = $row['givewell_review'];
}

// Query yearly donation data
$query = "select donee, year(donation_date) as year, sum(amount) as amount from donations where influencer regexp ?";
$params = array($influencer);
$paramStr = "s";
if ($_REQUEST['cause_area_filter'] ?? '') {
  $query .= " and cause_area regexp ?";
  $paramStr .= "s";
  $params[] = $_REQUEST['cause_area_filter'];
}
$query .= " group by donee, year(donation_date)";
if ($stmt = $mysqli->prepare($query)) {
  $stmt->bind_param($paramStr, ...$params);
  $stmt->execute();
  $result = $stmt->get_result();
}
while ($row = $result->fetch_assoc()) {
  $donationAmountByDoneeAndYear[$row['donee']][$row['year']] = $row['amount'];
  $doneeDonationAmount[$row['donee']] += $row['amount'];
  $yearDonationAmount[$row['year']] += $row['amount'];
  $grandTotalDonationAmount += $row['amount'];
}

function cmpDoneesByAmount($firstDonee, $secondDonee) {
  global $doneeDonationAmount;
  if (intval($doneeDonationAmount[$firstDonee]) == intval($doneeDonationAmount[$secondDonee])) {
    return 0;
  }
  return (intval($doneeDonationAmount[$firstDonee]) > intval($doneeDonationAmount[$secondDonee])) ? -1 : 1;
}

usort($donees, "cmpDoneesByAmount");

print '<h4 id="influencerDonationAmountsByDoneeAndYear">Donation amounts by donee and year</h4>';
print '<table id="myTableInfluencerDonationAmountsByDoneeAndYear" class="tablesorter">'."\n";
print "<thead>\n";
print "  <tr>\n    <th>Donee</th>\n    <th>Donors influenced</th>\n    <th>Cause area</th>\n    <th>Metadata</th>\n";
print "    <th>Total</th>\n";
foreach ($years as $year) {
  if ($yearDonationAmount[$year] != 0) {
    print "    <th>$year</th>\n";
  }
}
print "</tr>\n</thead>\n<tbody>\n";

foreach ($donees as $donee) {
  print "  <tr>\n";
  print '    <td><a href="/donee.php?donee=' . urlencode($donee) . '">'
    . $donee . '</a></td>'."\n";
  print '    <td>' . linkDonors($donorsByDonee[$donee], $donee) . '</td>' . "\n";
  print '    <td>'.(isset($causeAreaForDonee[$donee]) ? $causeAreaForDonee[$donee] : "").'</td>'."\n";
  print '    <td>';
  if (isset($facebookUsername[$donee]) && $facebookUsername[$donee] != '') {
    $facebook_username = $facebookUsername[$donee];
    $facebook_url = 'https://www.facebook.com/'.$facebook_username;
    if (substr($facebook_username, 0, 4) == "http") {
      $facebook_url = $facebook_username;
    }
    print '<a href="'.$facebook_url.'">FB</a> ';
  }
  if (isset($twitterUsername[$donee]) && $twitterUsername[$donee] != '') {
    print '<a href="https://twitter.com/'.$twitterUsername[$donee].'">Tw</a> ';
  }
  if (isset($wikipediaPage[$donee]) && $wikipediaPage[$donee] != '') {
    print '<a href="'.$wikipediaPage[$donee].'">WP</a> ';
  }
  if (isset($website[$donee]) && $website[$donee] != '') {
    print '<a href="'.$website[$donee].'">Site</a> ';
  }
  if (array_key_exists($donee, $givewellReview) and $givewellReview[$donee] != '') {
    print '<a href="'.$givewellReview[$donee].'">GW</a> ';
  }
  if (array_key_exists($donee, $charityNavigatorPage) and $charityNavigatorPage[$donee] != '') {
    print '<a href="'.$charityNavigatorPage[$donee].'">CN</a> ';
  }
  if (array_key_exists($donee, $guidestarPage) and $guidestarPage[$donee] != '') {
    print '<a href="'.$guidestarPage[$donee].'">GS</a> ';
  }
  if (array_key_exists($donee, $timelinesWikiPage) and $timelinesWikiPage[$donee] != '') {
    print '<a href="'.$timelinesWikiPage[$donee].'">TW</a> ';
  }

  print "</td>\n";
  print '    <td align="right"><strong>'.number_format($doneeDonationAmount[$donee],2)."</strong></td>\n";
  foreach ($years as $year) {
    if ($yearDonationAmount[$year] != 0) {
      print '    <td align="right">'.number_format($donationAmountByDoneeAndYear[$donee][$year],2)."</td>\n";
    }
  }
  print "  </tr>\n";
}

print "</tbody>\n";
print "<tfoot>\n";
print "  <tr>\n    <td><strong>Total</strong></td>\n    ".'<td align="center">--</td>'."\n".'    <td align="center">--</td>'."\n";
print '    <td align="right"><strong>'.number_format($grandTotalDonationAmount,2)."</strong></td>\n";

foreach ($years as $year) {
  if ($yearDonationAmount[$year] != 0) {
    print '    <td align="right"><strong>'.number_format($yearDonationAmount[$year],2)."</strong></td>\n";
  }
}

print "  </tr>\n";
print "</tfoot>\n";
print "</table>";

$permalinkUrlBase = "https://donations.vipulnaik.com/influencer.php?influencer=" . urlencode($influencer);

if ($causeAreaFilterString != '') {
  $permalinkUrlBase .= '&cause_area_filter='.urlencode($causeAreaFilterString);
}

if (count(array_filter($yearDonationAmount)) > 1) {
  $graphs = yearlyGraphs(
    $years,
    $donees,
    $yearDonationAmount,
    $donationAmountByDoneeAndYear,
    $generateGraphCmdBase,
    $imagesPath,
    $permalinkUrlBase,
    "#influencerDonationAmountsByDoneeAndYear"
  );

  print "<p><strong>Graph of spending by donee and year (incremental, not cumulative)</strong></p>";
  print '<img src="/images/'.$graphs[0].'-timeseries.png" alt="Graph of spending should have loaded here"></img>';

  print "<p><strong>Graph of spending by donee and year (cumulative)</strong></p>";
  print '<img src="/images/'.$graphs[1].'-timeseries.png" alt="Graph of spending should have loaded here"></img>';
} else {
  print "<p>Skipping spending graph as there is fewer than one year’s worth of donations.</p>\n";
}
?>
