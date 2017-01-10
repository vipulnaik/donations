<?php

print '<h4 id="donationAmountsByDonorAndYear">Donation amounts by donor and year</h4>';

$years = array_reverse(range(2001, 2017));
$donorQuery = "select donor,count(distinct donee) as numDonees from donations group by donor;";
$donorResult = $mysqli -> query($donorQuery);
$donors = array();
for ($i = 0; $i < $donorResult -> num_rows; $i++) {
  $row = $donorResult -> fetch_assoc();
  array_push($donors, $row['donor']);
  $numDonees[$row['donor']] = $row['numDonees'];
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

print '<table border="1">';
print '<tr><th>Donor</th>';
foreach ($years as $year) {
  if ($yearDonationAmount[$year] > 0) {
    print "<th>$year</th>";
  }
}
print '<th>Total</th></tr>';

foreach ($donors as $donor) {
  print "<tr>";
  print "<td>$donor (".$numDonees[$donor]." donee";
  if ($numDonees[$donor] != 1) {
    print "s";
  }
  print ")</td>";
  foreach ($years as $year) {
    if ($yearDonationAmount[$year] > 0) {
      print '<td align="right">'.sprintf("%.2f",$donationAmountByDonorAndYear[$donor][$year]).'</td>';
    }
  }
  print '<td align="right"><strong>'.sprintf("%.2f",$donorDonationAmount[$donor]).'</strong></td>';
  print "</tr>";
}

print "<tr><td><strong>Total</strong></td>";

foreach ($years as $year) {
  if ($yearDonationAmount[$year] > 0) {
    print '<td align="right"><strong>'.sprintf("%.2f",$yearDonationAmount[$year]).'</td>';
  }
}

print '<td align="right"><strong>'.sprintf("%.2f",$grandTotalDonationAmount).'</td>';
print "</tr>";
print "</table>";
