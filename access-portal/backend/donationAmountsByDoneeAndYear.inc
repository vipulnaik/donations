<?php

$numDoneesToShowInLimitedView = 75;

$paramStr = "";
$params = array();
if (($_REQUEST['display'] ?? '') == "full") {
  if ($causeAreaFilterString) {
    $doneeQuery = "select donee, count(distinct donor) as numDonors from donations where cause_area REGEXP ? and donation_date is not null group by donee;";
    $paramStr .= "s";
    $params[] = $causeAreaFilterString;
  } else {
    $doneeQuery = "select donee, count(distinct donor) as numDonors from donations group by donee;";
  }
} else if (($_REQUEST['display'] ?? '') == "individual-scale") {
  if ($causeAreaFilterString) {
    $doneeQuery = "select donee, count(distinct donor) as numDonors from donations where cause_area REGEXP ? and donation_date is not null and donor in (select donor from donors where donor_type = 'Individual' or donor_type = 'Couple') group by donee;";
    $paramStr .= "s";
    $params[] = $causeAreaFilterString;
  } else {
    $doneeQuery = "select donee, count(distinct donor) as numDonors from donations where donation_date is not null and donor in (select donor from donors where donor_type = 'Individual' or donor_type = 'Couple') group by donee;";
  }
} else {
  if ($causeAreaFilterString) {
    $doneeQuery = "select donee, count(distinct donor) as numDonors from donations where cause_area REGEXP ? and donation_date is not null group by donee order by sum(amount) desc limit $numDoneesToShowInLimitedView;";
    $paramStr .= "s";
    $params[] = $causeAreaFilterString;
  } else {
    $doneeQuery = "select donee, count(distinct donor) as numDonors from donations where donation_date is not null group by donee order by sum(amount) desc limit $numDoneesToShowInLimitedView;";
  }
}
$stmt = $mysqli->prepare($doneeQuery);
if ($params) {
  $stmt->bind_param($paramStr, ...$params);
}
$stmt->execute();
$doneeResult = $stmt->get_result();
$donees = array();
for ($i = 0; $i < $doneeResult -> num_rows; $i++) {
  $row = $doneeResult -> fetch_assoc();
  array_push($donees, $row['donee']);
  $numDonorsByDonee[$row['donee']] = $row['numDonors'];
}
$grandTotalDonationAmount = 0;
foreach($donees as $donee) {
  $doneeDonationAmount[$donee] = 0;
  foreach($years as $year) {
    $donationAmountByDoneeAndYear[$donee][$year] = 0;
  }
}

foreach($years as $year) {
  $yearDonationAmount[$year] = 0;
}

if ($causeAreaFilterString) {
  $doneeMetadataQuery = "select * from donees where cause_area REGEXP ?;";
  $stmt = $mysqli->prepare($doneeMetadataQuery);
  $stmt->bind_param("s", $causeAreaFilterString);
} else {
  $doneeMetadataQuery = "select * from donees;";
  $stmt = $mysqli->prepare($doneeMetadataQuery);
}
$stmt->execute();
$doneeMetadataResult = $stmt->get_result();
$website = array();
$facebookUsername = array();
$lesswrongUsername = array();
$linkedinUsername = array();
$twitterUsername = array();
$givewellReview = array();
$causeAreaForDonee = array();
$charityNavigatorPage = array();
$guidestarPage = array();
$timelinesWikiPage = array();

for ($i = 0; $i < $doneeMetadataResult -> num_rows; $i++) {
  $row = $doneeMetadataResult -> fetch_assoc();
  $facebookUsername[$row['donee']] = $row['facebook_username'];
  $twitterUsername[$row['donee']] = $row['twitter_username'];
  $wikipediaPage[$row['donee']] = $row['wikipedia_page'];
  $website[$row['donee']] = $row['website'];
  $givewellReview[$row['donee']] = $row['givewell_review'];
  $causeAreaForDonee[$row['donee']] = $row['cause_area'];
  $charityNavigatorPage[$row['donee']] = $row['charity_navigator_page'];
  $guidestarPage[$row['donee']] = $row['guidestar_page'];
  $timelinesWikiPage[$row['donee']] = $row['timelines_wiki_page'];
}

$paramStr = "";
$params = array();
if (($_REQUEST['display'] ?? '') == "individual-scale") {
  if ($causeAreaFilterString) {
    $doneeAndYearQuery = "select donee, year(donation_date) as year, sum(amount) as amount from donations where cause_area REGEXP ? and donation_date is not null and donor in (select donor from donors where donor_type = 'Individual' or donor_type = 'Couple') group by donee, year(donation_date)";
    $paramStr .= "s";
    $params[] = $causeAreaFilterString;
  } else {
    $doneeAndYearQuery = "select donee, year(donation_date) as year, sum(amount) as amount from donations where donation_date is not null and donor in (select donor from donors where donor_type = 'Individual' or donor_type = 'Couple') group by donee, year(donation_date)";
  }
} else {
  if ($causeAreaFilterString) {
    $doneeAndYearQuery = "select donee, year(donation_date) as year, sum(amount) as amount from donations where cause_area REGEXP ? and donation_date is not null group by donee, year(donation_date)";
    $paramStr .= "s";
    $params[] = $causeAreaFilterString;
  } else {
    $doneeAndYearQuery = "select donee, year(donation_date) as year, sum(amount) as amount from donations where donation_date is not null group by donee, year(donation_date)";
  }
}
$stmt = $mysqli->prepare($doneeAndYearQuery);
if ($params) {
  $stmt->bind_param($paramStr, ...$params);
}
$stmt->execute();
$doneeAndYearResult = $stmt->get_result();

for ($i=0; $i < $doneeAndYearResult -> num_rows; $i++) {
  $row = $doneeAndYearResult -> fetch_assoc();
  $donationAmountByDoneeAndYear[$row['donee']][$row['year']] = $row['amount'];
  if (!isset($doneeDonationAmount[$row['donee']])) {
    $doneeDonationAmount[$row['donee']] = 0;
  }
  $doneeDonationAmount[$row['donee']] += $row['amount'];
  if (!isset($yearDonationAmount[$row['year']])) {
    $yearDonationAmount[$row['year']] = 0;
  }
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

$numDonees = count($donees);
print '<h4 id="donationAmountsByDoneeAndYear">Donation amounts by donee and year'." ($numDonees donees)</h4>\n";

print '<table id="myTableDonationAmountsByDoneeAndYear" class="tablesorter">'."\n";
print "<thead>\n";
print "  <tr>\n    <th>Donee</th>\n	<th>Cause area</th>\n	<th>Metadata</th>\n	<th>Number of donors</th>\n";
print "    <th>Total</th>\n";
foreach ($years as $year) {
  if ($yearDonationAmount[$year] != 0) {
    print "    <th>$year</th>\n";
  }
}
print "  </tr>\n";
print "</thead>\n<tbody>\n";

foreach ($donees as $donee) {
  print "  <tr>\n";
  print '    <td><a href="/donee.php?donee='.urlencode($donee).'">'.$donee.'</a></td>'."\n";
  if (array_key_exists($donee, $causeAreaForDonee)) {
    print '    <td>'.$causeAreaForDonee[$donee].'</td>'."\n";
  } else {
    print '	<td></td>'."\n";
  }
  print '    <td>';
  if (array_key_exists($donee, $facebookUsername) and $facebookUsername[$donee] != '') {
    $facebook_username = $facebookUsername[$donee];
    $facebook_url = 'https://www.facebook.com/'.$facebook_username;
    if (substr($facebook_username, 0, 4) == "http") {
      $facebook_url = $facebook_username;
    }
    print '<a href="'.$facebook_url.'">FB</a> ';
  }
  if (array_key_exists($donee, $twitterUsername) and $twitterUsername[$donee] != '') {
    print '<a href="https://twitter.com/'.$twitterUsername[$donee].'">Tw</a> ';
  }
  if (array_key_exists($donee, $wikipediaPage) and $wikipediaPage[$donee] != '') {
    print '<a href="'.$wikipediaPage[$donee].'">WP</a> ';
  }
  if (array_key_exists($donee, $website) and $website[$donee] != '') {
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
  print '    <td align="right">'.$numDonorsByDonee[$donee]."</td>\n";
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
print "  <tr>\n    <td><strong>Total</strong></td>\n";
print '	 <td align="center">--</td>'."\n";
print '	 <td align="center">--</td>'."\n";
print '	 <td align="center">--</td>'."\n";

print '    <td align="right"><strong>'.number_format($grandTotalDonationAmount,2)."</strong></td>\n";

foreach ($years as $year) {
  if ($yearDonationAmount[$year] != 0) {
    print '    <td align="right"><strong>'.number_format($yearDonationAmount[$year],2)."</strong></td>\n";
  }
}

print "  </tr>\n";
print "</tfoot>\n";
print "</table>";

$permalinkUrlBase = "https://donations.vipulnaik.com/index.php";

if ($causeAreaFilterString != '') {
  $permalinkUrlBase .= '&cause_area_filter='.urlencode($causeAreaFilterString);
}

$graphs = yearlyGraphs(
  $years,
  $donees,
  $yearDonationAmount,
  $donationAmountByDoneeAndYear,
  $generateGraphCmdBase,
  $imagesPath,
  $permalinkUrlBase,
  "#donationAmountsByDoneeAndYear"
);

print "<p><strong>Graph of spending by donee and year (incremental, not cumulative)</strong></p>";
print '<img src="/images/'.$graphs[0].'-timeseries.png" alt="Graph of spending should have loaded here"></img>';

print "<p><strong>Graph of spending by donee and year (cumulative)</strong></p>";
print '<img src="/images/'.$graphs[1].'-timeseries.png" alt="Graph of spending should have loaded here"></img>';
