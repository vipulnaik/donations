<?php

print '<h4 id="donorDonationAmountsByInfluencerAndYear">Donation amounts by influencer and year</h4>';

$totalNumDistinctDoneesQuery = <<<'EOD'
    select
        count(distinct donee) as numDonees
        from donations where donor = ?
EOD;
if ($causeAreaFilterString != '') {
  $totalNumDistinctDoneesQuery .= " and cause_area REGEXP ?";
}
$totalNumDistinctDoneesResult = $mysqli -> query($totalNumDistinctDoneesQuery);
for ($i = 0; $i < $totalNumDistinctDoneesResult -> num_rows; $i++) {
  $row = $totalNumDistinctDoneesResult -> fetch_assoc();
  $totalNumDistinctDonees = $row['numDonees'];
}

$influencerQuery = <<<'EOD'
    select
        influencer,
        count(distinct donee) as numDonees,
        count(*) as numDonations
    from donations
    where influencer is not NULL and donor = ?
EOD;
if ($causeAreaFilterString != '') {
  $influencerQuery .= " and cause_area REGEXP ?";
}
$influencerQuery .= " group by influencer";

if ($stmt = $mysqli->prepare($influencerQuery)) {
  if ($causeAreaFilterString != '') {
    $stmt->bind_param("ss", $donor, $causeAreaFilterString);
  } else {
    $stmt->bind_param("s", $donor);
  }
  $stmt->execute();
  $result = $stmt->get_result();
  $influencers = array();
  $grandTotalNumDonations = 0;
  while ($row = $result->fetch_assoc()) {
    array_push($influencers, $row['influencer']);
    $numDoneesByInfluencer[$row['influencer']] = $row['numDonees'];
    $numDonationsByInfluencer[$row['influencer']] = $row['numDonations'];
    $grandTotalNumDonations += $row['numDonations'];
  }
}
$grandTotalDonationAmount = 0;
foreach($influencers as $influencer) {
  $influencerDonationAmount[$influencer] = 0;
  foreach($years as $year) {
    $yearDonationAmount[$year] = 0;
    $donationAmountByInfluencerAndYear[$influencer][$year] = 0;
  }
}

$influencerAndYearQuery = <<<'EOD'
    select
        influencer,
        count(distinct donee) as numDonees,
        count(*) as numDonations,
        year(donation_date) as year,
        sum(amount) as amount
    from donations
    where influencer is not NULL and donor = ?
EOD;
if ($causeAreaFilterString != '') {
  $influencerAndYearQuery .= " and cause_area REGEXP ?";
}
$influencerAndYearQuery .= " group by influencer, year(donation_date)";

if ($stmt = $mysqli->prepare($influencerAndYearQuery)) {
  if ($causeAreaFilterString != '') {
    $stmt->bind_param("ss", $donor, $causeAreaFilterString);
  } else {
    $stmt->bind_param("s", $donor);
  }
  $stmt->execute();
  $result = $stmt->get_result();
  while ($row = $result->fetch_assoc()) {
    $donationAmountByInfluencerAndYear[$row['influencer']][$row['year']] =
      $row['amount'];
    $numDoneesByInfluencerAndYear[$row['influencer']][$row['year']] =
      $row['numDonees'];
    $numDonationsByInfluencerAndYear[$row['influencer']][$row['year']] =
      $row['numDonations'];
    $influencerDonationAmount[$row['influencer']] += $row['amount'];
    $yearDonationAmount[$row['year']] += $row['amount'];
    $grandTotalDonationAmount += $row['amount'];
  }
}

function cmpInfluencersByAmount($firstInfluencer, $secondInfluencer) {
  global $influencerDonationAmount;
  if (intval($influencerDonationAmount[$firstInfluencer]) == intval($influencerDonationAmount[$secondInfluencer])) {
    return 0;
  }
  return (intval($influencerDonationAmount[$firstInfluencer]) > intval($influencerDonationAmount[$secondInfluencer])) ? -1 : 1;
}

usort($influencers, "cmpInfluencersByAmount");

print "<p>If you hover over a cell for a given influencer and year, you will get a tooltip with the number of donees and the number of donations.</p>\n";

print "<p>Note: Cause area classification used here may not match that used by donor for all cases.</p>\n";

print '<table id="myTableDonorDonationAmountsByInfluencerAndYear" class="tablesorter">'."\n";
print "<thead>\n";
print "  <tr><th>Influencer</th>\n";
print "  <th>Number of donations</th>\n";
print "  <th>Number of donees</th>\n";
print "    <th>Total</th>\n";
foreach ($years as $year) {
  if ($yearDonationAmount[$year] != 0) {
    print "    <th>$year</th>\n";
  }
}
print "</tr>\n</thead>\n<tbody>\n";

foreach ($influencers as $influencer) {
  print "  <tr>\n";
  print "    <td>".'<a href="/?cause_area_filter='.urlencode($influencer).'">'."$influencer</a> (".'<a href="/donor.php?donor='.urlencode($donor).'&cause_area_filter='.urlencode($influencer).'">filter this donor</a>'.")</td>\n";
  print '    <td align="right">'.$numDonationsByInfluencer[$influencer]."</td>\n";
  print '    <td align="right">'.$numDoneesByInfluencer[$influencer]."</td>\n";
  print '    <td align="right"><strong>'.number_format($influencerDonationAmount[$influencer],2)."</strong></td>\n";
  foreach ($years as $year) {
    if ($yearDonationAmount[$year] != 0) {
      print '    <td align="right"><a title="'.sprintf("%d",$numDonationsByInfluencerAndYear[$influencer][$year]).' donations to '.sprintf("%d",$numDoneesByInfluencerAndYear[$influencer][$year]).' distinct donees">'.number_format($donationAmountByInfluencerAndYear[$influencer][$year],2)."</a></td>\n";
    }
  }
  print "  </tr>\n";
}

print "</tbody>\n";
print "<tfoot>\n";
print "  <tr>\n    <td><strong>Total</strong></td>\n";
print '    <td align="right"><strong>'.$grandTotalNumDonations."</strong></td>\n";
print '    <td align="right"><strong>'.$totalNumDistinctDonees."</strong></td>\n";
print '    <td align="right"><strong>'.number_format($grandTotalDonationAmount,2)."</strong></td>\n";

foreach ($years as $year) {
  if ($yearDonationAmount[$year] != 0) {
    print '    <td align="right"><strong>'.number_format($yearDonationAmount[$year],2)."</strong></td>\n";
  }
}

print "  </tr>\n";
print "</tfoot>\n";
print "</table>";

$permalinkUrlBase = "https://donations.vipulnaik.com/donor.php?donor=" . urlencode($donor);

if ($causeAreaFilterString != '') {
  $permalinkUrlBase .= '&cause_area_filter='.urlencode($causeAreaFilterString);
}

$graphs = yearlyGraphs(
  $years,
  $influencers,
  $yearDonationAmount,
  $donationAmountByInfluencerAndYear,
  $generateGraphCmdBase,
  $imagesPath,
  $permalinkUrlBase,
  "#donorDonationAmountsByInfluencerAndYear"
);

print "<p><strong>Graph of spending by influencer and year (incremental, not cumulative)</strong></p>";
print '<img src="/images/'.$graphs[0].'-timeseries.png" alt="Graph of spending should have loaded here"></img>';

print "<p><strong>Graph of spending by influencer and year (cumulative)</strong></p>";
print '<img src="/images/'.$graphs[1].'-timeseries.png" alt="Graph of spending should have loaded here"></img>';

