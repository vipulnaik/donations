<?php

print '<h4 id="donationAmountsByDonorAndYear">Donation amounts by donor and year</h4>'."\n";

$years = array_reverse(range(2001, 2017));
$donorQuery = "select distinct donor from donors;";
$donorResult = $mysqli -> query($donorQuery);
$donors = array();
for ($i = 0; $i < $donorResult -> num_rows; $i++) {
  $row = $donorResult -> fetch_assoc();
  array_push($donors, $row['donor']);
}
$grandTotalDonationAmount = 0;
foreach($donors as $donor) {
  $donorDonationAmount[$donor] = 0;
  foreach($years as $year) {
    $yearDonationAmount[$year] = 0;
    $donationAmountByDonorAndYear[$donor][$year] = 0;
  }
}

$donorAndYearQuery = "select donor, year(donation_date) as year, sum(amount) as amount from donations group by donor, year";
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

print '<table id="myTable" class="tablesorter">'."\n";
print "<thead>\n";
print "  <tr>\n    <th>Donor</th>\n";
foreach ($years as $year) {
  if ($yearDonationAmount[$year] > 0) {
    print "    <th>$year</th>\n";
  }
}
print "    <th>Total</th>\n  </tr>\n";
print "</thead>\n<tbody>\n";

foreach ($donors as $donor) {
  print "  <tr>\n";
  print "    <td>$donor</td>\n";
  foreach ($years as $year) {
    if ($yearDonationAmount[$year] > 0) {
      print '    <td align="right">'.sprintf("%.2f",$donationAmountByDonorAndYear[$donor][$year]).'</td>'."\n";
    }
  }
  print '    <td align="right"><strong>'.sprintf("%.2f",$donorDonationAmount[$donor]).'</strong></td>'."\n";
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

print '    <td align="right"><strong>'.sprintf("%.2f",$grandTotalDonationAmount).'</strong></td>'."\n";
print "  </tr>\n";
print "</tfoot>\n";
print "</table>\n";
