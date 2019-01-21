<?php

if (($_REQUEST['display'] ?? '') == "full") {
  $totalNumDistinctDoneesQuery = "select count(distinct donee) as numDonees from donations $causeAreaFilterQueryComponent";
} else if (($_REQUEST['display'] ?? '') == "individual-scale") {
  if ($causeAreaFilterQueryComponent) {
    $totalNumDistinctDoneesQuery = "select count(distinct donee) as numDonees from donations $causeAreaFilterQueryComponent and donor in (select donor from donors where donor_type = 'Individual' or donor_type = 'Couple')";
  } else {
    $totalNumDistinctDoneesQuery = "select count(distinct donee) as numDonees from donations where donor in (select donor from donors where donor_type = 'Individual' or donor_type = 'Couple')";
  }
} else {
  if ($causeAreaFilterQueryComponent) {
    $totalNumDistinctDoneesQuery = "select count(distinct donee) as numDonees from donations $causeAreaFilterQueryComponent and donor in (select * from (select donor from donations $causeAreaFilterQueryComponent group by donor order by sum(amount) desc limit 50) as x);";
  } else {
    $totalNumDistinctDoneesQuery = "select count(distinct donee) as numDonees from donations where donor in (select * from (select donor from donations group by donor order by sum(amount) desc limit 50) as x);";
  }
}
$totalNumDistinctDoneesResult = $mysqli -> query($totalNumDistinctDoneesQuery);
for ($i = 0; $i < $totalNumDistinctDoneesResult -> num_rows; $i++) {
  $row = $totalNumDistinctDoneesResult -> fetch_assoc();
  $totalNumDistinctDonees = $row['numDonees'];
}
if (($_REQUEST['display'] ?? '') == "full") {
  $donorQuery = "select donor,count(*) as numDonations, count(distinct donee) as numDonees from donations $causeAreaFilterQueryComponent group by donor;";
} else if (($_REQUEST['display'] ?? '') == "individual-scale") {
  if ($causeAreaFilterQueryComponent) {
    $donorQuery = "select donor,count(*) as numDonations, count(distinct donee) as numDonees from donations $causeAreaFilterQueryComponent and donor in (select donor from donors where donor_type = 'Individual' or donor_type = 'Couple') group by donor;";
  } else {
    $donorQuery = "select donor,count(*) as numDonations, count(distinct donee) as numDonees from donations where donor in (select donor from donors where donor_type = 'Individual' or donor_type = 'Couple') group by donor;";
  }
} else {
  if ($causeAreaFilterQueryComponent) {
    $donorQuery = "select donor,count(*) as numDonations, count(distinct donee) as numDonees from donations $causeAreaFilterQueryComponent and donor in (select * from (select donor from donations $causeAreaFilterQueryComponent group by donor order by sum(amount) desc limit 50) as x) group by donor;";
  } else {
    $donorQuery = "select donor,count(*) as numDonations, count(distinct donee) as numDonees from donations where donor in (select * from (select donor from donations group by donor order by sum(amount) desc limit 50) as x) group by donor;";
  }
}
$donorResult = $mysqli -> query($donorQuery);
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
    $yearDonationAmount[$year] = 0;
    $donationAmountByDonorAndYear[$donor][$year] = 0;
  }
}

if (($_REQUEST['display'] ?? '') == "full") {
  $donorMetadataQuery = "select * from donors;";
} else if (($_REQUEST['display'] ?? '') == "individual-scale") {
  $donorMetadataQuery = "select * from donors where donor in (select donor from donors where donor_type = 'Individual' or donor_type = 'Couple');";
} else {
  $donorMetadataQuery = "select * from donors where donor in (select * from (select donor from donations $causeAreaFilterQueryComponent group by donor order by sum(amount) desc limit 50) as x);";
}
$donorMetadataResult = $mysqli -> query($donorMetadataQuery);
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

if (($_REQUEST['display'] ?? '') == "full") {
  $donorAndYearQuery = "select donor, year(donation_date) as year, sum(amount) as amount from donations $causeAreaFilterQueryComponent group by donor, year(donation_date)";
} else if (($_REQUEST['display'] ?? '') == "individual-scale") {
  if ($causeAreaFilterQueryComponent) {
    $donorAndYearQuery = "select donor, year(donation_date) as year, sum(amount) as amount from donations $causeAreaFilterQueryComponent and donor in (select donor from donors where donor_type = 'Individual' or donor_type = 'Couple') group by donor, year(donation_date)";
  } else {
    $donorAndYearQuery = "select donor, year(donation_date) as year, sum(amount) as amount from donations where donor in (select donor from donors where donor_type = 'Individual' or donor_type = 'Couple') group by donor, year(donation_date)";
  }
} else {
  if ($causeAreaFilterQueryComponent) {
    $donorAndYearQuery = "select donor, year(donation_date) as year, sum(amount) as amount from donations $causeAreaFilterQueryComponent and donor in (select * from (select donor from donations $causeAreaFilterQueryComponent group by donor order by sum(amount) desc limit 50) as x) group by donor, year(donation_date)";
  } else {
    $donorAndYearQuery = "select donor, year(donation_date) as year, sum(amount) as amount from donations where donor in (select * from (select donor from donations group by donor order by sum(amount) desc limit 50) as x) group by donor, year(donation_date)";
  }
}
$donorAndYearResult = $mysqli -> query($donorAndYearQuery);

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
