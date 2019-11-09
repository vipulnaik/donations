<?php

$query = "select * from donations where donee = ?"
  . ($causeAreaFilterString ? " and cause_area REGEXP ?" : "")
  . " order by donation_date desc";

if ($stmt = $mysqli->prepare($query)) {
  if ($causeAreaFilterString) {
    $stmt->bind_param("ss", $donee, $causeAreaFilterString);
  } else {
    $stmt->bind_param("s", $donee);
  }
  $stmt->execute();
  $doneeDonationSelectResult = $stmt->get_result();
}

print '<h4 id="doneeDonationList">Full list of donations in reverse chronological order ('.($doneeDonationSelectResult -> num_rows).' donations)</h4>';
print "\n";
print '<table id="myTableDoneeDonationList" class="tablesorter">'."\n";
print "<thead>\n";
print '<tr>';
print '<th>Donor</th>';
print '<th>Amount (current USD)</th>';
print '<th>Amount rank (out of '.count($amountList).')</th>';
print '<th>Donation date</th>';
print '<th>Cause area</th>';
print '<th>URL</th>';
print '<th>Influencer</th>';
print '<th>Notes</th>';
print '</tr>';
print "</thead>\n<tbody>\n";
for($i = 0; $i < $doneeDonationSelectResult -> num_rows; $i++) {
  $row = $doneeDonationSelectResult -> fetch_assoc();
  print '<tr>';
  print '<td><a href="/donor.php?donor='.urlencode($row['donor']).'">'.$row['donor'].'</a></td>';
  if ($row['amount'] != '') {
    if ($row['amount_original_currency'] && $row['original_currency']) {
      $originalCurr = ' title="'
        . number_format($row['amount_original_currency'],2)
        . ' ' . $row['original_currency'] . '"';
    } else {
      $originalCurr = "";
    }
    print '<td align="right"' . $originalCurr . '>'.number_format($row['amount'],2).'</td>';
    print '<td align="right">'.(array_search($row['amount'], array_reverse($amountList)) + 1).'</td>';
  } else {
    print '<td>--</td>';
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
    print '<td>'.printSmartLink($row['url'],$row['url']).'</td>';
  } else {
    print '<td>--</td>';
  }
  if ($row['influencer'] != '') {
    print '<td align="right">' . explodeDonorPsv($row['influencer']) . '</td>';
  } else {
    print '<td>--</td>';
  }
  
  include("donationNotes.inc");
  print '</tr>';
}

print "</tbody>\n</table>\n";

?>
