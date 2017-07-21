<?php

function yearlyGraphs($years, $donees, $yearDonationAmount, $donationAmountByDoneeAndYear, $generateGraphCmdBase, $imagesPath, $donor) {
  $cumulativeTotal = 0;
  $cumulativeForDonee = array();
  $dataForGraph = "Year";
  $dataForCumulativeGraph = "Year";

  foreach ($donees as $donee) {
    $dataForGraph .= "|$donee";
    $dataForCumulativeGraph .= "|$donee";
  }
  $dataForGraph .= "|Total\n";
  $dataForCumulativeGraph .= "|Total\n";

  /* Populate all the yearly rows */
  foreach (array_reverse($years) as $year) {
    if ($yearDonationAmount[$year] > 0) {
      $dataForGraph .= "$year";
      $dataForCumulativeGraph .= "$year";
      foreach ($donees as $donee) {
        if (!isset($cumulativeForDonee[$donee])) {
          $cumulativeForDonee[$donee] = 0;
        }
        $cumulativeForDonee[$donee] +=
          $donationAmountByDoneeAndYear[$donee][$year];
        $dataForGraph .= "|" .
          sprintf("%d", $donationAmountByDoneeAndYear[$donee][$year]);
        $dataForCumulativeGraph .= "|" .
          sprintf("%d", $cumulativeForDonee[$donee]);
      }
      $cumulativeTotal += $yearDonationAmount[$year];
      $dataForGraph .= "|" . sprintf("%d", $yearDonationAmount[$year]) . "\n";
      $dataForCumulativeGraph .= "|" . sprintf("%d", $cumulativeTotal) . "\n";
    }
  }

  /* Populate the totals row */
  $dataForGraph .= "Total";
  $dataForCumulativeGraph .= "Total";
  foreach ($donees as $donee) {
    if (!isset($cumulativeForDonee[$donee])) {
      $cumulativeForDonee[$donee] = 0;
    }
    $dataForGraph .= "|" . sprintf("%d", $cumulativeForDonee[$donee]);
    $dataForCumulativeGraph .= "|" . sprintf("%d", $cumulativeForDonee[$donee]);
  }
  $dataForGraph .= "|" . sprintf("%d", $cumulativeTotal) . "\n";
  $dataForCumulativeGraph .= "|" . sprintf("%d", $cumulativeTotal) . "\n";

  $permalinkUrlBase = "https://donations.vipulnaik.com/donor.php?donor=" .
    urlencode($donor);
  /* if (isset($causeAreaFilterString) and $causeAreaFilterString != '') { */
  /*   $permalinkUrlBase .= "&cause_area_filter=".urlencode($causeAreaFilterString); */
  /* } */
  $permalinkUrl = $permalinkUrlBase . "#donorDonationAmountsByDoneeAndYear";
  $fileName = hash("md5", $permalinkUrl);
  $filePathBase = $imagesPath . $fileName;
  $dataHasChanged= false;
  if (file_exists(! $filePathBase . ".csv")) {
    file_put_contents($filePathBase . ".csv", $dataForGraph);
    $dataHasChanged = true;
  } else {
    $previousOutput = file_get_contents($filePathBase . ".csv");
    if ($previousOutput != $dataForGraph) {
      $dataHasChanged = true;
      file_put_contents($filePathBase . ".csv", $dataForGraph);
    }
  }

  /* Incremental graph */
  $cmdToExecute = $generateGraphCmdBase . " " . $filePathBase . ".csv " .
    $filePathBase . "-timeseries.png";
  if ($dataHasChanged or ! file_exists($filePathBase . "-timeseries.png")) {
    if (file_exists($filePathBase . "-timeseries.png")) {
      exec("rm " . $filePathBase . "-timeseries.png");
    }
    exec($cmdToExecute);
  }

  /* Cumulative graph */
  $fileNameCumulative = hash("md5", $permalinkUrl . "-cumulative");
  $filePathBaseCumulative = $imagesPath . $fileNameCumulative;
  $dataHasChangedCumulative = false;
  if (! file_exists($filePathBaseCumulative . ".csv")) {
    file_put_contents($filePathBaseCumulative . ".csv", $dataForCumulativeGraph);
    $dataHasChangedCumulative = true;
  } else {
    $previousOutput = file_get_contents($filePathBaseCumulative . ".csv");
    if ($previousOutput != $dataForCumulativeGraph) {
      $dataHasChangedCumulative = true;
      file_put_contents($filePathBaseCumulative . ".csv", $dataForCumulativeGraph);
    }
  }
  $cmdToExecuteCumulative = $generateGraphCmdBase . " " . $filePathBaseCumulative . ".csv " . $filePathBaseCumulative . "-timeseries.png";
  if ($dataHasChangedCumulative or ! file_exists($filePathBaseCumulative . "-timeseries.png")) {
    if (file_exists($filePathBaseCumulative . "-timeseries.png")) {
      exec("rm ".$filePathBaseCumulative . "-timeseries.png");
    }
    exec($cmdToExecuteCumulative);
  }

  return array($fileName, $fileNameCumulative);
}

?>
