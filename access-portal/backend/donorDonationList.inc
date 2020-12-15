<?php

$query = "select * from donations where donor = ?"
  . ($causeAreaFilterString ? " and cause_area REGEXP ?" : "")
  . " order by donation_date desc";

if ($stmt = $mysqli->prepare($query)) {
  if ($causeAreaFilterString) {
    $stmt->bind_param("ss", $donor, $causeAreaFilterString);
  } else {
    $stmt->bind_param("s", $donor);
  }
  $stmt->execute();
  $donorDonationSelectResult = $stmt->get_result();
}

print '<h4 id="donorDonationList">Full list of donations in reverse chronological order ('.($donorDonationSelectResult -> num_rows).' donations)</h4>';

$timeframePlotFileName = hash("md5", "timeframe plot|donor:" . $donor) . "-timeframe.png";
exec($generateTimeframeGraphCmdBase . "--base64 --donor " . trimEncodeEscape($donor) . (($causeAreaFilterString ?? '') ? " --cause_area " . trimEncodeEscape($causeAreaFilterString) : "") . " --output " . trimEncodeEscape($imagesPath . $timeframePlotFileName));
print '<p>Graph of top 10 donees by amount, showing the timeframe of donations</p>';
print '<img src="/images/' . $timeframePlotFileName .'" alt="Graph of donations and their timeframes"></img>';

print "\n";
print '<table id="myTableDonorDonationList" class="tablesorter">'."\n";
print "<thead>\n";
print '<tr>';
print '<th>Donee</th>';
print '<th>Amount (current USD)</th>';
print '<th>Amount rank (out of '. count($amountList) .')</th>';
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
  print '<td><a href="/donee.php?donee='.urlencode($row['donee']).'">'.$row['donee'].'</a>';
  if (isset($row['donation_earmark'])) {
    print ' (Earmark: '.$row['donation_earmark'].')';
  }
  if ($row['amount'] != '') {
    printAmountWithRank($row['amount'], $amountList, $row['amount_original_currency'], $row['original_currency']);
  } else {
    print '<td>--</td>';
    print '<td>--</td>';
  }
  if ($row['donation_date'] != '') {
    printDonationDate($row['donation_date'],$row['donation_date_precision'],$row['donation_date_basis']);
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
