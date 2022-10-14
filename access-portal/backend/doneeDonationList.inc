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

if ($doneeDonationSelectResult -> num_rows == 0) {
  print "<p>Sorry, we couldn't find any donations!</p>";
} else {
  $timeframePlotUrlBase = "timeframe plot|donee:" . $donee;

  if ($causeAreaFilterString != '') {
    $timeframePlotUrlBase .= '&cause_area_filter='.urlencode($causeAreaFilterString);
  }

  $timeframePlotFileName = hash("md5", $timeframePlotUrlBase) . "-timeframe.png";
  exec($generateTimeframeGraphCmdBase . " --base64 --donee " . trimEncodeEscape($donee) . " --output " . trimEncodeEscape($imagesPath . $timeframePlotFileName));
  print '<p>Graph of top 10 donors (for donations with known year of donation) by amount, showing the timeframe of donations</p>';
  print '<img src="/images/' . $timeframePlotFileName .'" alt="Graph of donations and their timeframes"></img>';

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
}
?>
