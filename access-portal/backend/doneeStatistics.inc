<?php

include_once("printStats.inc");

echo '<h4 id="doneeStatistics">Donee donation statistics</h4>';

if ($stmt = $mysqli->prepare("select donee,amount,substring_index(cause_area,'/',1) as cause_area from donations where donee = ? order by amount asc")) {
  $stmt->bind_param("s", $donee);
  $stmt->execute();
  $result = $stmt->get_result();
  $amountList = array();
  $causesList = array();
  while ($row = $result->fetch_assoc()) {
    $amountList[] = $row['amount'];
    $causesList[$row['cause_area']][] = $row['amount'];
  }
  echo '<table id="myTableDoneeStatistics" class="tablesorter">';
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
}
