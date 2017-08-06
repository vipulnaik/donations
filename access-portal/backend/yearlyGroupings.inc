<?php

function yearlyGroupings($years, $group, $groupSqlCol, $causeAreaFilterString) {
  print '<h4 id="donorDonationAmountsBy' . $group . 'AndYear">'
    . "Donation amounts by $group and year</h4>";

  $totalNumDistinctDoneesQuery = <<<'EOD'
      select
          count(distinct donee) as numDonees
          from donations where donor = ?
EOD;
  if ($causeAreaFilterString != '') {
    $totalNumDistinctDoneesQuery .= " and cause_area REGEXP ?";
  }
  if ($stmt = $mysqli->prepare($totalNumDistinctDoneesQuery)) {
    if ($causeAreaFilterString != '') {
      $stmt->bind_param("ss", $donor, $causeAreaFilterString);
    } else {
      $stmt->bind_param("s", $donor);
    }
    $stmt->execute();
    $result = $stmt->get_result();
    while ($row = $result->fetch_assoc()) {
      $totalNumDistinctDonees = $row['numDonees'];
    }
  }

  $groupQuery = <<<EOD
      select
          $groupSqlCol,
          count(distinct donee) as numDonees,
          count(*) as numDonations
      from donations
      where $groupSqlCol is not NULL and donor = ?
EOD;
  if ($causeAreaFilterString != '') {
    $groupQuery .= " and cause_area REGEXP ?";
  }
  $groupQuery .= " group by $group";

  if ($stmt = $mysqli->prepare($groupQuery)) {
    if ($causeAreaFilterString != '') {
      $stmt->bind_param("ss", $donor, $causeAreaFilterString);
    } else {
      $stmt->bind_param("s", $donor);
    }
    $stmt->execute();
    $result = $stmt->get_result();
    $groups = array();
    $grandTotalNumDonations = 0;
    while ($row = $result->fetch_assoc()) {
      array_push($groups, $row[$group]);
      $numDoneesByGroup[$row[$group]] = $row['numDonees'];
      $numDonationsByGroup[$row[$group]] = $row['numDonations'];
      $grandTotalNumDonations += $row['numDonations'];
    }
  }
  $grandTotalDonationAmount = 0;
  foreach($groups as $group) {
    $groupDonationAmount[$group] = 0;
    foreach($years as $year) {
      $yearDonationAmount[$year] = 0;
      $donationAmountByGroupAndYear[$group][$year] = 0;
      $numDoneesByGroupAndYear[$group][$year] = 0;
      $numDonationsByGroupAndYear[$group][$year] = 0;
    }
  }

  $groupAndYearQuery = <<<EOD
      select
          $group,
          count(distinct donee) as numDonees,
          count(*) as numDonations,
          year(donation_date) as year,
          sum(amount) as amount
      from donations
      where $group is not NULL and donor = ?
EOD;
  if ($causeAreaFilterString != '') {
    $groupAndYearQuery .= " and cause_area REGEXP ?";
  }
  $groupAndYearQuery .= " group by $group, year(donation_date)";

  if ($stmt = $mysqli->prepare($groupAndYearQuery)) {
    if ($causeAreaFilterString != '') {
      $stmt->bind_param("ss", $donor, $causeAreaFilterString);
    } else {
      $stmt->bind_param("s", $donor);
    }
    $stmt->execute();
    $result = $stmt->get_result();
    while ($row = $result->fetch_assoc()) {
      $donationAmountByGroupAndYear[$row[$group]][$row['year']] =
        $row['amount'];
      $numDoneesByGroupAndYear[$row[$group]][$row['year']] =
        $row['numDonees'];
      $numDonationsByGroupAndYear[$row[$group]][$row['year']] =
        $row['numDonations'];
      $groupDonationAmount[$row[$group]] += $row['amount'];
      $yearDonationAmount[$row['year']] += $row['amount'];
      $grandTotalDonationAmount += $row['amount'];
    }
  }

  function cmpGroupsByAmount($firstGroup, $secondGroup) {
    global $groupDonationAmount;
    if (intval($groupDonationAmount[$firstGroup]) ==
        intval($groupDonationAmount[$secondGroup])) {
      return 0;
    }
    return (intval($groupDonationAmount[$firstGroup]) >
      intval($groupDonationAmount[$secondGroup])) ? -1 : 1;
  }

  usort($groups, "cmpGroupsByAmount");

  print "<p>If you hover over a cell for a given $group and year, "
    . "you will get a tooltip with the number of donees and the number of "
    . "donations.</p>\n";

  print "<p>Note: Cause area classification used here may not match that used "
    . "by donor for all cases.</p>\n";

  print '<table id="myTableDonorDonationAmountsByGroupAndYear" '
    . 'class="tablesorter">' . "\n";
  print "<thead>\n";
  print "  <tr>\n  <th>$group</th>\n";
  print "  <th>Number of donations</th>\n";
  print "  <th>Number of donees</th>\n";
  print "    <th>Total</th>\n";
  foreach ($years as $year) {
    if ($yearDonationAmount[$year] != 0) {
      print "    <th>$year</th>\n";
    }
  }
  print "</tr>\n</thead>\n<tbody>\n";

  foreach ($groups as $group) {
    print "  <tr>\n";
    print "    <td>$group</td>\n";
    print '    <td align="right">' . $numDonationsByGroup[$group]
      . "</td>\n";
    print '    <td align="right">' . $numDoneesByGroup[$group]
      . "</td>\n";
    print '    <td align="right"><strong>'
      . number_format($groupDonationAmount[$group], 2)
      . "</strong></td>\n";
    foreach ($years as $year) {
      if ($yearDonationAmount[$year] != 0) {
        print '    <td align="right"><a title="'
          . sprintf("%d", $numDonationsByGroupAndYear[$group][$year])
          . ' donations to '
          . sprintf("%d", $numDoneesByGroupAndYear[$group][$year])
          . ' distinct donees">'
          . number_format($donationAmountByGroupAndYear[$group][$year],
            2)
          . "</a></td>\n";
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
    $groups,
    $yearDonationAmount,
    $donationAmountByGroupAndYear,
    $generateGraphCmdBase,
    $imagesPath,
    $permalinkUrlBase,
    "#donorDonationAmountsByGroupAndYear"
  );

  print "<p><strong>Graph of spending by $group and year (incremental, not cumulative)</strong></p>";
  print '<img src="/images/'.$graphs[0].'-timeseries.png" alt="Graph of spending should have loaded here"></img>';

  print "<p><strong>Graph of spending by $group and year (cumulative)</strong></p>";
  print '<img src="/images/'.$graphs[1].'-timeseries.png" alt="Graph of spending should have loaded here"></img>';
}
?>
