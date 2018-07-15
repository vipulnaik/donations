<?php

$query = "select * from money_moved where influencer = ? order by start_date desc";
if ($stmt = $mysqli->prepare($query)) {
  $stmt->bind_param("s", $influencer);
  $stmt->execute();
  $result = $stmt->get_result();
}
$amount_claimed_num_rows = $result->num_rows;
$amount_claimed = array();
while ($row = $result->fetch_assoc()) {
  $amount_claimed[$row['identified_donees']][$row['identified_donors']][$row['start_date']][$row['end_date']]['amount_claimed'] = $row['amount'];
  $amount_claimed[$row['identified_donees']][$row['identified_donors']][$row['start_date']][$row['end_date']]['document_url'] = $row['document_url'];
  $amount_claimed[$row['identified_donees']][$row['identified_donors']][$row['start_date']][$row['end_date']]['document_title'] = $row['document_title'];
  $amount_claimed[$row['identified_donees']][$row['identified_donors']][$row['start_date']][$row['end_date']]['notes'] = $row['notes'];
}

$query = "select donor, donee, sum(amount) as amount_accounted, donation_date from donations where influencer = ? group by donor, donee, donation_date";
if ($stmt = $mysqli->prepare($query)) {
  $stmt->bind_param("s", $influencer);
  $stmt->execute();
  $result = $stmt->get_result();
}
$amounts_accounted = array();
while ($row = $result->fetch_assoc()) {
  // Tracks whether this (donor, donee, donation_date) combination has been
  // sorted into one of the money_moved rows
  $stored = false;

  // First, we try to match against a (donee, donor, date range) combination
  // from money_moved
  foreach ($amount_claimed as $donee => $donees) {
    if ($row['donee'] === $donee) {
      foreach ($donees as $donor => $donors) {
        if ($row['donor'] === $donor) {
          foreach ($donors as $start_date => $start_dates) {
            foreach ($start_dates as $end_date => $end_dates) {
              if ($row['donation_date'] >= $start_date && $row['donation_date'] < $end_date) {
                // We have a match for (donee, donor, date range), so store the
                // amount
                $amount_accounted[$donee][$donor][$start_date][$end_date] = $row['amount_accounted'];
                $stored = true;
              }
            }
          }
        }
      }
    }
  }

  if (!$stored) {
    // We couldn't match against a (donee, donor, date range) from money_moved,
    // so now we try to match against a (donee, date range) from money_moved
    foreach ($amount_claimed as $donee => $donees) {
      if ($row['donee'] === $donee) {
        // This is where the "All donors other than ones specified" amount is
        // stored
        $all_other_donors_bucket = $donees[''];
        foreach ($all_other_donors_bucket as $start_date => $start_dates) {
          foreach ($start_dates as $end_date => $end_dates) {
            if ($row['donation_date'] >= $start_date && $row['donation_date'] < $end_date) {
              // We have a match. We don't want to store under the donor name,
              // but rather under '' because that's where the "all other" donor
              // is stored.
              if (isset($amount_accounted[$donee][''][$start_date][$end_date])) {
                $amount_accounted[$donee][''][$start_date][$end_date] += $row['amount_accounted'];
              } else {
                $amount_accounted[$donee][''][$start_date][$end_date] = $row['amount_accounted'];
              }
              $stored = true;
            }
          }
        }
      }
    }
  }

  if (!$stored) {
    // We couldn't match against either a (donee, donor, date range) or a
    // (donee, date range) combination, so it does in the "everything else" row
    if (isset($amount_accounted[''][''][''][''])) {
      $amount_accounted[''][''][''][''] += $row['amount_accounted'];
    } else {
      $amount_accounted[''][''][''][''] = $row['amount_accounted'];
    }
  }
}

if ($amount_claimed_num_rows > 0) {
  print '<h4 id="influencerMoneyMovedList">Money moved infomation for influencer '.$influencer.' (' . $amount_claimed_num_rows . ' rows)</h4>';
  print '<table id="myTableInfluencerMoneyMovedList" class="tablesorter">'."\n";
  print "<thead>\n";
  print "<tr>\n";
  print "   <th>Identified donees</th>\n";
  print "   <th>Identified donors</th>\n";
  print "   <th>Amount accounted (current USD)</th>\n";
  print "   <th>Amount influence claimed (current USD)</th>\n";
  print "   <th>Start date</th>\n";
  print "   <th>End date</th>\n";
  print "   <th>Document</th>\n";
  print "   <th>Notes</th>\n";
  print "</tr>\n";
  print "</thead>\n";
  print "<tbody>\n";
  foreach ($amount_claimed as $donee => $inner1) {
    foreach ($inner1 as $donor => $inner2) {
      foreach ($inner2 as $start_date => $inner3) {
        foreach ($inner3 as $end_date => $inner4) {
          if ($inner4['amount_claimed'] > 0) {
            print "<tr>\n";
            print "    <td>".$donee."</td>\n";
            if ($donor) {
              print "    <td>".$donor."</td>\n";
            } else {
              print "    <td>All donors other than ones specified</td>\n";
            }
            print '    <td style="text-align: right;">' . number_format($amount_accounted[$donee][$donor][$start_date][$end_date] ?? 0, 2) . '</td>';
            print '    <td style="text-align: right;">'.number_format($inner4['amount_claimed'],2)."</td>\n";
            print "    <td>".$start_date."</td>\n";
            print "    <td>".$end_date."</td>\n";
            print '    <td><a href="'.$inner4['document_url'].'">'.$inner4['document_title'].'</a></td>'."\n";
            print "    <td>".cleanNotes($inner4['notes'])."</td>\n";
            print "</tr>\n";
          }
        }
      }
    }
  }
  if (isset($amount_accounted[''][''][''][''])) {
    print "<tr>\n";
    print "    <td>All other donees than ones specified</td>\n";
    print "    <td>All other donors than ones specified</td>\n";
    print '    <td style="text-align: right;">' . number_format($amount_accounted[''][''][''][''], 2) . "</td>\n";
    print '    <td style="text-align: right;">--</td>' . "\n";
    print "    <td>--</td>\n";
    print "    <td>--</td>\n";
    print "    <td></td>\n";
    print "    <td></td>\n";
    print "</tr>\n";
  }
  print "</tbody>\n";
  print "</table>\n";
}
?>
