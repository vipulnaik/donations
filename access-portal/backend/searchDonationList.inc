<?php
/* Most of this file was taken from access-portal/backend/donorDonationList.inc
 * and then modified accordingly. */

print '<h4 id="searchDonationList">List of donations</h4>';

$limit = 2000;

$query = "select * from donations where notes regexp ? or donation_process regexp ? or intended_use_of_funds regexp ? or donor_donee_reason regexp ? or donor_amount_reason regexp ? or donor_timing_reason regexp ? or donor_next_donation_thoughts regexp ? or donor_retrospective regexp ? limit $limit";
if ($stmt = $mysqli->prepare($query)) {
  $stmt->bind_param("ssssssss", $keyword, $keyword, $keyword, $keyword, $keyword, $keyword, $keyword, $keyword);
  $stmt->execute();
  $result = $stmt->get_result();
}
if ($result->num_rows > 0) {
  print "<p>Showing " . $result->num_rows . " donations (limited to $limit donations).</p>\n";
  print '<table id="myTableSearchDonationList" class="tablesorter">';
  print "<thead>\n";
  print "<tr>";
  print '<th>Donor</th>';
  print '<th>Donee</th>';
  print '<th>Amount (current USD)</th>';
  print '<th>Donation date</th>';
  print '<th>Cause area</th>';
  print '<th>URL</th>';
  print '<th>Influencer</th>';
  print '<th>Notes</th>';
  print '</tr>';
  print "</thead>\n<tbody>\n";
  while ($row = $result->fetch_assoc()) {
    print '<td><a href="/donor.php?donor='.urlencode($row['donor']).'">'.$row['donor'].'</a>';
    print '<td><a href="/donee.php?donee='.urlencode($row['donee']).'">'.$row['donee'].'</a>';
    if (isset($row['donation_earmark'])) {
      print ' (Earmark: '.$row['donation_earmark'].')';
    }
    if ($row['amount'] != '') {
      if ($row['amount_original_currency'] && $row['original_currency']) {
        $originalCurr = ' title="'
          . number_format($row['amount_original_currency'],2)
          . ' ' . $row['original_currency'] . '"';
      } else {
        $originalCurr = "";
      }
      print '<td align="right"' . $originalCurr . '>'.number_format($row['amount'],2).'</td>';
    } else {
      print '<td>--</td>';
    }
    if ($row['donation_date'] != '') {
      $donation_date = $row['donation_date'];
      $donation_date_precision = $row['donation_date_precision'];
      if ($donation_date_precision == 'month' or $donation_date_precision == 'quarter') {
        $donation_date = substr($donation_date,0,7);
      } else if ($donation_date_precision == 'year' or $donation_date_precision == 'multi-year') {
        $donation_date = substr($donation_date,0,4);
      }
      print '<td align="left"><element title="'.$row['donation_date_precision'].' precision, based on '.$row['donation_date_basis'].'">'.$donation_date.'</element></td>';
    } else {
      print '<td>--</td>';
    }
    if ($row['cause_area'] != '') {
      if ($row['donor_cause_area_url'] != '') {
        print '<td><a href="'.$row['donor_cause_area_url'].'">'.$row['cause_area'].'</a></td>';
      } else {
        print '<td>'.$row['cause_area'].'</td>';
      }
    } else {
      print '<td>--</td>';
    }
    if ($row['url'] != '') {
      print '<td><a href="'.$row['url'].'">'.$row['url'].'</a></td>';
    } else {
      print '<td>--</td>';
    }
    if ($row['influencer'] != '') {
      print '<td align="right">' . explodeDonorPsv($row['influencer']) . '</td>';
    } else {
      print '<td>--</td>';
    }

    /* Build up the JSON-like key-value pairs in the notes column */
    $notes_pre_key_val_pairs = array();
    if ($val = $row['donation_process']) {
      array_push($notes_pre_key_val_pairs, sprintf("<strong>Donation process:</strong> %s", trim(cleanNotes($val))));
    }
    if ($val = $row['intended_use_of_funds_category']) {
      array_push($notes_pre_key_val_pairs, sprintf("<strong>Intended use of funds (category):</strong> %s", $val));
    }
    if ($val = $row['intended_use_of_funds']) {
      array_push($notes_pre_key_val_pairs, sprintf("<strong>Intended use of funds:</strong> %s", trim(cleanNotes($val))));
    }
    if ($val = $row['donor_donee_reason']) {
      array_push($notes_pre_key_val_pairs, sprintf("<strong>Donor reason for selecting the donee:</strong> %s", trim(cleanNotes($val))));
    }
    if ($val = $row['donor_amount_reason']) {
      $amountNotes = trim(cleanNotes($val));
      if ($val2 = $row['fraction']) {
        $amountNotes .= "<br/>" . sprintf("Percentage of total donor spend in the corresponding batch of donations: %.2f", $val2 * 100) . '%';
      }
      array_push($notes_pre_key_val_pairs, sprintf("<strong>Donor reason for donating that amount (rather than a bigger or smaller amount):</strong> %s", $amountNotes));
    }
    if ($val = $row['donor_timing_reason']) {
      $timingNotes = trim(cleanNotes($val));
      if ($val2 = $row['intended_funding_timeframe_in_months']) {
        $timingNotes .= "<br/>" . sprintf("Intended funding timeframe in months: %s", $val2);
      }
      array_push($notes_pre_key_val_pairs, sprintf("<strong>Donor reason for donating at this time (rather than earlier or later):</strong> %s", $timingNotes));
    }
    if ($val = $row['donor_next_donation_thoughts']) {
      array_push($notes_pre_key_val_pairs, sprintf("<strong>Donor thoughts on making further donations to the donee:</strong> %s", trim(cleanNotes($val))));
    }
    if ($val = $row['donor_retrospective']) {
      array_push($notes_pre_key_val_pairs, sprintf("<strong>Donor retrospective of the donation:</strong> %s", trim(cleanNotes($val))));
    }
    $notes_key_val_pairs = array();
    if ($val = $row['intended_funding_timeframe_in_months'] && !($val2 = $row['donor_timing_reason'])) {
      array_push($notes_key_val_pairs, sprintf("intended funding timeframe in months: %s", $val));
    }
    if ($val = $row['affected_regions']) {
      array_push($notes_key_val_pairs, sprintf("affected regions: %s", $val));
    }
    if ($val = $row['affected_countries']) {
      array_push($notes_key_val_pairs, sprintf("affected countries: %s", $val));
    }
    if ($val = $row['affected_states']) {
      array_push($notes_key_val_pairs, sprintf("affected states: %s", $val));
    }
    if ($val = $row['affected_cities']) {
      array_push($notes_key_val_pairs, sprintf("affected cities: %s", $val));
    }
    if (($val = $row['employer_match']) && ($me = $row['matching_employer'])) {
      array_push(
        $notes_key_val_pairs,
        sprintf("Employer match: %s matched %s", $me, number_format($val, 2))
      );
    }
    if ($val = $row['fraction'] && !($val2 = $row['donor_amount_reason'])) {
      array_push($notes_key_val_pairs, sprintf("Percentage of total donor spend in the corresponding batch of donations: %.2f", $val * 100) . '%');
    }
    if ($val = $row['donation_announcement_date']) {
      $precision = $row['donation_announcement_date_precision'];
      if ($precision == 'month') {
        $val = substr($val, 0, 7);
      } else if ($precision == 'year' or $precision == 'multi-year') {
        $val = substr($val, 0, 4);
      }
      if ($url = $row['donation_announcement_url']) {
        array_push(
          $notes_key_val_pairs,
          sprintf('announced: <a href="%s">%s</a>', $url, $val)
        );
      } else {
        array_push($notes_key_val_pairs, "announced: " . $val);
      }
    }

    $notes_pre_key_val_string = trim(implode('<br/><br/>', $notes_pre_key_val_pairs));
    $notes =  trim(cleanNotes($row['notes']));
    $notes_key_val_string = trim(implode('; ', $notes_key_val_pairs));

    /* Add a period to complete the sentence if necessary */
    if ($notes && substr($notes, -1) != '.') {
      $notes .= '. ';
    } else {
      $notes .= ' ';
    }
    if ($notes_key_val_string) {
      $notes_key_val_string = ucfirst($notes_key_val_string) . '. ';
    }
    if ($notes_pre_key_val_string) {
      $notes_pre_key_val_string = $notes_pre_key_val_string . "<br/><br/><strong>Other notes:</strong> ";
    }
    print '    <td>' . $notes_pre_key_val_string . $notes . $notes_key_val_string . '</td>' . "\n";
    print '</tr>';
  }

  print "</tbody>\n</table>\n";
}
