<?php

function yearlyGroupings($mysqli, $generateGraphCmdBase, $imagesPath, $years,
    $donor, $groupName, $groupSqlCol, $causeAreaFilterString) {

  if ($donor != '') {
    $donorString = "donor";
  } else {
    $donorString = '';
  }
  print '<h4 id="' . $donorString . 'DonationAmountsBy' . $groupName
    . 'AndYear">' . "Donation amounts by $groupName and year</h4>";

  $totalNumDistinctDoneesQuery = <<<'EOD'
      select
          count(distinct donee) as numDonees
          from donations
EOD;
  if ($donor != '' && $causeAreaFilterString != '') {
    $totalNumDistinctDoneesQuery .= " where donor = ? and cause_area REGEXP ?";
  } else if ($donor != '') {
    $totalNumDistinctDoneesQuery .= " where donor = ?";
  } else if ($causeAreaFilterString != '') {
    $totalNumDistinctDoneesQuery .= " where cause_area REGEXP ?";
  }
  if ($stmt = $mysqli->prepare($totalNumDistinctDoneesQuery)) {
    if ($donor != '' && $causeAreaFilterString != '') {
      $stmt->bind_param("ss", $donor, $causeAreaFilterString);
    } else if ($donor != '') {
      $stmt->bind_param("s", $donor);
    } else if ($causeAreaFilterString != '') {
      $stmt->bind_param("s", $causeAreaFilterString);
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
      where $groupSqlCol is not NULL
EOD;
  if ($donor != '') {
    $groupQuery .= " and donor = ?";
  }
  if ($causeAreaFilterString != '') {
    $groupQuery .= " and cause_area REGEXP ?";
  }
  $groupQuery .= " group by $groupSqlCol";

  if ($stmt = $mysqli->prepare($groupQuery)) {
    if ($donor != '' && $causeAreaFilterString != '') {
      $stmt->bind_param("ss", $donor, $causeAreaFilterString);
    } else if ($donor != '') {
      $stmt->bind_param("s", $donor);
    } else if ($causeAreaFilterString != '') {
      $stmt->bind_param("s", $causeAreaFilterString);
    }
    $stmt->execute();
    $result = $stmt->get_result();
    $groupMembers = array();
    $numDoneesByGroup = array();
    $numDonationsByGroup = array();
    $grandTotalNumDonations = 0;
    while ($row = $result->fetch_assoc()) {
      array_push($groupMembers, $row[$groupSqlCol]);
      $numDoneesByGroup[$row[$groupSqlCol]] = $row['numDonees'];
      $numDonationsByGroup[$row[$groupSqlCol]] = $row['numDonations'];
      $grandTotalNumDonations += $row['numDonations'];
    }
  }

  $grandTotalDonationAmount = 0;
  $groupDonationAmount = array();
  $yearDonationAmount = array();
  $donationAmountByGroupAndYear = array();
  $numDoneesByGroupAndYear = array();
  $numDonationsByGroupAndYear = array();
  foreach($groupMembers as $g) {
    $groupDonationAmount[$g] = 0;
    foreach($years as $year) {
      $yearDonationAmount[$year] = 0;
      $donationAmountByGroupAndYear[$g][$year] = 0;
      $numDoneesByGroupAndYear[$g][$year] = 0;
      $numDonationsByGroupAndYear[$g][$year] = 0;
    }
  }

  $groupAndYearQuery = <<<EOD
      select
          $groupSqlCol,
          count(distinct donee) as numDonees,
          count(*) as numDonations,
          year(donation_date) as year,
          sum(amount) as amount
      from donations
      where $groupSqlCol is not NULL
EOD;
  if ($donor != '') {
    $groupAndYearQuery .= " and donor = ?";
  }
  if ($causeAreaFilterString != '') {
    $groupAndYearQuery .= " and cause_area REGEXP ?";
  }
  $groupAndYearQuery .= " group by $groupSqlCol, year(donation_date)";

  if ($stmt = $mysqli->prepare($groupAndYearQuery)) {
    if ($donor != '' && $causeAreaFilterString != '') {
      $stmt->bind_param("ss", $donor, $causeAreaFilterString);
    } else if ($donor != '') {
      $stmt->bind_param("s", $donor);
    } else if ($causeAreaFilterString != '') {
      $stmt->bind_param("s", $causeAreaFilterString);
    }
    $stmt->execute();
    $result = $stmt->get_result();
    while ($row = $result->fetch_assoc()) {
      $donationAmountByGroupAndYear[$row[$groupSqlCol]][$row['year']] =
        $row['amount'];
      $numDoneesByGroupAndYear[$row[$groupSqlCol]][$row['year']] =
        $row['numDonees'];
      $numDonationsByGroupAndYear[$row[$groupSqlCol]][$row['year']] =
        $row['numDonations'];
      $groupDonationAmount[$row[$groupSqlCol]] += $row['amount'];
      $yearDonationAmount[$row['year']] += $row['amount'];
      $grandTotalDonationAmount += $row['amount'];
    }
  }

  usort($groupMembers, function($a, $b) use ($groupDonationAmount) {
    return intval($groupDonationAmount[$b]) - intval($groupDonationAmount[$a]);
  });

  if (sizeof($groupMembers) > 0) {

    print "<p>If you hover over a cell for a given $groupName and year, "
      . "you will get a tooltip with the number of donees and the number of "
      . "donations.</p>\n";

    print "<p>Note: Cause area classification used here may not match that "
      ."used by donor for all cases.</p>\n";

    print '<table id="myTableDonorDonationAmountsByGroupAndYear" '
      . 'class="tablesorter">' . "\n";
    print "<thead>\n";
    print "  <tr>\n  <th>$groupName</th>\n";
    print "  <th>Number of donations</th>\n";
    print "  <th>Number of donees</th>\n";
    print "    <th>Total</th>\n";
    foreach ($years as $year) {
      if ($yearDonationAmount[$year] != 0) {
        print "    <th>$year</th>\n";
      }
    }
    print "</tr>\n</thead>\n<tbody>\n";

    foreach ($groupMembers as $g) {
      print "  <tr>\n";
      print "    <td>$g</td>\n";
      print '    <td align="right">' . $numDonationsByGroup[$g]
        . "</td>\n";
      print '    <td align="right">' . $numDoneesByGroup[$g]
        . "</td>\n";
      print '    <td align="right"><strong>'
        . number_format($groupDonationAmount[$g], 2)
        . "</strong></td>\n";
      foreach ($years as $year) {
        if ($yearDonationAmount[$year] != 0) {
          print '    <td align="right"><a title="'
            . sprintf("%d", $numDonationsByGroupAndYear[$g][$year])
            . ' donations to '
            . sprintf("%d", $numDoneesByGroupAndYear[$g][$year])
            . ' distinct donees">'
            . number_format($donationAmountByGroupAndYear[$g][$year],
              2)
            . "</a></td>\n";
        }
      }
      print "  </tr>\n";
    }

    print "</tbody>\n";
    print "<tfoot>\n";
    print "  <tr>\n    <td><strong>Total</strong></td>\n";
    print '    <td align="right"><strong>' . $grandTotalNumDonations
      . "</strong></td>\n";
    print '    <td align="right"><strong>' . $totalNumDistinctDonees
      . "</strong></td>\n";
    print '    <td align="right"><strong>'
      . number_format($grandTotalDonationAmount,2) . "</strong></td>\n";

    foreach ($years as $year) {
      if ($yearDonationAmount[$year] != 0) {
        print '    <td align="right"><strong>'
          . number_format($yearDonationAmount[$year],2) . "</strong></td>\n";
      }
    }

    print "  </tr>\n";
    print "</tfoot>\n";
    print "</table>";

    if ($donor != '') {
      $permalinkUrlBase = "https://donations.vipulnaik.com/donor.php?donor="
        . urlencode($donor);
    } else {
      $permalinkUrlBase = "https://donations.vipulnaik.com/index.php";
    }

    if ($causeAreaFilterString != '') {
      $permalinkUrlBase .=
        '&cause_area_filter=' . urlencode($causeAreaFilterString);
    }

    $graphs = yearlyGraphs(
      $years,
      $groupMembers,
      $yearDonationAmount,
      $donationAmountByGroupAndYear,
      $generateGraphCmdBase,
      $imagesPath,
      $permalinkUrlBase,
      "#" . $donorString . "DonationAmountsBy" . $groupName . "AndYear"
    );

    print "<p><strong>Graph of spending by $groupName and year "
      . "(incremental, not cumulative)</strong></p>";
    print '<img src="/images/' . $graphs[0] . '-timeseries.png" '
      . 'alt="Graph of spending should have loaded here"></img>';

    print "<p><strong>Graph of spending by $groupName and year "
      . "(cumulative)</strong></p>";
    print '<img src="/images/' . $graphs[1] . '-timeseries.png" '
      . 'alt="Graph of spending should have loaded here"></img>';
  } else {
    print "Sorry, we couldn't find any $groupName information.";
  }
}
?>
