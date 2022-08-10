<?php

function linkDonees(string $doneeList, string $donor) {
  $donees = array_map(function ($donee) use ($donor) {
                        return '<a href="/donee.php?donee=' . urlencode($donee)
                          . '">' . htmlspecialchars($donee) . '</a>'
                          . ' (<a href="/donorDonee.php?donor=' . urlencode($donor)
                          . "&amp;donee=" . urlencode($donee) . '">filter this donee</a>)';
                      },
                      explode("|", $doneeList));
  return implode(", ", $donees);
}


print '<h4 id="influencerDonationAmountsByDonorAndYear">Donation amounts by donor and year for influencer '.$influencer.'</h4>'."\n";

$query = "select donor, group_concat(distinct donee order by donee separator '|') as donee_list from donations where influencer regexp ?";
$paramStr = "s";
$params = array($influencer);
if ($_REQUEST['cause_area_filter'] ?? '') {
  $query .= " and cause_area regexp ?";
  $paramStr .= "s";
  $params[] = $_REQUEST['cause_area_filter'];
}
$query .= " group by donor";
if ($stmt = $mysqli->prepare($query)) {
  $stmt->bind_param($paramStr, ...$params);
  $stmt->execute();
  $result = $stmt->get_result();
}

$donors = array();
while ($row = $result->fetch_assoc()) {
  $donors[] = $row['donor'];
  $doneesByDonor[$row['donor']] = $row['donee_list'];
}
$grandTotalDonationAmount = 0;
foreach($donors as $donor) {
  $donorDonationAmount[$donor] = 0;
  foreach($years as $year) {
    $yearDonationAmount[$year] = 0;
    $donationAmountByDonorAndYear[$donor][$year] = 0;
  }
}

// Query yearly donation data
$query = "select donor, year(donation_date) as year, sum(amount) as amount from donations where influencer regexp ?";
$params = array($influencer);
$paramStr = "s";
if ($_REQUEST['cause_area_filter'] ?? '') {
  $query .= " and cause_area regexp ?";
  $paramStr .= "s";
  $params[] = $_REQUEST['cause_area_filter'];
}
$query .= " group by donor, year(donation_date)";
if ($stmt = $mysqli->prepare($query)) {
  $stmt->bind_param($paramStr, ...$params);
  $stmt->execute();
  $result = $stmt->get_result();
}
while ($row = $result->fetch_assoc()) {
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

print '<table id="myTableInfluencerDonationAmountsByDonorAndYear" class="tablesorter">'."\n";
print "<thead>\n";
print "  <tr>\n    <th>Donor</th>\n    <th>Donees</th>\n";
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
  print '    <td>' . linkDonees($doneesByDonor[$donor], $donor) . '</td>' . "\n";
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
print "  <tr>\n    <td><strong>Total</strong></td>\n".'<td align="center">--</td>';

print '    <td align="right"><strong>'.number_format($grandTotalDonationAmount,2).'</strong></td>'."\n";

foreach ($years as $year) {
  if ($yearDonationAmount[$year] != 0) {
    print '    <td align="right"><strong>'.number_format($yearDonationAmount[$year],2)."</strong></td>\n";
  }
}

print "  </tr>\n";
print "</tfoot>\n";
print "</table>\n";

$permalinkUrlBase = "https://donations.vipulnaik.com/influencer.php?influencer=" . urlencode($influencer);

if ($causeAreaFilterString != '') {
  $permalinkUrlBase .= '&cause_area_filter='.urlencode($causeAreaFilterString);
}

if (count(array_filter($yearDonationAmount)) > 1) {
  $graphs = yearlyGraphs(
    $years,
    $donors,
    $yearDonationAmount,
    $donationAmountByDonorAndYear,
    $generateGraphCmdBase,
    $imagesPath,
    $permalinkUrlBase,
    "#influencerDonationAmountsByDonorAndYear"
  );

  print "<p><strong>Graph of spending by donee and year (incremental, not cumulative)</strong></p>";
  print '<img src="/images/'.$graphs[0].'-timeseries.png" alt="Graph of spending should have loaded here"></img>';

  print "<p><strong>Graph of spending by donee and year (cumulative)</strong></p>";
  print '<img src="/images/'.$graphs[1].'-timeseries.png" alt="Graph of spending should have loaded here"></img>';
} else {
  print "<p>Skipping spending graph as there is at most one year’s worth of donations.</p>\n";
}
?>
