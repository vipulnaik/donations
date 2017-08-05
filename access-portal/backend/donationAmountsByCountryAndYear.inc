<?php

print '<h4 id="donationAmountsByCountryAndYear">Donation amounts by country and year</h4>';

$countryQuery = "select affected_countries from donations where affected_countries is not NULL group by affected_countries";
$countryResult = $mysqli -> query($countryQuery);
$countries = array();
for ($i = 0; $i < $countryResult -> num_rows; $i++) {
  $row = $countryResult -> fetch_assoc();
  array_push($countries, $row['affected_countries']);
}

$grandTotalDonationAmount = 0;
foreach($countries as $country) {
  $countryDonationAmount[$country] = 0;
  foreach($years as $year) {
    $yearDonationAmount[$year] = 0;
    $donationAmountByCountryAndYear[$country][$year] = 0;
  }
}

$countryAndYearQuery = "select affected_countries, year(donation_date) as year, sum(amount) as amount from donations where affected_countries is not NULL group by affected_countries, year(donation_date)";
$countryAndYearResult = $mysqli -> query($countryAndYearQuery);

for ($i=0; $i < $countryAndYearResult -> num_rows; $i++) {
  $row = $countryAndYearResult -> fetch_assoc();
  $donationAmountByCountryAndYear[$row['affected_countries']][$row['year']] = $row['amount'];
  $countryDonationAmount[$row['affected_countries']] += $row['amount'];
  $yearDonationAmount[$row['year']] += $row['amount'];
  $grandTotalDonationAmount += $row['amount'];
}

function cmpCountryByAmount($firstCountry, $secondCountry) {
  global $countryDonationAmount;
  if (intval($countryDonationAmount[$firstCountry]) == intval($countryDonationAmount[$secondCountry])) {
    return 0;
  }
  return (intval($countryDonationAmount[$firstCountry]) > intval($countryDonationAmount[$secondCountry])) ? -1 : 1;
}

usort($countries, "cmpCountryByAmount");

print '<table id="myTableDonationAmountsByCountryAndYear" class="tablesorter">'."\n";
print "<thead>\n";
print "  <tr>\n    <th>Country</th>\n";
print "    <th>Total</th>\n";
foreach ($years as $year) {
  if ($yearDonationAmount[$year] != 0) {
    print "    <th>$year</th>\n";
  }
}
print "  </tr>\n";
print "</thead>\n<tbody>\n";

foreach ($countries as $country) {
  print "  <tr>\n";
  print "    <td>$country</td>\n";
  print '    <td align="right"><strong>'.number_format($countryDonationAmount[$country],2)."</strong></td>\n";
  foreach ($years as $year) {
    if ($yearDonationAmount[$year] != 0) {
      print '    <td align="right">'.number_format($donationAmountByCountryAndYear[$country][$year],2)."</td>\n";
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
  $countries,
  $yearDonationAmount,
  $donationAmountByCountryAndYear,
  $generateGraphCmdBase,
  $imagesPath,
  $permalinkUrlBase,
  "#donationAmountsByCountryAndYear"
);

print "<p><strong>Graph of spending by country and year (incremental, not cumulative)</strong></p>";
print '<img src="/images/'.$graphs[0].'-timeseries.png" alt="Graph of spending should have loaded here"></img>';

print "<p><strong>Graph of spending by country and year (cumulative)</strong></p>";
print '<img src="/images/'.$graphs[1].'-timeseries.png" alt="Graph of spending should have loaded here"></img>';
