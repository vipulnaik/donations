<?php

function print_stats($amountList, $rowName) {
  $n = count($amountList);
  if ($n > 0) {
    echo "<tr>\n";
    echo "<td>$rowName</td>\n";
    echo '<td align="right">' . $n . "</td>\n";  // count
    echo '<td align="right">' . number_format($amountList[ceil($n/2) - 1]) . "</td>\n";  // median
    echo '<td align="right">' . number_format(round(array_sum($amountList)/$n)) . "</td>\n";  // mean
    echo '<td align="right">' . number_format($amountList[0]) . "</td>\n";  // minimum
  
    // Calculate percentile using the nearest-rank method:
    // https://en.wikipedia.org/wiki/Percentile#The_nearest-rank_method
    // Since the array is 0-indexed, we need to subtract 1 from the resulting
    // rank.
    for ($i = 10; $i < 100; $i = $i + 10) {
      echo '<td align="right">' . number_format(max(0,$amountList[ceil($i/100 * $n) - 1])) . "</td>\n";  // 10..90th percentile
    }
  
    echo '<td align="right">' . number_format($amountList[$n - 1]) . "</td>\n";  // maximum
    echo "</tr>\n";
  }
}

?>