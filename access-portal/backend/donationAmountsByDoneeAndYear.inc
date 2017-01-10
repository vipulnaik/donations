<?php

print '<h4 id="donationAmountsByDoneeAndYear">Donation amounts by donee and year</h4>';

$years = array_reverse(range(2001, 2017));

# We'll change the below to reference an explicit donees table, when that's made
$doneeQuery = "select distinct donee from donations;";
$doneeResult = $mysqli -> query($doneeQuery);
$donees = array();
for ($i = 0; $i < $doneeResult -> num_rows; $i++) {
  $row = $doneeResult -> fetch_assoc();
  array_push($donees, $row['donee']);
}
$grandTotalDonationAmount = 0;
foreach($donees as $donee) {
  $doneeDonationAmount[$donee] = 0;
  foreach($years as $year) {
    $yearDonationAmount[$year] = 0;
    $donationAmountByDoneeAndYear[$donee][$year] = 0;
  }
}

$doneeAndYearQuery = "select donee, year(donation_date) as year, sum(amount) as amount from donations group by donee, year";
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

print '<table id="myTable2" class="tablesorter">'."\n";
print "<thead>\n";
print '<tr><th>Donee</th>';
foreach ($years as $year) {
  if ($yearDonationAmount[$year] > 0) {
    print "<th>$year</th>";
  }
}
print '<th>Total</th></tr>';
print "</thead>\n<tbody>\n";

foreach ($donees as $donee) {
  print "<tr>";
  print "<td>$donee</td>";
  foreach ($years as $year) {
    if ($yearDonationAmount[$year] > 0) {
      print '<td align="right">'.sprintf("%.2f",$donationAmountByDoneeAndYear[$donee][$year]).'</td>';
    }
  }
  print '<td align="right"><strong>'.sprintf("%.2f",$doneeDonationAmount[$donee]).'</strong></td>';
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
print "</tbody>\n";
print "</table>";
