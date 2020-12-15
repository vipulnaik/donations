<?php

if (!isset($causeAreaFilterString)) {
  $causeAreaFilterString = '';
}

$query = "select * from documents where (affected_donees REGEXP ? or publisher = ? or author = ?)". ($causeAreaFilterString ? " and cause_area REGEXP ?" : "") . " order by publication_date desc";
if ($stmt = $mysqli->prepare($query)) {
  $exactMatchDoneeRegex = '(^|\\|)'.$donee.'(\\||$)';
  if ($causeAreaFilterString) {
    $stmt->bind_param("ssss", $exactMatchDoneeRegex, $donee, $donee, $causeAreaFilterString);
  } else {
    $stmt->bind_param("sss", $exactMatchDoneeRegex, $donee, $donee);
  }
  $stmt->execute();
  $doneeDocumentSelectResult = $stmt->get_result();
}

if ($doneeDocumentSelectResult -> num_rows > 0) {
  print '<h4 id="doneeDocumentList">Full list of documents in reverse chronological order ('.($doneeDocumentSelectResult -> num_rows).' documents)</h4>';
  print "\n";
  print '<table id="myTableDoneeDocumentList" class="tablesorter">'."\n";
  print "<thead>\n";
  print '<tr>';
  print '<th>Title (URL linked)</th>';
  print '<th>Publication date</th>';
  print '<th>Author</th>';
  print '<th>Publisher</th>';
  print '<th>Affected donors</th>';
  print '<th>Affected donees</th>';
  print '<th>Document scope</th>';
  print '<th>Cause area</th>';
  print '<th>Notes</th>';
  print '</tr>';
  print "</thead>\n<tbody>\n";
  for($i = 0; $i < $doneeDocumentSelectResult -> num_rows; $i++) {
    $row = $doneeDocumentSelectResult -> fetch_assoc();
    print '<tr>';
    print '<td>'.printSmartLink($row['url'],$row['title']).'</td>';
    print '<td>'.$row['publication_date'].'</td>';
    if ($row['author'] != '') {
      # Change this to check if author is in list
      print '<td>'.explodeDonorPsv($row['author']).'</td>';
    } else {
      print '<td></td>';
    }

    # Link to publisher as donor or donee?
    print '<td>'.$row['publisher'].'</td>';

    print '<td>'.explodeDonorPsv($row['affected_donors']).'</td>';
    print '<td>'.explodeDoneePsv($row['affected_donees']).'</td>';
    print '<td>'.$row['document_scope'].'</td>';
    print '<td>'.$row['cause_area'].'</td>';
    print '<td>'.cleanNotes($row['notes']).'</td>';
    print '</tr>';
  }
  print "</tbody>\n</table>\n";
}
?>
