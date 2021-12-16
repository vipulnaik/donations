<?php
  print "<thead>\n";
  print '<tr>';
  print '<th>Title (URL linked)</th>';
  print '<th>Publication date</th>';
  print '<th>Author</th>';
  print '<th>Publisher</th>';
  print '<th>Affected donors</th>';
  print '<th>Affected donees</th>';
  print '<th>Affected influencers</th>';
  print '<th>Document scope</th>';
  print '<th>Cause area</th>';
  print '<th>Notes</th>';
  print '</tr>';
  print "</thead>\n<tbody>\n";
  for($i = 0; $i < $documentSelectResult -> num_rows; $i++) {
    $row = $documentSelectResult -> fetch_assoc();
    print '<tr>';
    print '<td>'.printSmartLink($row['url'], $row['title']).'</td>';
    print '<td>'.$row['publication_date'].'</td>';
    if ($row['author'] != '') {
      # Change this to check if author is in list
      print '<td>'.explodeDonorPsv($row['author']).'</td>';
    } else {
      print '<td></td>';
    }

    # Link to publisher as donor or donor?
    print '<td>'.$row['publisher'].'</td>';

    print '<td>'.explodeDonorPsv($row['affected_donors'] ?? '').'</td>';
    print '<td>'.explodeDoneePsv($row['affected_donees'] ?? '').'</td>';
    print '<td>'.explodeInfluencerPsv($row['affected_influencers'] ?? '').'</td>';
    print '<td>'.$row['document_scope'].'</td>';
    print '<td>'.$row['cause_area'].'</td>';
    print '<td>'.cleanNotes($row['notes']).'</td>';
    print '</tr>';
  }
  print "</tbody>\n";
?>
