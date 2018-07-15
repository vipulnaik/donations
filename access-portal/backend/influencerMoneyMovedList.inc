<?php

// The "amount claimed" is the amount of influence claimed according to the
// money_moved table. Below we store this information in the multidimensional
// array $amountClaimed, which is accessed in the order (donee, donor, start
// date, end date) and has the values "amount_claimed", "document_url",
// "document_title" and "notes".
$query = "select * from money_moved where influencer = ? order by start_date desc";
if ($stmt = $mysqli->prepare($query)) {
  $stmt->bind_param("s", $influencer);
  $stmt->execute();
  $result = $stmt->get_result();
}
$amountClaimedNumRows = $result->num_rows;
$amountClaimed = array();
while ($row = $result->fetch_assoc()) {
  $amountClaimed[$row['identified_donees']][$row['identified_donors']][$row['start_date']][$row['end_date']]['amount_claimed'] = $row['amount'];
  $amountClaimed[$row['identified_donees']][$row['identified_donors']][$row['start_date']][$row['end_date']]['document_url'] = $row['document_url'];
  $amountClaimed[$row['identified_donees']][$row['identified_donors']][$row['start_date']][$row['end_date']]['document_title'] = $row['document_title'];
  $amountClaimed[$row['identified_donees']][$row['identified_donors']][$row['start_date']][$row['end_date']]['notes'] = $row['notes'];
}

// The "amount accounted" is the amount of influence accounted for via the
// donations table. Below we store this information in $amountAccounted in a
// format similar to $amountClaimed. The tricky part is that the donations
// table does not store donations in the same format as the money_moved table,
// so we have to do some grouping.
$query = "select donor, donee, sum(amount) as amount_accounted, donation_date from donations where influencer = ? group by donor, donee, donation_date";
if ($stmt = $mysqli->prepare($query)) {
  $stmt->bind_param("s", $influencer);
  $stmt->execute();
  $result = $stmt->get_result();
}
$amountAccounted = array();
while ($row = $result->fetch_assoc()) {
  // Tracks whether this (donor, donee, donation_date) combination has been
  // sorted into one of the money_moved rows
  $stored = false;

  // First, we try to match against a (donee, donor, date range) combination
  // from money_moved
  foreach ($amountClaimed as $donee => $donees) {
    if ($row['donee'] === $donee) {
      foreach ($donees as $donor => $donors) {
        if ($row['donor'] === $donor) {
          foreach ($donors as $startDate => $startDates) {
            foreach ($startDates as $endDate => $endDates) {
              if ($row['donation_date'] >= $startDate && $row['donation_date'] < $endDate) {
                // We have a match for (donee, donor, date range), so store the
                // amount
                $amountAccounted[$donee][$donor][$startDate][$endDate] = $row['amount_accounted'];
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
    foreach ($amountClaimed as $donee => $donees) {
      if ($row['donee'] === $donee) {
        // This is where the "All donors other than ones specified" amount is
        // stored
        $allOtherDonorsBucket = $donees[''];
        foreach ($allOtherDonorsBucket as $startDate => $startDates) {
          foreach ($startDates as $endDate => $endDates) {
            if ($row['donation_date'] >= $startDate && $row['donation_date'] < $endDate) {
              // We have a match. We don't want to store under the donor name,
              // but rather under '' because that's where the "all other" donor
              // is stored.
              if (isset($amountAccounted[$donee][''][$startDate][$endDate])) {
                $amountAccounted[$donee][''][$startDate][$endDate] += $row['amount_accounted'];
              } else {
                $amountAccounted[$donee][''][$startDate][$endDate] = $row['amount_accounted'];
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
    if (isset($amountAccounted[''][''][''][''])) {
      $amountAccounted[''][''][''][''] += $row['amount_accounted'];
    } else {
      $amountAccounted[''][''][''][''] = $row['amount_accounted'];
    }
  }
}

if ($amountClaimedNumRows > 0) {
  print '<h4 id="influencerMoneyMovedList">Money moved infomation for influencer '.$influencer.' (' . $amountClaimedNumRows . ' rows)</h4>';
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
  foreach ($amountClaimed as $donee => $inner1) {
    foreach ($inner1 as $donor => $inner2) {
      foreach ($inner2 as $startDate => $inner3) {
        foreach ($inner3 as $endDate => $inner4) {
          if ($inner4['amount_claimed'] > 0) {
            print "<tr>\n";
            print "    <td>".$donee."</td>\n";
            if ($donor) {
              print "    <td>".$donor."</td>\n";
            } else {
              print "    <td>All donors other than ones specified</td>\n";
            }
            print '    <td style="text-align: right;">' . number_format($amountAccounted[$donee][$donor][$startDate][$endDate] ?? 0, 2) . '</td>';
            print '    <td style="text-align: right;">'.number_format($inner4['amount_claimed'],2)."</td>\n";
            print "    <td>".$startDate."</td>\n";
            print "    <td>".$endDate."</td>\n";
            print '    <td><a href="'.$inner4['document_url'].'">'.$inner4['document_title'].'</a></td>'."\n";
            print "    <td>".cleanNotes($inner4['notes'])."</td>\n";
            print "</tr>\n";
          }
        }
      }
    }
  }
  if (isset($amountAccounted[''][''][''][''])) {
    print "<tr>\n";
    print "    <td>All other donees than ones specified</td>\n";
    print "    <td>All other donors than ones specified</td>\n";
    print '    <td style="text-align: right;">' . number_format($amountAccounted[''][''][''][''], 2) . "</td>\n";
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
