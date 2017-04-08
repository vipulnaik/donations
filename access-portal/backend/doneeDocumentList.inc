<?php

$doneeDocumentSelectQuery = "select * from documents where affected_donees REGEXP '$donee' order by publication_date desc";
$doneeDocumentSelectResult = $mysqli -> query($doneeDocumentSelectQuery);
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
    print '<td><a href="'.$row['url'].'">'.$row['title'].'</a></td>';
    print '<td>'.$row['publication_date'].'</td>';
    if ($row['author'] != '') {
      # Change this to check if author is in list
      print '<td>'.explodeDonorCsv($row['author']).'</td>';
    } else {
      print '<td></td>';
    }

    # Link to publisher as donor or donee?
    print '<td>'.$row['publisher'].'</td>';

    print '<td>'.explodeDonorCsv($row['affected_donors']).'</td>';
    print '<td>'.explodeDoneeCsv($row['affected_donees']).'</td>';
    print '<td>'.$row['document_scope'].'</td>';
    print '<td>'.$row['cause_area'].'</td>';
    print '<td>'.cleanNotes($row['notes']).'</td>';
    print '</tr>';
  }
  print "</tbody>\n</table>\n";
}
?>
