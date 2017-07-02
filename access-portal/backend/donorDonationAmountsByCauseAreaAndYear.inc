<?php

print '<h4 id="donorDonationAmountsByCauseAreaAndYear">Donation amounts by cause area and year</h4>';

$totalNumDistinctDoneesQuery = "select count(distinct donee) as numDonees from donations where donor='$donor' $causeAreaFilterQueryComponent;";
$totalNumDistinctDoneesResult = $mysqli -> query($totalNumDistinctDoneesQuery);
for ($i = 0; $i < $totalNumDistinctDoneesResult -> num_rows; $i++) {
  $row = $totalNumDistinctDoneesResult -> fetch_assoc();
  $totalNumDistinctDonees = $row['numDonees'];
}
$causeAreaQuery = "select substring_index(cause_area,'/',1) as cause_area,count(distinct donee) as numDonees,count(*) as numDonations from donations where donor='$donor' $causeAreaFilterQueryComponent group by substring_index(cause_area,'/',1)";
$causeAreaResult = $mysqli -> query($causeAreaQuery);
$causeAreas = array();
$grandTotalNumDonations = 0;
for ($i = 0; $i < $causeAreaResult -> num_rows; $i++) {
  $row = $causeAreaResult -> fetch_assoc();
  array_push($causeAreas, $row['cause_area']);
  $numDoneesByCauseArea[$row['cause_area']] = $row['numDonees'];
  $numDonationsByCauseArea[$row['cause_area']] = $row['numDonations'];
  $grandTotalNumDonations += $row['numDonations'];
}
$grandTotalDonationAmount = 0;
foreach($causeAreas as $causeArea) {
  $causeAreaDonationAmount[$causeArea] = 0;
  foreach($years as $year) {
    $yearDonationAmount[$year] = 0;
    $donationAmountByCauseAreaAndYear[$causeArea][$year] = 0;
  }
}

$causeAreaAndYearQuery = "select substring_index(cause_area,'/',1) as cause_area, count(distinct donee) as numDonees, count(*) as numDonations, year(donation_date) as year, sum(amount) as amount from donations where donor='$donor' $causeAreaFilterQueryComponent group by substring_index(cause_area,'/',1), year(donation_date)";
$causeAreaAndYearResult = $mysqli -> query($causeAreaAndYearQuery);

for ($i=0; $i < $causeAreaAndYearResult -> num_rows; $i++) {
  $row = $causeAreaAndYearResult -> fetch_assoc();
  $donationAmountByCauseAreaAndYear[$row['cause_area']][$row['year']] = $row['amount'];
  $numDoneesByCauseAreaAndYear[$row['cause_area']][$row['year']] = $row['numDonees'];
  $numDonationsByCauseAreaAndYear[$row['cause_area']][$row['year']] = $row['numDonations'];
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

print "<p>If you hover over a cell for a given cause area and year, you will get a tooltip with the number of donees and the number of donations.</p>\n";

print "<p>Note: Cause area classification used here may not match that used by donor for all cases.</p>\n";

print '<table id="myTableDonorDonationAmountsByCauseAreaAndYear" class="tablesorter">'."\n";
print "<thead>\n";
print "  <tr><th>Cause area</th>\n";
print "	 <th>Number of donations</th>\n";
print "	 <th>Number of donees</th>\n";
foreach ($years as $year) {
  if ($yearDonationAmount[$year] > 0) {
    print "    <th>$year</th>\n";
  }
}
print "    <th>Total</th>\n  </tr>\n";
print "</thead>\n<tbody>\n";

foreach ($causeAreas as $causeArea) {
  print "  <tr>\n";
  print "    <td>".'<a href="/?cause_area_filter='.urlencode($causeArea).'">'."$causeArea</a> (".'<a href="/donor.php?donor='.urlencode($donor).'&cause_area_filter='.urlencode($causeArea).'">filter this donor</a>'.")</td>\n";
  print '    <td align="right">'.$numDonationsByCauseArea[$causeArea]."</td>\n";
  print '    <td align="right">'.$numDoneesByCauseArea[$causeArea]."</td>\n";
  foreach ($years as $year) {
    if ($yearDonationAmount[$year] > 0) {
      print '    <td align="right"><a title="'.sprintf("%d",$numDonationsByCauseAreaAndYear[$causeArea][$year]).' donations to '.sprintf("%d",$numDoneesByCauseAreaAndYear[$causeArea][$year]).' distinct donees">'.number_format($donationAmountByCauseAreaAndYear[$causeArea][$year],2)."</a></td>\n";
    }
  }
  print '    <td align="right"><strong>'.number_format($causeAreaDonationAmount[$causeArea],2)."</strong></td>\n";
  print "  </tr>\n";
}

print "</tbody>\n";
print "<tfoot>\n";
print "  <tr>\n    <td><strong>Total</strong></td>\n";
print '    <td align="right"><strong>'.$grandTotalNumDonations."</strong></td>\n";
print '    <td align="right"><strong>'.$totalNumDistinctDonees."</strong></td>\n";


foreach ($years as $year) {
  if ($yearDonationAmount[$year] > 0) {
    print '    <td align="right"><strong>'.number_format($yearDonationAmount[$year],2)."</strong></td>\n";
  }
}

print '    <td align="right"><strong>'.number_format($grandTotalDonationAmount,2)."</strong></td>\n";
print "  </tr>\n";
print "</tfoot>\n";
print "</table>";

$dataForGraph = "Year";
$dataForCumulativeGraph = "Year";
foreach ($causeAreas as $causeArea) {
  $dataForGraph .= "|$causeArea";
  $dataForCumulativeGraph .= "|$causeArea";
}
$dataForGraph .= "|Total\n";
$dataForCumulativeGraph .= "|Total\n";

foreach (array_reverse($years) as $year) {
  if ($yearDonationAmount[$year] > 0) {
    $dataForGraph .= "$year";
    $dataForCumulativeGraph .= "$year";
    foreach ($causeAreas as $causeArea) {
      if (!isset($cumulativeForCauseArea[$causeArea])) {
        $cumulativeForCauseArea = 0;
      }
      $cumulativeForCauseArea[$causeArea] += $donationAmountByCauseAreaAndYear[$causeArea][$year];
      $dataForGraph .= "|".sprintf("%d",$donationAmountByCauseAreaAndYear[$causeArea][$year]);
      $dataForCumulativeGraph .= "|".sprintf("%d",$cumulativeForCauseArea[$causeArea]);
    }
    $cumulativeTotal += $yearDonationAmount[$year];
    $dataForGraph .= "|".sprintf("%d",$yearDonationAmount[$year])."\n";
    $dataForCumulativeGraph .= "|".sprintf("%d",$cumulativeTotal)."\n";
  }
}

$permalinkUrl = "https://donations.vipulnaik.com/donor.php?donor=" + urlencode($donor) + "#donorDonationAmountsByCauseAreaAndYear";
$fileName = hash("md5",$permalinkUrl);
$filePathBase = $imagesPath . $fileName;
$dataHasChanged = false;
if (file_exists($filePathBase . ".csv") == false) {
  # print "<br/>There is no file with the CSV $filePathBase . csv, so we are writing it out<br/>";
  file_put_contents($filePathBase . ".csv", $dataForGraph);
  $dataHasChanged = true;
} else {
  $previousOutput = file_get_contents($filePathBase . ".csv");
  if ($previousOutput != $dataForGraph) {
    # print "<br/>We have a cached file but the underlying data has changed<br/><br/>";
    $dataHasChanged = true;
    file_put_contents($filePathBase . ".csv", $dataForGraph);
  } else {
    # print "<br/>The cached file contents match the existing data<br/><br/>";
  }
}
$cmdToExecute = $generateGraphCmdBase . " " . $filePathBase . ".csv " . $filePathBase . "-timeseries.png";
if ($dataHasChanged == true or file_exists($filePathBase . "-timeseries.png") == false) {
  if (file_exists($filePathBase . "-timeseries.png") == true) {
    exec("rm ".$filePathBase . "-timeseries.png");
  }
  exec($cmdToExecute);
}

# Cumulative version
$fileNameCumulative = hash("md5",$permalinkUrl + "-cumulative");
$filePathBaseCumulative = $imagesPath . $fileNameCumulative;
$dataHasChangedCumulative = false;
if (file_exists($filePathBaseCumulative . ".csv") == false) {
  # print "<br/>There is no file with the CSV $filePathBaseCumulative . csv, so we are writing it out<br/>";
  file_put_contents($filePathBaseCumulative . ".csv", $dataForCumulativeGraph);
  $dataHasChangedCumulative = true;
} else {
  $previousOutput = file_get_contents($filePathBaseCumulative . ".csv");
  if ($previousOutput != $dataForGraphCumulative) {
    # print "<br/>We have a cached file but the underlying data has changed<br/><br/>";
    $dataHasChangedCumulative = true;
    file_put_contents($filePathBaseCumulative . ".csv", $dataForCumulativeGraph);
  } else {
    # print "<br/>The cached file contents match the existing data<br/><br/>";
  }
}
$cmdToExecuteCumulative = $generateGraphCmdBase . " " . $filePathBaseCumulative . ".csv " . $filePathBase . "-timeseries.png";
if ($dataHasChangedCumulative == true or file_exists($filePathBaseCumulative . "-timeseries.png") == false) {
  if (file_exists($filePathBaseCumulative . "-timeseries.png") == true) {
    exec("rm ".$filePathBaseCumulative . "-timeseries.png");
  }
  exec($cmdToExecuteCumulative);
}



print "<p><strong>Graph of spending by cause area and year (incremental, not cumulative)</strong></p>";
print '<img src="/images/'.$fileName.'-timeseries.png" alt="Graph of spending should have loaded here"></img>';

print "<p><strong>Graph of spending by cause area and year (cumulative)</strong></p>";
print '<img src="/images/'.$fileNameCumulative.'-timeseries.png" alt="Graph of spending should have loaded here"></img>';

