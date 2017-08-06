<?php

print '<h4 id="donationAmountsByInfluencerAndYear">Donation amounts by influencer and year</h4>';

$influencerQuery = "select influencer from donations where influencer is not NULL";
if ($causeAreaFilterString != '') {
  $influencerQuery .= " and cause_area REGEXP ?";
}
$influencerQuery .= " group by influencer";
if ($stmt = $mysqli->prepare($influencerQuery)) {
  if ($causeAreaFilterString != '') {
    $stmt->bind_param("s", $causeAreaFilterString);
  }
  $stmt->execute();
  $result = $stmt->get_result();
  $influencers = array();
  while ($row = $result->fetch_assoc()) {
    array_push($influencers, $row['influencer']);
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
        year(donation_date) as year,
        sum(amount) as amount
    from donations
    where influencer is not NULL
EOD;
if ($causeAreaFilterString != '') {
  $influencerAndYearQuery .= " and cause_area REGEXP ?";
}
$influencerAndYearQuery .= " group by influencer, year(donation_date)";
if ($stmt = $mysqli->prepare($influencerAndYearQuery)) {
  if ($causeAreaFilterString != '') {
    $stmt->bind_param("s", $causeAreaFilterString);
  }
  $stmt->execute();
  $result = $stmt->get_result();
  while ($row = $result->fetch_assoc()) {
    $donationAmountByInfluencerAndYear[$row['influencer']][$row['year']] = $row['amount'];
    $influencerDonationAmount[$row['influencer']] += $row['amount'];
    $yearDonationAmount[$row['year']] += $row['amount'];
    $grandTotalDonationAmount += $row['amount'];
  }
}

function cmpInfluencerByAmount($firstInfluencer, $secondInfluencer) {
  global $influencerDonationAmount;
  if (intval($influencerDonationAmount[$firstInfluencer]) == intval($influencerDonationAmount[$secondInfluencer])) {
    return 0;
  }
  return (intval($influencerDonationAmount[$firstInfluencer]) > intval($influencerDonationAmount[$secondInfluencer])) ? -1 : 1;
}

usort($influencers, "cmpInfluencerByAmount");

print '<table id="myTableDonationAmountsByInfluencerAndYear" class="tablesorter">'."\n";
print "<thead>\n";
print "  <tr>\n    <th>Influencer</th>\n";
print "    <th>Total</th>\n";
foreach ($years as $year) {
  if ($yearDonationAmount[$year] != 0) {
    print "    <th>$year</th>\n";
  }
}
print "  </tr>\n";
print "</thead>\n<tbody>\n";

foreach ($influencers as $influencer) {
  print "  <tr>\n";
  print "    <td>$influencer</td>\n";
  print '    <td align="right"><strong>'.number_format($influencerDonationAmount[$influencer],2)."</strong></td>\n";
  foreach ($years as $year) {
    if ($yearDonationAmount[$year] != 0) {
      print '    <td align="right">'.number_format($donationAmountByInfluencerAndYear[$influencer][$year],2)."</td>\n";
    }
  }
  print "  </tr>\n";
}

print "</tbody>\n";
print "<tfoot>\n";
print "  <tr>\n    <td><strong>Total</strong></td>\n";

print '    <td align="right"><strong>'.number_format($grandTotalDonationAmount,2)."</strong></td>\n";
foreach ($years as $year) {
  if ($yearDonationAmount[$year] != 0) {
    print '    <td align="right"><strong>'.number_format($yearDonationAmount[$year],2)."</strong></td>\n";
  }
}
print "  </tr>\n";
print "</tfoot>\n";
print "</table>";

$permalinkUrlBase = "https://donations.vipulnaik.com/index.php";

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
  "#donationAmountsByInfluencerAndYear"
);

print "<p><strong>Graph of spending by influencer and year (incremental, not cumulative)</strong></p>";
print '<img src="/images/'.$graphs[0].'-timeseries.png" alt="Graph of spending should have loaded here"></img>';

print "<p><strong>Graph of spending by influencer and year (cumulative)</strong></p>";
print '<img src="/images/'.$graphs[1].'-timeseries.png" alt="Graph of spending should have loaded here"></img>';
