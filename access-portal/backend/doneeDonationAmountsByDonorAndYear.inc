<?php

print '<h4 id="doneeDonationAmountsByDonorAndYear">Donation amounts by donor and year for donee '.htmlspecialchars($donee).'</h4>'."\n";

$donorQuery = "select donor from donations where donee = ? group by donor;";
$stmt = $mysqli->prepare($donorQuery);
$stmt->bind_param("s", $donee);
$stmt->execute();
$donorResult = $stmt->get_result();
$donors = array();
for ($i = 0; $i < $donorResult -> num_rows; $i++) {
  $row = $donorResult -> fetch_assoc();
  array_push($donors, $row['donor']);
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

$donorAndYearQuery = "select donor, year(donation_date) as year, sum(amount) as amount from donations where donee = ? and donation_date is not null group by donor, year(donation_date)";
$stmt = $mysqli->prepare($donorAndYearQuery);
$stmt->bind_param("s", $donee);
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

print '<table id="myTableDoneeDonationAmountsByDonorAndYear" class="tablesorter">'."\n";
print "<thead>\n";
print "  <tr>\n    <th>Donor</th>\n";
print "    <th>Total</th>\n";
foreach ($years as $year) {
  if ($yearDonationAmount[$year] != 0) {
    print "    <th>$year</th>\n";
  }
}
print "    </tr>\n";
print "</thead>\n<tbody>\n";

foreach ($donors as $donor) {
  print "  <tr>\n";
  print '    <td><a href="/donor.php?donor=' . urlencode($donor) . '">'
    . $donor . '</a>'
    . ' (<a href="/donorDonee.php?donor=' . urlencode($donor) . '&amp;donee='
    . urlencode($donee) . '">filter this donee</a>)'
    .'</td>'."\n";
  print '    <td align="right"><strong>'.number_format($donorDonationAmount[$donor],2).'</strong></td>'."\n";
  foreach ($years as $year) {
    if ($yearDonationAmount[$year] != 0) {
      print '    <td align="right">'.number_format($donationAmountByDonorAndYear[$donor][$year],2).'</td>'."\n";
    }
  }
  print "  </tr>\n";
}

print "</tbody>\n";
print "<tfoot>\n";
print "  <tr>\n    <td><strong>Total</strong></td>\n";

print '    <td align="right"><strong>'.number_format($grandTotalDonationAmount,2).'</strong></td>'."\n";

foreach ($years as $year) {
  if (isset($yearDonationAmount[$year]) && $yearDonationAmount[$year] != 0) {
    print '    <td align="right"><strong>'.number_format($yearDonationAmount[$year],2)."</strong></td>\n";
  }
}

print "  </tr>\n";
print "</tfoot>\n";
print "</table>\n";
