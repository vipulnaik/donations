<?php

include_once("printStats.inc");

echo '<h4 id="donorStatistics">Donor donation statistics</h4>';

if (!empty($_REQUEST['cause_area_filter'])) {
  $query = "select donor,amount,substring_index(cause_area,'/',1) as cause_area from donations where donor = ? and cause_area REGEXP ? order by amount asc";
} else {
  $query = "select donor,amount,substring_index(cause_area,'/',1) as cause_area from donations where donor = ? order by amount asc";
}

if ($stmt = $mysqli->prepare($query)) {
  if (!empty($_REQUEST['cause_area_filter'])) {
    $stmt->bind_param("ss", $donor, $_REQUEST['cause_area_filter']);
  } else {
    $stmt->bind_param("s", $donor);
  }
  $stmt->execute();
  $result = $stmt->get_result();
  $amountList = array();
  $causesList = array();
  while ($row = $result->fetch_assoc()) {
    $amountList[] = $row['amount'];
    $causesList[$row['cause_area']][] = $row['amount'];
  }
  if (count($amountList) > 0) {
    echo '<table id="myTableDonorStatistics" class="tablesorter">';
    echo "<thead>\n";
    echo "<tr>\n";
    echo "<th>Cause area</th>";
    echo "<th>Count</th>";
    echo "<th>Median</th>";
    echo "<th>Mean</th>";
    echo "<th>Minimum</th>";
    for ($i = 10; $i < 100; $i = $i + 10) {
      echo "<th>$i" . "th percentile</th>\n";  // 10..90th percentile
    }
    echo "<th>Maximum</th>";
    echo "</tr>\n";
    echo "</thead>\n";
    echo "<tbody>\n";
    print_stats($amountList, "Overall");
    foreach($causesList as $cause => $amounts) {
      print_stats($amounts, $cause);
    }
    echo "</tbody>\n";
    echo "</table>\n";
  } else {
    echo '<p>No donations recorded so far, so not printing the statistics table!</p>';
  }
}
