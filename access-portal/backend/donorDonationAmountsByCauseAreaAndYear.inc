<?php

print '<h4 id="donorDonationAmountsByCauseAreaAndYear">Donation amounts by cause area and year</h4>';

$years = array_reverse(range(2001, 2017));

$causeAreaQuery = "select substring_index(cause_area,'/',1) as cause_area from donations where donor='".$donor."' group by substring_index(cause_area,'/',1)";
$causeAreaResult = $mysqli -> query($causeAreaQuery);
$causeAreas = array();
for ($i = 0; $i < $causeAreaResult -> num_rows; $i++) {
  $row = $causeAreaResult -> fetch_assoc();
  array_push($causeAreas, $row['cause_area']);
}
$grandTotalDonationAmount = 0;
foreach($causeAreas as $causeArea) {
  $causeAreaDonationAmount[$causeArea] = 0;
  foreach($years as $year) {
    $yearDonationAmount[$year] = 0;
    $donationAmountByCauseAreaAndYear[$causeArea][$year] = 0;
  }
}

$causeAreaAndYearQuery = "select substring_index(cause_area,'/',1) as cause_area, year(donation_date) as year, sum(amount) as amount from donations where donor='".$donor."' group by substring_index(cause_area,'/',1), year(donation_date)";
$causeAreaAndYearResult = $mysqli -> query($causeAreaAndYearQuery);

for ($i=0; $i < $causeAreaAndYearResult -> num_rows; $i++) {
  $row = $causeAreaAndYearResult -> fetch_assoc();
  $donationAmountByCauseAreaAndYear[$row['cause_area']][$row['year']] = $row['amount'];
  $causeAreaDonationAmount[$row['cause_area']] += $row['amount'];
  $yearDonationAmount[$row['year']] += $row['amount'];
  $grandTotalDonationAmount += $row['amount'];
}

function cmpCauseAreasByAmount($firstCauseArea, $secondCauseArea) {
  global $causeAreaDonationAmount;
  if (intval($causeAreaDonationAmount[$firstCauseArea]) == intval($causeAreaDonationAmount[$secondCauseArea])) {
    return 0;
  }
  return (intval($causeAreaDonationAmount[$firstCauseArea]) > intval($causeAreaDonationAmount[$secondCauseArea])) ? -1 : 1;
}

usort($causeAreas, "cmpCauseAreasByAmount");

print '<table id="myTableDonorDonationAmountsByCauseAreaAndYear" class="tablesorter">'."\n";
print "<thead>\n";
print "  <tr><th>Cause area</th>\n";
foreach ($years as $year) {
  if ($yearDonationAmount[$year] > 0) {
    print "    <th>$year</th>\n";
  }
}
print "    <th>Total</th>\n  </tr>\n";
print "</thead>\n<tbody>\n";

foreach ($causeAreas as $causeArea) {
  print "  <tr>\n";
  print "    <td>$causeArea</td>\n";
  foreach ($years as $year) {
    if ($yearDonationAmount[$year] > 0) {
      print '    <td align="right">'.sprintf("%.2f",$donationAmountByCauseAreaAndYear[$causeArea][$year])."</td>\n";
    }
  }
  print '    <td align="right"><strong>'.sprintf("%.2f",$causeAreaDonationAmount[$causeArea])."</strong></td>\n";
  print "  </tr>\n";
}

print "</tbody>\n";
print "<tfoot>\n";
print "  <tr>\n    <td><strong>Total</strong></td>\n";

foreach ($years as $year) {
  if ($yearDonationAmount[$year] > 0) {
    print '    <td align="right"><strong>'.sprintf("%.2f",$yearDonationAmount[$year])."</strong></td>\n";
  }
}

print '    <td align="right"><strong>'.sprintf("%.2f",$grandTotalDonationAmount)."</strong></td>\n";
print "  </tr>\n";
print "</tfoot>\n";
print "</table>";
