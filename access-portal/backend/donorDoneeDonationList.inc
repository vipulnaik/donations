<?php
$query = "select * from donations where donor = ? and donee = ?"
  . ($causeAreaFilterString ? " and cause_area REGEXP ?" : "")
  . " order by donation_date desc";

if ($stmt = $mysqli->prepare($query)) {
  if ($causeAreaFilterString) {
    $stmt->bind_param("sss", $donor, $donee, $causeAreaFilterString);
  } else {
    $stmt->bind_param("ss", $donor, $donee);
  }
  $stmt->execute();
  $result = $stmt->get_result();
}

print '<h4 id="donorDoneeDonationList">Full list of donations in reverse chronological order ('.($result -> num_rows).' donations)</h4>';

print '<table id="myTableDonorDonationList" class="tablesorter">'."\n";
print "<thead>\n";
print '<tr>';
print '<th>Amount (current USD)</th>';
print '<th>Donation date</th>';
print '<th>Cause area</th>';
print '<th>URL</th>';
print '<th>Influencer</th>';
print '<th>Notes</th>';
print '</tr>';
print "</thead>\n<tbody>\n";

while ($row = $result->fetch_assoc()) {
  print '<tr>';
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
    if ($donation_date_precision == 'month' or donation_date_precision == 'quarter') {
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
    print '<td align="right"><a href="/donor.php?donor='.urlencode($row['influencer']).'">'.$row['influencer'].'</a></td>';
  } else {
    print '<td>--</td>';
  }  

  /* Build up the JSON-like key-value pairs in the notes column */
  $notes_key_val_pairs = array();
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
  print '    <td>' . $notes . $notes_key_val_string . '</td>' . "\n";
  print '</tr>';
}
print "</tbody>\n</table>\n";

?>
