<?php

$influencerDocumentSelectQuery = "select * from documents where author REGEXP ".'"'.str_replace('"','\"',$influencer).'"'." or affected_donors REGEXP ".'"'.str_replace('"','\"',$influencer).'"'." order by publication_date desc";
$influencerDocumentSelectResult = $mysqli -> query($influencerDocumentSelectQuery);
if ($influencerDocumentSelectResult -> num_rows > 0) {
  print '<h4 id="influencerDocumentList">Full list of documents in reverse chronological order ('.($influencerDocumentSelectResult -> num_rows).' documents)</h4>';
  print "\n";
  print '<table id="myTableInfluencerDocumentList" class="tablesorter">'."\n"; 
  print "<thead>\n";
  print '<tr>';
  print '<th>Title (URL linked)</th>';
  print '<th>Publication date</th>';
  print '<th>Author</th>';
  print '<th>Publisher</th>';
  print '<th>Affected donors</th>';
  print '<th>Affected donees</th>';
  print '<th>Document scope</th>';
  print '<th>Notes</th>';
  print '</tr>';
  print "</thead>\n<tbody>\n";
  for($i = 0; $i < $influencerDocumentSelectResult -> num_rows; $i++) {
    $row = $influencerDocumentSelectResult -> fetch_assoc();
    print '<tr>';
    print '<td><a href="'.$row['url'].'">'.$row['title'].'</a></td>';
    print '<td>'.$row['publication_date'].'</td>';
    if ($row['author'] != '') {
      # Change this to check if author is in list
      print '<td>'.explodeDonorCsv($row['author']).'</td>';
    } else {
      print '<td></td>';
    }

    # Link to publisher as donor or donor?
    print '<td>'.$row['publisher'].'</td>';

    print '<td>'.explodeDonorCsv($row['affected_donors']).'</td>';
    print '<td>'.explodeDoneeCsv($row['affected_donees']).'</td>';
    print '<td>'.$row['document_scope'].'</td>';
    print '<td>'.cleanNotes($row['notes']).'</td>';
    print '</tr>';
  }
  print "</tbody>\n</table>\n";
}

?>
