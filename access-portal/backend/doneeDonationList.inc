<?php

$doneeDonationSelectQuery = "select * from donations where donee='$donee' order by donation_date desc";
$doneeDonationSelectResult = $mysqli -> query($doneeDonationSelectQuery);
print '<h4 id="doneeDonationList">Full list of donations in reverse chronological order ('.($doneeDonationSelectResult -> num_rows).' donations)</h4>';
print "\n";
print '<table id="myTableDoneeDonationList" class="tablesorter">'."\n";
print "<thead>\n";
print '<tr>';
print '<th>Donor</th>';
print '<th>Amount (current USD)</th>';
print '<th>Donation date</th>';
print '<th>Cause area</th>';
print '<th>URL</th>';
print '<th>Employer match</th>';
print '<th>Notes</th>';
print '</tr>';
print "</thead>\n<tbody>\n";
for($i = 0; $i < $doneeDonationSelectResult -> num_rows; $i++) {
  $row = $doneeDonationSelectResult -> fetch_assoc();
  print '<tr>';
  print '<td><a href="/donor.php?donor='.urlencode($row['donor']).'">'.$row['donor'].'</a></td>';
  if ($row['amount'] != '') {
    print '<td align="right">'.sprintf("%.2f",$row['amount']).'</td>';
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
  if ($row['employer_match'] != '') {
    if ($row['matching_employer'] != '') {
      print '<td align="right"><element title="Matched by '.$row['matching_employer'].'">'.sprintf("%.2f",$row['employer_match']).'</element></td>';
    }
  } else {
    print '<td>--</td>';
  }
  print '<td>'.cleanNotes($row['notes']).'</td>';
  print '</tr>';
}

print "</tbody>\n</table>\n";

?>
