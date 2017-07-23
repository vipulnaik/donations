<?php

$donorDonationSelectQuery = "select * from donations where donor=".'"'.str_replace('"','\"',$donor).'"'." $causeAreaFilterQueryComponent order by donation_date desc";
$donorDonationSelectResult = $mysqli -> query($donorDonationSelectQuery);
print '<h4 id="donorDonationList">Full list of donations in reverse chronological order ('.($donorDonationSelectResult -> num_rows).' donations)</h4>';
print "\n";
print '<table id="myTableDonorDonationList" class="tablesorter">'."\n";
print "<thead>\n";
print '<tr>';
print '<th>Donee</th>';
print '<th>Amount (current USD)</th>';
print '<th>Donation date</th>';
print '<th>Cause area</th>';
print '<th>URL</th>';
print '<th>Influencer</th>';
print '<th>Notes</th>';
print '</tr>';
print "</thead>\n<tbody>\n";
for($i = 0; $i < $donorDonationSelectResult -> num_rows; $i++) {
  $row = $donorDonationSelectResult -> fetch_assoc();
  print '<tr>';
  print '<td><a href="/donee.php?donee='.urlencode($row['donee']).'">'.$row['donee'].'</a></td>';
  if ($row['amount'] != '') {
    print '<td align="right">'.number_format($row['amount'],2).'</td>';
  } else {
    print '<td>--</td>';
  }
  if ($row['donation_date'] != '') {
    $donation_date = $row['donation_date'];
    $donation_date_precision = $row['donation_date_precision'];
    if ($donation_date_precision == 'month') {
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
  if ($val = $row['affected_countries']) {
    array_push($notes_key_val_pairs, sprintf("Affected countries: %s", $val));
  }
  if ($val = $row['affected_regions']) {
    array_push($notes_key_val_pairs, sprintf("Affected regions: %s", $val));
  }
  if ($val = $row['affected_states']) {
    array_push($notes_key_val_pairs, sprintf("Affected states: %s", $val));
  }
  if (($val = $row['employer_match']) && ($me = $row['matching_employer'])) {
    array_push(
      $notes_key_val_pairs,
      sprintf("Employer match: %s matched %s", $me, number_format($val, 2))
    );
  }

  $notes =  trim(cleanNotes($row['notes']));
  $notes_key_val_string = trim(implode('; ', $notes_key_val_pairs));
  if ($notes) {
    $notes .= '. ';
  }
  if ($notes_key_val_string) {
    $notes_key_val_string .= '. ';
  }
  print '    <td>' . $notes . $notes_key_val_string . '</td>' . "\n";
  print '</tr>';
}

print "</tbody>\n</table>\n";

?>
