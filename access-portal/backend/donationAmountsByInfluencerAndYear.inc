<?php

print '<h4 id="donationAmountsByInfluencerAndYear">Donation amounts by influencer and year</h4>';

$influencerQuery = "select influencer from donations where influencer is not NULL group by influencer";
$influencerResult = $mysqli -> query($influencerQuery);
$influencers = array();
for ($i = 0; $i < $influencerResult -> num_rows; $i++) {
  $row = $influencerResult -> fetch_assoc();
  array_push($influencers, $row['influencer']);
}

$grandTotalDonationAmount = 0;
foreach($influencers as $influencer) {
  $influencerDonationAmount[$influencer] = 0;
  foreach($years as $year) {
    $yearDonationAmount[$year] = 0;
    $donationAmountByInfluencerAndYear[$influencer][$year] = 0;
  }
}

$influencerAndYearQuery = "select influencer, year(donation_date) as year, sum(amount) as amount from donations where influencer is not NULL group by influencer, year(donation_date)";
$influencerAndYearResult = $mysqli -> query($influencerAndYearQuery);

for ($i=0; $i < $influencerAndYearResult -> num_rows; $i++) {
  $row = $influencerAndYearResult -> fetch_assoc();
  $donationAmountByInfluencerAndYear[$row['influencer']][$row['year']] = $row['amount'];
  $influencerDonationAmount[$row['influencer']] += $row['amount'];
  $yearDonationAmount[$row['year']] += $row['amount'];
  $grandTotalDonationAmount += $row['amount'];
}

function cmpCauseAreasByAmount($firstCauseArea, $secondCauseArea) {
  global $influencerDonationAmount;
  if (intval($influencerDonationAmount[$firstCauseArea]) == intval($influencerDonationAmount[$secondCauseArea])) {
    return 0;
  }
  return (intval($influencerDonationAmount[$firstCauseArea]) > intval($influencerDonationAmount[$secondCauseArea])) ? -1 : 1;
}

usort($influencers, "cmpCauseAreasByAmount");

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
  print "    <td>".'<a href="/?cause_area_filter='.urlencode($influencer).'">'."$influencer</a></td>\n";
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
