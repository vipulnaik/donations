<?php

$numDonorsToShowInLimitedView = 75;

$paramStr = "";
$params = array();
if (($_REQUEST['display'] ?? '') == "full") {
  if ($causeAreaFilterString) {
    $totalNumDistinctDoneesQuery = "select count(distinct donee) as numDonees from donations where cause_area REGEXP ? ";
    $paramStr .= "s";
    $params[] = $causeAreaFilterString;
  } else {
    $totalNumDistinctDoneesQuery = "select count(distinct donee) as numDonees from donations ";
  }
} else if (($_REQUEST['display'] ?? '') == "individual-scale") {
  if ($causeAreaFilterString) {
    $totalNumDistinctDoneesQuery = "select count(distinct donee) as numDonees from donations where cause_area REGEXP ? and donor in (select donor from donors where donor_type = 'Individual' or donor_type = 'Couple')";
    $paramStr .= "s";
    $params[] = $causeAreaFilterString;
  } else {
    $totalNumDistinctDoneesQuery = "select count(distinct donee) as numDonees from donations where donor in (select donor from donors where donor_type = 'Individual' or donor_type = 'Couple')";
  }
} else {
  if ($causeAreaFilterString) {
    $totalNumDistinctDoneesQuery = "select count(distinct donee) as numDonees from donations where cause_area REGEXP ? and donor in (select * from (select donor from donations where cause_area REGEXP ? group by donor order by sum(amount) desc limit $numDonorsToShowInLimitedView) as x);";
    $paramStr .= "ss";
    $params[] = $causeAreaFilterString;
    $params[] = $causeAreaFilterString;
  } else {
    $totalNumDistinctDoneesQuery = "select count(distinct donee) as numDonees from donations where donor in (select * from (select donor from donations group by donor order by sum(amount) desc limit $numDonorsToShowInLimitedView) as x);";
  }
}
$stmt = $mysqli->prepare($totalNumDistinctDoneesQuery);
if ($params) {
  $stmt->bind_param($paramStr, ...$params);
}
$stmt->execute();
$totalNumDistinctDoneesResult = $stmt->get_result();
for ($i = 0; $i < $totalNumDistinctDoneesResult -> num_rows; $i++) {
  $row = $totalNumDistinctDoneesResult -> fetch_assoc();
  $totalNumDistinctDonees = $row['numDonees'];
}
$paramStr = "";
$params = array();
if (($_REQUEST['display'] ?? '') == "full") {
  if ($causeAreaFilterString) {
    $donorQuery = "select donor,count(*) as numDonations, count(distinct donee) as numDonees from donations where cause_area REGEXP ? group by donor;";
    $paramStr .= "s";
    $params[] = $causeAreaFilterString;
  } else {
    $donorQuery = "select donor,count(*) as numDonations, count(distinct donee) as numDonees from donations group by donor;";
  }
} else if (($_REQUEST['display'] ?? '') == "individual-scale") {
  if ($causeAreaFilterString) {
    $donorQuery = "select donor,count(*) as numDonations, count(distinct donee) as numDonees from donations where cause_area REGEXP ? and donor in (select donor from donors where donor_type = 'Individual' or donor_type = 'Couple') group by donor;";
    $paramStr .= "s";
    $params[] = $causeAreaFilterString;
  } else {
    $donorQuery = "select donor,count(*) as numDonations, count(distinct donee) as numDonees from donations where donor in (select donor from donors where donor_type = 'Individual' or donor_type = 'Couple') group by donor;";
  }
} else {
  if ($causeAreaFilterString) {
    $donorQuery = "select donor,count(*) as numDonations, count(distinct donee) as numDonees from donations where cause_area REGEXP ? and donor in (select * from (select donor from donations where cause_area REGEXP ? group by donor order by sum(amount) desc limit $numDonorsToShowInLimitedView) as x) group by donor;";
    $paramStr .= "ss";
    $params[] = $causeAreaFilterString;
    $params[] = $causeAreaFilterString;
  } else {
    $donorQuery = "select donor,count(*) as numDonations, count(distinct donee) as numDonees from donations where donor in (select * from (select donor from donations group by donor order by sum(amount) desc limit $numDonorsToShowInLimitedView) as x) group by donor;";
  }
}
$stmt = $mysqli->prepare($donorQuery);
if ($params) {
  $stmt->bind_param($paramStr, ...$params);
}
$stmt->execute();
$donorResult = $stmt->get_result();
$donors = array();
$grandTotalNumDonations = 0;
for ($i = 0; $i < $donorResult -> num_rows; $i++) {
  $row = $donorResult -> fetch_assoc();
  array_push($donors, $row['donor']);
  $numDonees[$row['donor']] = $row['numDonees'];
  $numDonations[$row['donor']] = $row['numDonations'];
  $grandTotalNumDonations += $row['numDonations'];
}
$grandTotalDonationAmount = 0;
foreach($donors as $donor) {
  $donorDonationAmount[$donor] = 0;
  foreach($years as $year) {
    $donationAmountByDonorAndYear[$donor][$year] = 0;
  }
}

foreach($years as $year) {
  $yearDonationAmount[$year] = 0;
}

$paramStr = "";
$params = array();
if (($_REQUEST['display'] ?? '') == "full") {
  $donorMetadataQuery = "select * from donors;";
} else if (($_REQUEST['display'] ?? '') == "individual-scale") {
  $donorMetadataQuery = "select * from donors where donor in (select donor from donors where donor_type = 'Individual' or donor_type = 'Couple');";
} else {
  if ($causeAreaFilterString) {
    $donorMetadataQuery = "select * from donors where donor in (select * from (select donor from donations where cause_area REGEXP ? group by donor order by sum(amount) desc limit $numDonorsToShowInLimitedView) as x);";
    $paramStr .= "s";
    $params[] = $causeAreaFilterString;
  } else {
    $donorMetadataQuery = "select * from donors where donor in (select * from (select donor from donations group by donor order by sum(amount) desc limit $numDonorsToShowInLimitedView) as x);";
  }
}
$stmt = $mysqli->prepare($donorMetadataQuery);
if ($params) {
  $stmt->bind_param($paramStr, ...$params);
}
$stmt->execute();
$donorMetadataResult = $stmt->get_result();
$donorType = array();
$website = array();
$facebookUsername = array();
$lesswrongUsername = array();
$linkedinUsername = array();
$twitterUsername = array();
$wikipediaPage = array();

for ($i = 0; $i < $donorMetadataResult -> num_rows; $i++) {
  $row = $donorMetadataResult -> fetch_assoc();
  $donorType[$row['donor']] = $row['donor_type'];
  $website[$row['donor']] = $row['website'];
  $facebookUsername[$row['donor']] = $row['facebook_username'];
  $lesswrongUsername[$row['donor']] = $row['lesswrong_username'];
  $linkedinUsername[$row['donor']] = $row['linkedin_username'];
  $twitterUsername[$row['donor']] = $row['twitter_username'];
  $wikipediaPage[$row['donor']] = $row['wikipedia_page'];
}

$paramStr = "";
$params = array();
if (($_REQUEST['display'] ?? '') == "full") {
  if ($causeAreaFilterString) {
    $donorAndYearQuery = "select donor, year(donation_date) as year, sum(amount) as amount from donations where cause_area REGEXP ? group by donor, year(donation_date)";
    $paramStr .= "s";
    $params[] = $causeAreaFilterString;
  } else {
    $donorAndYearQuery = "select donor, year(donation_date) as year, sum(amount) as amount from donations group by donor, year(donation_date)";
  }
} else if (($_REQUEST['display'] ?? '') == "individual-scale") {
  if ($causeAreaFilterString) {
    $donorAndYearQuery = "select donor, year(donation_date) as year, sum(amount) as amount from donations where cause_area REGEXP ? and donor in (select donor from donors where donor_type = 'Individual' or donor_type = 'Couple') group by donor, year(donation_date)";
    $paramStr .= "s";
    $params[] = $causeAreaFilterString;
  } else {
    $donorAndYearQuery = "select donor, year(donation_date) as year, sum(amount) as amount from donations where donor in (select donor from donors where donor_type = 'Individual' or donor_type = 'Couple') group by donor, year(donation_date)";
  }
} else {
  if ($causeAreaFilterString) {
    $donorAndYearQuery = "select donor, year(donation_date) as year, sum(amount) as amount from donations where cause_area REGEXP ? and donor in (select * from (select donor from donations where cause_area REGEXP ? group by donor order by sum(amount) desc limit $numDonorsToShowInLimitedView) as x) group by donor, year(donation_date)";
    $paramStr .= "ss";
    $params[] = $causeAreaFilterString;
    $params[] = $causeAreaFilterString;
  } else {
    $donorAndYearQuery = "select donor, year(donation_date) as year, sum(amount) as amount from donations where donor in (select * from (select donor from donations group by donor order by sum(amount) desc limit $numDonorsToShowInLimitedView) as x) group by donor, year(donation_date)";
  }
}
$stmt = $mysqli->prepare($donorAndYearQuery);
if ($params) {
  $stmt->bind_param($paramStr, ...$params);
}
$stmt->execute();
$donorAndYearResult = $stmt->get_result();

for ($i=0; $i < $donorAndYearResult -> num_rows; $i++) {
  $row = $donorAndYearResult -> fetch_assoc();
  $donationAmountByDonorAndYear[$row['donor']][$row['year']] = $row['amount'];
  $donorDonationAmount[$row['donor']] += $row['amount'];
  $yearDonationAmount[$row['year']] += $row['amount'];
  $grandTotalDonationAmount += $row['amount'];
}

function cmpDonorsByAmount($firstDonor, $secondDonor) {
  global $donorDonationAmount;
  if (intval($donorDonationAmount[$firstDonor]) == intval($donorDonationAmount[$secondDonor])) {
    return 0;
  }
  return (intval($donorDonationAmount[$firstDonor]) > intval($donorDonationAmount[$secondDonor])) ? -1 : 1;
}

usort($donors, "cmpDonorsByAmount");
$numDonors = count($donors);
print '<h4 id="donationAmountsByDonorAndYear">Donation amounts by donor and year'." ($numDonors donors)</h4>\n";

print '<table id="myTableDonationAmountsByDonorAndYear" class="tablesorter">'."\n";
print "<thead>\n";
print "  <tr>\n    <th>Donor</th>\n    <th>Metadata</th>\n	<th>Number of donations</th>\n	<th>Number of donees</th>";
print "    <th>Total</th>\n";
foreach ($years as $year) {
  if ($yearDonationAmount[$year] != 0) {
    print "    <th>$year</th>\n";
  }
}
print "  </tr>\n";
print "</thead>\n<tbody>\n";

foreach ($donors as $donor) {
  print "  <tr>\n";
  print '    <td><a href="/donor.php?donor='.urlencode($donor).'">'.$donor.'</a></td>'."\n";
  print '    <td>';
  if (array_key_exists($donor, $facebookUsername) and $facebookUsername[$donor] != '') {
    $facebook_username = $facebookUsername[$donor];
    $facebook_url = 'https://www.facebook.com/'.$facebook_username;
    if (substr($facebook_username, 0, 4) == "http") {
      $facebook_url = $facebook_username;
    }
    print '<a href="'.$facebook_url.'">FB</a> ';
  }
  if (array_key_exists($donor, $twitterUsername) and $twitterUsername[$donor] != '') {
    print '<a href="https://twitter.com/'.$twitterUsername[$donor].'">Tw</a> ';
  }
  if (array_key_exists($donor, $wikipediaPage) and $wikipediaPage[$donor] != '') {
    print '<a href="'.$wikipediaPage[$donor].'">WP</a> ';
  }
  if (array_key_exists($donor, $website) and $website[$donor] != '') {
    print '<a href="'.$website[$donor].'">Site</a> ';
  }
  if (array_key_exists($donor, $linkedinUsername) and $linkedinUsername[$donor] != '') {
    $linkedin_username = $linkedinUsername[$donor];
    if ($donorType[$donor] == "Individual" or $donorType[$donor] == "Couple") {
      $linkedin_url = 'https://www.linkedin.com/in/' . $linkedin_username;
    } else {
      $linkedin_url = 'https://www.linkedin.com/company/' . $linkedin_username;
    }
    print '<a href="'.$linkedin_url.'">LI</a>';
  }
  print "</td>\n";
  
  print '    <td align="right">'.$numDonations[$donor]."</td>\n";
  print '    <td align="right">'.$numDonees[$donor]."</td>\n";
  print '    <td align="right"><strong>'.number_format($donorDonationAmount[$donor],2).'</strong></td>'."\n";
  foreach ($years as $year) {
    if ($yearDonationAmount[$year] != 0) {
      print '    <td align="right">'.number_format($donationAmountByDonorAndYear[$donor][$year], 2).'</td>'."\n";
    }
  }
  print "  </tr>\n";
}

print "</tbody>\n";
print "<tfoot>\n";
print "  <tr>\n    <td><strong>Total</strong></td>\n";
print '  <td align="center"><strong>--</strong></td>'."\n";
print '	 <td align="right"><strong>'.$grandTotalNumDonations.'</strong></td>'."\n";
print '	 <td align="right"><strong>'.$totalNumDistinctDonees.'</strong></td>'."\n";

print '    <td align="right"><strong>'.number_format($grandTotalDonationAmount,2).'</strong></td>'."\n";

foreach ($years as $year) {
  if ($yearDonationAmount[$year] != 0) {
    print '    <td align="right"><strong>'.number_format($yearDonationAmount[$year],2)."</strong></td>\n";
  }
}

print "  </tr>\n";
print "</tfoot>\n";
print "</table>\n";

$permalinkUrlBase = "https://donations.vipulnaik.com/index.php";

if ($causeAreaFilterString != '') {
  $permalinkUrlBase .= '&cause_area_filter='.urlencode($causeAreaFilterString);
}

$graphs = yearlyGraphs(
  $years,
  $donors,
  $yearDonationAmount,
  $donationAmountByDonorAndYear,
  $generateGraphCmdBase,
  $imagesPath,
  $permalinkUrlBase,
  "#donationAmountsByDonorAndYear"
);

print "<p><strong>Graph of spending by donor and year (incremental, not cumulative)</strong></p>";
print '<img src="/images/'.$graphs[0].'-timeseries.png" alt="Graph of spending should have loaded here"></img>';

print "<p><strong>Graph of spending by donor and year (cumulative)</strong></p>";
print '<img src="/images/'.$graphs[1].'-timeseries.png" alt="Graph of spending should have loaded here"></img>';
