<?php

function distinctDonees($mysqli, $causeAreaFilterString, $donor,
    $classifiedString, $donorRestriction = "") {

  $query = <<<'EOD'
      select
          count(distinct donee) as numDonees
          from donations
EOD;
  if ($classifiedString) {
    $query .= " where donation_date is not null and $classifiedString";
  } else {
    $query .= " where donation_date is not null";
  }
  if ($donorRestriction) {
    $query .= " and $donorRestriction";
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

function printFooterRow($data, $years, $rowName, $rowLabel) {
  print "  <tr>\n";
  print "    <td><strong>" . htmlspecialchars($rowLabel) . "</strong></td>\n";
  print '    <td align="right"><strong>'
    . ($data['numDonations'][$rowName]['Total'] ?? 0)
    . "</strong></td>\n";
  print '    <td align="right"><strong>'
    . ($data['numDonees'][$rowName]['Total'] ?? 0)
    . "</strong></td>\n";
  print '    <td align="right"><strong>'
    . number_format($data['amount'][$rowName]['Total'] ?? 0, 2)
    . "</strong></td>\n";
  foreach ($years as $year) {
    if (($data['amount']['Classified'][$year] ?? 0) != 0) {
      print '    <td align="right"><strong>'
        . number_format($data['amount'][$rowName][$year] ?? 0, 2)
        . "</strong></td>\n";
    }
  }
  print "  </tr>\n";
}

/**
 * Produce a yearly grouping in terms of $groupName (corresponding to
 * $groupSqlCol in the donations table), and print an HTML table of the
 * grouping. Use this method only if the classified total should equal the sum
 * of the group members (see
 * https://github.com/vipulnaik/donations/blob/master/classified-and-unclassified.md#classified-total-vs-sum-of-group-members-blue
 * for more information).
 *
 * @param int    $limit            A number giving the maximum possible group
 *                                 elements to show. This is only in effect if
 *                                 greater than zero.
 * @param string $donorRestriction A string describing how the donors in the
 *                                 queries are restricted. This should be part
 *                                 of a "where" clause in SQL.
 */
function yearlyGroupings($mysqli, $generateGraphCmdBase, $imagesPath, $years,
    $donor, $groupName, $groupSqlCol, $causeAreaFilterString,
    $groupMemberLink, $limit = -1, $donorRestriction = "") {

  /* This array is three-dimensional with value BY group BY year, e.g.
   * $data['amount']['United States'][2015] if the grouping is country. All the
   * data will be stored here and pulled out when printing the table. */
  $data = array();
  $groupMembers = array("Classified", "Unclassified", "Total");
  foreach ($groupMembers as $g) {
    $data['numDonations'][$g]['Total'] = 0;
    $data['numDonees'][$g]['Total'] = 0;
  }

  $groupQuery = <<<EOD
      select
          case when $groupSqlCol is NULL
              then 'Unclassified'
              else $groupSqlCol
              end as $groupSqlCol,
          count(distinct donee) as numDonees,
          count(*) as numDonations
      from donations
      where donation_date is not null
EOD;
  if ($donorRestriction) {
    $groupQuery .= " and $donorRestriction";
  }
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
      if ($col != 'Unclassified') {
        array_push($groupMembers, $col);
      }

      $data['numDonations'][$col]['Total'] = $row['numDonations'];
      $data['numDonees'][$col]['Total'] = $row['numDonees'];

      $data['numDonations']['Total']['Total'] += $row['numDonations'];

      if ($col != 'Unclassified') {
        $data['numDonations']['Classified']['Total'] += $row['numDonations'];
        /* We have to get the Classified numDonees separately */
      }

      /* Unclassified is included in the SQL query result so we don't need to
       * separately set values for that. */
    }
  }

  foreach($groupMembers as $g) {
    $data['amount'][$g]['Total'] = 0;
    foreach($years as $year) {
      $data['amount'][$g][$year] = 0;
      $data['numDonations'][$g][$year] = 0;
      $data['numDonees'][$g][$year] = 0;
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
      where donation_date is not null
EOD;
  if ($donorRestriction) {
    $groupAndYearQuery .= " and $donorRestriction";
  }
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

      $data['amount'][$col][$y] = $row['amount'];
      $data['numDonations'][$col][$y] = $row['numDonations'];
      $data['numDonees'][$col][$y] = $row['numDonees'];

      $data['amount'][$col]['Total'] = $data['amount'][$col]['Total'] ?? 0;
      $data['amount'][$col]['Total'] += $row['amount'];

      $data['numDonations']['Total'][$y] += $row['numDonations'];
      $data['numDonees']['Total'][$y] += $row['numDonees'];
      $data['amount']['Total'][$y] += $row['amount'];
      $data['amount']['Total']['Total'] += $row['amount'];

      if ($col != 'Unclassified') {
        $data['amount']['Classified'][$y] += $row['amount'];
        $data['numDonations']['Classified'][$y] += $row['numDonations'];
        $data['numDonees']['Classified'][$y] += $row['numDonees'];
        $data['amount']['Classified']['Total'] += $row['amount'];
      }
    }
  }

  $data['numDonees']['Classified']['Total'] = distinctDonees($mysqli,
    $causeAreaFilterString, $donor, "$groupSqlCol is not NULL",
    $donorRestriction);
  $data['numDonees']['Total']['Total'] = distinctDonees($mysqli,
    $causeAreaFilterString, $donor, "", $donorRestriction);

  usort($groupMembers, function($a, $b) use ($data) {
    return intval($data['amount'][$b]['Total'])
      - intval($data['amount'][$a]['Total']);
  });
  if ($limit > 0) {
    $groupMembers = array_slice($groupMembers, 0, $limit);
  }

  printYearlyGroupedHtmlTable(
    $data,
    $groupName,
    $groupMembers,
    $groupMemberLink,
    $years,
    $causeAreaFilterString,
    $donor,
    $generateGraphCmdBase,
    $imagesPath,
    ""
  );

}

function camelCaseStripSpace($str) {
  $result = "";
  $words = explode(" ", $str);
  foreach ($words as $w) {
    $result .= ucfirst($w);
  }
  return $result;
}

function printYearlyGroupedHtmlTable(
  $data,
  $groupName,
  $groupMembers,
  $groupMemberLink,
  $years,
  $causeAreaFilterString,
  $donor,
  $generateGraphCmdBase,
  $imagesPath,
  $customHtmlMessage
) {

  $donorString = $donor ? "donor" : "";
  print '<h4 id="' . htmlspecialchars($donorString) . ($donorString ? 'Donation' : 'donation')
    . 'AmountsBy' . urlencode(camelCaseStripSpace($groupName))
    . 'AndYear">' . "Donation amounts by " . htmlspecialchars($groupName) . " and year</h4>";

  if (($data['amount']['Classified']['Total'] ?? 0) > 0) {

    print "<p>If you hover over a cell for a given " . htmlspecialchars($groupName) . " and year, "
      . "you will get a tooltip with the number of donees and the number of "
      . "donations.</p>\n";

    print "<p>For the meaning of “classified” and “unclassified”, see the "
      . '<a href="https://github.com/vipulnaik/donations/blob/master/classified-and-unclassified.md">'
      . "page clarifying this</a>.</p>\n";

    print $customHtmlMessage;

    print '<table id="myTable' . ucfirst($donorString)
      . 'DonationAmountsBy' . ucfirst($groupName) . 'AndYear" '
      . 'class="tablesorter">' . "\n";
    print "<thead>\n";
    print "  <tr>\n";
    print "    <th>" . ucfirst($groupName) . "</th>\n";
    print "    <th>Number of donations</th>\n";
    print "    <th>Number of donees</th>\n";
    print "    <th>Total</th>\n";
    foreach ($years as $y) {
      if (($data['amount']['Classified'][$y] ?? 0) != 0) {
        print "    <th>$y</th>\n";
      }
    }
    print "  </tr>\n";
    print "</thead>\n";

    print "<tbody>\n";
    foreach ($groupMembers as $g) {
      if ($g != 'Total' && $g != 'Classified' && $g != 'Unclassified') {
        print "  <tr>\n";
        if ($groupMemberLink) {
          print "    <td>" . sprintf($groupMemberLink, urlencode($g), $g)
            . "</td>\n";
        } else {
          print "    <td>$g</td>\n";
        }
        print '    <td align="right">'
          . ($data['numDonations'][$g]['Total'] ?? 0) . "</td>\n";
        print '    <td align="right">'
          . ($data['numDonees'][$g]['Total'] ?? 0) . "</td>\n";
        print '    <td align="right"><strong>'
          . number_format($data['amount'][$g]['Total'] ?? 0, 2)
          . "</strong></td>\n";
        foreach ($years as $y) {
          if (($data['amount']['Classified'][$y] ?? 0) != 0) {
            print '    <td align="right"><a title="'
              . sprintf("%d", $data['numDonations'][$g][$y] ?? 0)
              . ' donations to '
              . sprintf("%d", $data['numDonees'][$g][$y] ?? 0)
              . ' distinct donees">'
              . number_format($data['amount'][$g][$y] ?? 0, 2)
              . "</a></td>\n";
          }
        }
        print "  </tr>\n";
      }
    }
    print "</tbody>\n";

    print "<tfoot>\n";
    printFooterRow($data, $years, 'Classified', "Classified total");
    printFooterRow($data, $years, 'Unclassified', "Unclassified total");
    printFooterRow($data, $years, 'Total', "Total");
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

    /* Subtract one to compensate for presence of "Total" entry */
    if (count(array_filter($data['amount']['Classified'])) - 1 > 1) {
      $graphs = yearlyGraphs(
        $years,
        /* Send without 'Total', since yearlyGraphs() constructs the Total on its
         * own. It's only necessary to delete the 'Total' value from $groupMembers
         * since the other arrays are accessed by key, and since the Total key
         * isn't passed, they won't be accessed. */
        array_diff($groupMembers, array('Total')),
        $data['amount']['Total'],
        $data['amount'],
        $generateGraphCmdBase,
        $imagesPath,
        $permalinkUrlBase,
        "#" . $donorString . "DonationAmountsBy" . ucfirst($groupName) . "AndYear"
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
      print "<p>Skipping spending graph as there is at most one year’s worth of donations.</p>\n";
    }
  } else {
    print "<p>Sorry, we couldn't find any $groupName information.</p>\n";
  }
}
?>
