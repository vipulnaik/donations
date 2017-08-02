<?php

print '<h4 id="donationAmountsByCauseAreaAndYear">Donation amounts by cause area and year</h4>';

$causeAreaQuery = "select substring_index(cause_area,'/',1) as cause_area from donations $causeAreaFilterQueryComponent group by substring_index(cause_area,'/',1)";
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

$causeAreaAndYearQuery = "select substring_index(cause_area,'/',1) as cause_area, year(donation_date) as year, sum(amount) as amount from donations $causeAreaFilterQueryComponent group by substring_index(cause_area,'/',1), year(donation_date)";
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

print '<table id="myTableDonationAmountsByCauseAreaAndYear" class="tablesorter">'."\n";
print "<thead>\n";
print "  <tr><th>Cause area</th>\n";
print "    <th>Total</th>\n";
foreach ($years as $year) {
  if ($yearDonationAmount[$year] > 0) {
    print "    <th>$year</th>\n";
  }
}
print "	</tr>\n";
print "</thead>\n<tbody>\n";

foreach ($causeAreas as $causeArea) {
  print "  <tr>\n";
  print "    <td>".'<a href="/?cause_area_filter='.urlencode($causeArea).'">'."$causeArea</a></td>\n";
  print '    <td align="right"><strong>'.number_format($causeAreaDonationAmount[$causeArea],2)."</strong></td>\n";
  foreach ($years as $year) {
    if ($yearDonationAmount[$year] > 0) {
      print '    <td align="right">'.number_format($donationAmountByCauseAreaAndYear[$causeArea][$year],2)."</td>\n";
    }
  }
  print "  </tr>\n";
}

print "</tbody>\n";
print "<tfoot>\n";
print "  <tr>\n    <td><strong>Total</strong></td>\n";

print '    <td align="right"><strong>'.number_format($grandTotalDonationAmount,2)."</strong></td>\n";
foreach ($years as $year) {
  if ($yearDonationAmount[$year] > 0) {
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
  $causeAreas,
  $yearDonationAmount,
  $donationAmountByCauseAreaAndYear,
  $generateGraphCmdBase,
  $imagesPath,
  $permalinkUrlBase,
  "#donationAmountsByCauseAreaAndYear"
);

print "<p><strong>Graph of spending by cause area and year (incremental, not cumulative)</strong></p>";
print '<img src="/images/'.$graphs[0].'-timeseries.png" alt="Graph of spending should have loaded here"></img>';

print "<p><strong>Graph of spending by cause area and year (cumulative)</strong></p>";
print '<img src="/images/'.$graphs[1].'-timeseries.png" alt="Graph of spending should have loaded here"></img>';
