<?php

$totalNumDistinctDoneesQuery = "select count(distinct donee) as numDonees from donations $causeAreaFilterQueryComponent";
$totalNumDistinctDoneesResult = $mysqli -> query($totalNumDistinctDoneesQuery);
for ($i = 0; $i < $totalNumDistinctDoneesResult -> num_rows; $i++) {
  $row = $totalNumDistinctDoneesResult -> fetch_assoc();
  $totalNumDistinctDonees = $row['numDonees'];
}
$donorQuery = "select donor,count(*) as numDonations, count(distinct donee) as numDonees from donations $causeAreaFilterQueryComponent group by donor;";
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

$donorAndYearQuery = "select donor, year(donation_date) as year, sum(amount) as amount from donations $causeAreaFilterQueryComponent group by donor, year(donation_date)";
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
print "  <tr>\n    <th>Donor</th>\n	<th>Number of donations</th>\n	<th>Number of donees</th>";
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
