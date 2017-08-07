<?php

function distinctDonees($mysqli, $causeAreaFilterString, $donor,
    $classifiedString) {

  $query = <<<'EOD'
      select
          count(distinct donee) as numDonees
          from donations
EOD;
  if ($classifiedString) {
    $query .= " where $classifiedString";
  } else {
    $query .= " where TRUE";
  }
  if ($donor != '') {
    $query .= " and donor = ?";
  }
  if ($causeAreaFilterString != '') {
    $query .= " and cause_area REGEXP ?";
  }
  if ($stmt = $mysqli->prepare($query)) {
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
      $numDonees = $row['numDonees'];
    }
    return $numDonees;
  }
}

function yearlyGroupings($mysqli, $generateGraphCmdBase, $imagesPath, $years,
    $donor, $groupName, $groupSqlCol, $causeAreaFilterString) {

  /* This array is three-dimensional with group BY year BY value, e.g.
   * $data['United States'][2015]['amount'] if the grouping is country. All the
   * data will be stored here and pulled out when printing the table. */
  $data = array();
  $groupMembers = array("Classified", "Total");
  foreach ($groupMembers as $g) {
    $data[$g]['Total']['numDonations'] = 0;
    $data[$g]['Total']['numDonees'] = 0;
    $data[$g]['Total']['amount'] = 0;
  }

  if ($donor != '') {
    $donorString = "donor";
  } else {
    $donorString = '';
  }
  print '<h4 id="' . $donorString . 'DonationAmountsBy' . $groupName
    . 'AndYear">' . "Donation amounts by $groupName and year</h4>";

  $groupQuery = <<<EOD
      select
          case when $groupSqlCol is NULL
              then 'Unclassified'
              else $groupSqlCol
              end as $groupSqlCol,
          count(distinct donee) as numDonees,
          count(*) as numDonations
      from donations
      where TRUE
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
    while ($row = $result->fetch_assoc()) {
      $col = $row[$groupSqlCol];
      array_push($groupMembers, $col);
      $data[$col]['Total']['numDonations'] = $row['numDonations'];
      $data[$col]['Total']['numDonees'] = $row['numDonees'];
      $data['Total']['Total']['numDonations'] += $row['numDonations'];
      $data['Total']['Total']['numDonees'] += $row['numDonees'];
      if ($col != 'Unclassified') {
        $data['Classified']['Total']['numDonations'] = $row['numDonations'];
        /* We have to get the Classified numDonees separately */
      }
    }
  }

  foreach($groupMembers as $g) {
    $data[$g]['Total']['amount'] = 0;
    foreach($years as $year) {
      $data[$g][$year]['amount'] = 0;
      $data[$g][$year]['numDonations'] = 0;
      $data[$g][$year]['numDonees'] = 0;
    }
  }

  $groupAndYearQuery = <<<EOD
      select
          case when $groupSqlCol is NULL
              then 'Unclassified'
              else $groupSqlCol
              end as $groupSqlCol,
          count(distinct donee) as numDonees,
          count(*) as numDonations,
          year(donation_date) as year,
          sum(amount) as amount
      from donations
      where TRUE
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
      $col = $row[$groupSqlCol];
      $y = $row['year'];
      $data[$col][$y]['amount'] = $row['amount'];
      $data[$col][$y]['numDonations'] = $row['numDonations'];
      $data[$col][$y]['numDonees'] = $row['numDonees'];

      $data[$col]['Total']['amount'] += $row['amount'];

      $data['Total'][$y]['numDonations'] += $row['numDonations'];
      $data['Total'][$y]['numDonees'] += $row['numDonees'];
      $data['Total'][$y]['amount'] += $row['amount'];

      if ($col != 'Unclassified') {
        $data['Classified'][$y]['amount'] += $row['amount'];
        $data['Classified'][$y]['numDonations'] += $row['numDonations'];
        $data['Classified'][$y]['numDonees'] += $row['numDonees'];
      }
    }
  }

  usort($groupMembers, function($a, $b) use ($data) {
    return intval($data[$b]['Total']['amount']) - intval($data[$a]['Total']['amount']);
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
    print "  <tr>\n  <th>" . ucfirst($groupName) . "</th>\n";
    print "  <th>Number of donations</th>\n";
    print "  <th>Number of donees</th>\n";
    print "    <th>Total</th>\n";
    foreach ($years as $year) {
      if ($data['Total'][$year]['amount'] != 0) {
        print "    <th>$year</th>\n";
      }
    }
    print "</tr>\n</thead>\n<tbody>\n";

    foreach ($groupMembers as $g) {
      print "  <tr>\n";
      print "    <td>$g</td>\n";
      print '    <td align="right">' . $data[$g]['Total']['numDonations']
        . "</td>\n";
      print '    <td align="right">' . $data[$g]['Total']['numDonees']
        . "</td>\n";
      print '    <td align="right"><strong>'
        . number_format($data[$g]['Total']['amount'], 2)
        . "</strong></td>\n";
      foreach ($years as $year) {
        if ($data['Total'][$year]['amount'] != 0) {
          print '    <td align="right"><a title="'
            . sprintf("%d", $data[$g][$year]['numDonations'])
            . ' donations to '
            . sprintf("%d", $data[$g][$year]['numDonees'])
            . ' distinct donees">'
            . number_format($data[$g][$year]['amount'],
              2)
            . "</a></td>\n";
        }
      }
      print "  </tr>\n";
    }

    print "</tbody>\n";
    print "<tfoot>\n";

    /* Classified total */
    print "  <tr>\n";
    print '    <td><strong>Classified total' . "</strong></td>\n";
    print '    <td align="right"><strong>';
    print $data['Classified']['Total']['numDonations'] . '</strong></td>';
    print '    <td align="right"><strong>';
    print distinctDonees($mysqli, $causeAreaFilterString, $donor,
      "$groupSqlCol is not NULL");
    print "</strong></td>\n";
    print '    <td align="right"><strong>' . $data['Classified']['Total']['amount']
      . '</strong></td>';
    foreach ($years as $year) {
      if ($data['Total'][$year]['amount'] != 0) {
        print '    <td align="right"><strong>'
          . number_format($data['Total'][$year]['amount'],2) . "</strong></td>\n";
      }
    }

    print "  </tr>\n";

    /* Unclassified total */
    print "  <tr>\n";
    print '    <td><strong>Unclassified total' . "</strong></td>\n";
    print '    <td align="right"><strong>';
    print "</strong></td>\n";
    print '    <td align="right"><strong>';
    print distinctDonees($mysqli, $causeAreaFilterString, $donor,
      "$groupSqlCol is NULL");
    print "</strong></td>\n";
    print "  </tr>\n";

    /* Grand total */
    print "  <tr>\n";
    print "    <td><strong>Total</strong></td>\n";
    print '    <td align="right"><strong>' . $data['Total']['Total']['amount']
      . "</strong></td>\n";
    print '    <td align="right"><strong>' . distinctDonees($mysqli,
      $causeAreaFilterString, $donor, "") . "</strong></td>\n";
    print '    <td align="right"><strong>'
      . number_format($data['Total']['Total']['amount'], 2) . "</strong></td>\n";
    foreach ($years as $year) {
      if ($data['Total'][$year]['amount'] != 0) {
        print '    <td align="right"><strong>'
          . number_format($data['Total'][$year]['amount'],2) . "</strong></td>\n";
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

    /* FIXME */
    $yearlist = array();
    foreach ($years as $y) {
      array_push($yearlist, $data['Total'][$y]['amount']);
    }

    /* $graphs = yearlyGraphs( */
    /*   $years, */
    /*   $groupMembers, */
    /*   $yearlist, */
    /*   $donationAmountByGroupAndYear, /1* FIXME *1/ */
    /*   $generateGraphCmdBase, */
    /*   $imagesPath, */
    /*   $permalinkUrlBase, */
    /*   "#" . $donorString . "DonationAmountsBy" . $groupName . "AndYear" */
    /* ); */

    /* print "<p><strong>Graph of spending by $groupName and year " */
    /*   . "(incremental, not cumulative)</strong></p>"; */
    /* print '<img src="/images/' . $graphs[0] . '-timeseries.png" ' */
    /*   . 'alt="Graph of spending should have loaded here"></img>'; */

    /* print "<p><strong>Graph of spending by $groupName and year " */
    /*   . "(cumulative)</strong></p>"; */
    /* print '<img src="/images/' . $graphs[1] . '-timeseries.png" ' */
    /*   . 'alt="Graph of spending should have loaded here"></img>'; */
  } else {
    print "Sorry, we couldn't find any $groupName information.";
  }
}
?>
