<?php

print '<h4 id="donationAmountsByDoneeAndYear">Donation amounts by donee and year</h4>';

$years = array_reverse(range(2001, 2017));

$doneeQuery = "select donee, count(distinct donor) as numDonors from donations group by donee;";
$doneeResult = $mysqli -> query($doneeQuery);
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
    $yearDonationAmount[$year] = 0;
    $donationAmountByDoneeAndYear[$donee][$year] = 0;
  }
}

$doneeMetadataQuery = "select * from donees;";
$doneeMetadataResult = $mysqli -> query($doneeMetadataQuery);
for ($i = 0; $i < $doneeMetadataResult -> num_rows; $i++) {
  $row = $doneeMetadataResult -> fetch_assoc();
  $facebookUsername[$row['donee']] = $row['facebook_username'];
  $twitterUsername[$row['donee']] = $row['twitter_username'];
  $wikipediaPage[$row['donee']] = $row['wikipedia_page'];
  $website[$row['donee']] = $row['website'];
  $causeAreaForDonee[$row['donee']] = $row['cause_area'];
}

$doneeAndYearQuery = "select donee, year(donation_date) as year, sum(amount) as amount from donations group by donee, year(donation_date)";
$doneeAndYearResult = $mysqli -> query($doneeAndYearQuery);

for ($i=0; $i < $doneeAndYearResult -> num_rows; $i++) {
  $row = $doneeAndYearResult -> fetch_assoc();
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

print '<table id="myTableDonationAmountsByDoneeAndYear" class="tablesorter">'."\n";
print "<thead>\n";
print "  <tr>\n    <th>Donee</th>\n	<th>Cause area</th>\n	<th>Metadata</th>\n	<th>Number of donors</th>\n";
foreach ($years as $year) {
  if ($yearDonationAmount[$year] > 0) {
    print "    <th>$year</th>\n";
  }
}
print "    <th>Total</th>\n  </tr>\n";
print "</thead>\n<tbody>\n";

foreach ($donees as $donee) {
  print "  <tr>\n";
  print '    <td><a href="/donee.php?donee='.urlencode($donee).'">'.$donee.'</a></td>'."\n";
  print '    <td>'.$causeAreaForDonee[$donee].'</td>'."\n";
  print '    <td>';
  if ($facebookUsername[$donee] != '') {
    $facebook_username = $facebookUsername[$donee];
    $facebook_url = 'https://www.facebook.com/'.$facebook_username;
    if (substr($facebook_username, 0, 4) == "http") {
      $facebook_url = $facebook_username;
    }
    print '<a href="'.$facebook_url.'">FB</a> ';
  }
  if ($twitterUsername[$donee] != '') {
    print '<a href="https://twitter.com/'.$twitterUsername[$donee].'">Tw</a> ';
  }
  if ($wikipediaPage[$donee] != '') {
    print '<a href="'.$wikipediaPage[$donee].'">WP</a> ';
  }
  if ($website[$donee] != '') {
    print '<a href="'.$website[$donee].'">Site</a>';
  }
  
  print "</td>\n";
  print '    <td align="right">'.$numDonorsByDonee[$donee]."</td>\n";
  foreach ($years as $year) {
    if ($yearDonationAmount[$year] > 0) {
      print '    <td align="right">'.sprintf("%.2f",$donationAmountByDoneeAndYear[$donee][$year])."</td>\n";
    }
  }
  print '    <td align="right"><strong>'.sprintf("%.2f",$doneeDonationAmount[$donee])."</strong></td>\n";
  print "  </tr>\n";
}

print "</tbody>\n";
print "<tfoot>\n";
print "  <tr>\n    <td><strong>Total</strong></td>\n";
print '	 <td align="center">--</td>'."\n";
print '	 <td align="center">--</td>'."\n";
print '	 <td align="center">--</td>'."\n";

foreach ($years as $year) {
  if ($yearDonationAmount[$year] > 0) {
    print '    <td align="right"><strong>'.sprintf("%.2f",$yearDonationAmount[$year])."</strong></td>\n";
  }
}

print '    <td align="right"><strong>'.sprintf("%.2f",$grandTotalDonationAmount)."</strong></td>\n";
print "  </tr>\n";
print "</tfoot>\n";
print "</table>";
