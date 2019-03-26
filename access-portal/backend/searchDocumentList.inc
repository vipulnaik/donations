<?php
/* This file was initially copied from
 * access-portal/backend/donorDocumentList.inc and modified accordingly. */

print '<h4 id="searchDocumentList">List of documents</h4>';

$limit = 2000;

$query = "select * from documents where notes regexp ? or title regexp ? limit $limit";
if ($stmt = $mysqli->prepare($query)) {
  $stmt->bind_param("ss", $keyword, $keyword);
  $stmt->execute();
  $result = $stmt->get_result();
}
if ($result->num_rows > 0) {
  print "<p>Showing " . $result->num_rows . " documents (limited to $limit documents).</p>\n";
  print '<table id="myTableSearchDocumentList" class="tablesorter">'."\n";
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
  while ($row = $result->fetch_assoc()) {
    print '<tr>';
    print '<td><a href="'.$row['url'].'">'.$row['title'].'</a></td>';
    print '<td>'.$row['publication_date'].'</td>';
    if ($row['author'] != '') {
      # Change this to check if author is in list
      print '<td>'.explodeDonorPsv($row['author']).'</td>';
    } else {
      print '<td></td>';
    }

    # Link to publisher as donor or donor?
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
