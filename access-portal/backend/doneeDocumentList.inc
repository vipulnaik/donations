<?php

$doneeDocumentSelectQuery = "select * from donations where affected_donees REGEXP '$donee' order by publication_date";
$doneeDocumentSelectResult = $mysqli -> query($doneeDocumentSelectQuery);
print '<h4 id="doneeDocumentList">Full list of documents in reverse chronological order ('.($doneeDonationSelectResult -> num_rows).' tasks)</h4>';
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
print '<th>Notes</th>';
print '</tr>';
print "</thead>\n<tbody>\n";
for($i = 0; $i < $doneeDocumentSelectResult -> num_rows; $i++) {
  $row = $doneeDocumentSelectResult -> fetch_assoc();
  print '<tr>';
  print '<td><a href="'.$row['url']).'">'.$row['title'].'</a></td>';
  print '<td>'.$row['publication_date'].'</td>';
  if ($row['author'] != '') {
    # Change this to check if author is in list
    print '<td><a href="/donor.php?donor='.urlencode($row['author']).'">'.$row['author'].'</a></td>';
  } else {
    print '<td></td>';
  }

  # Link to publisher as donor or donee?
  print '<td>'.$row['publisher'].'</td>';


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

function explodeDonorCsv($donorCsv) {

}

function explodeDoneeCsv($doneeCsv) {

}

function cleanNotes($notes) {
  $notesList = explode(" ",$notes);
  $augmentedNotes = "";
  foreach ($notesList as $notesWord) {
    if (substr($notesWord,0,4) == "http") {
      $augmentedNotes = $augmentedNotes . '<a href="'.$notesWord.'">'.$notesWord.'</a> ';
    } else {
      $augmentedNotes = $augmentedNotes . $notesWord . " ";
    }
  }
  return $augmentedNotes;
}
?>
