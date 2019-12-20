<?php

$donorDocumentSelectQuery = "select * from documents where affected_donors REGEXP ? and affected_donees REGEXP ?"
  . ($causeAreaFilterString ? " and cause_area REGEXP ?" : "")
  . " order by publication_date desc";

if ($stmt = $mysqli->prepare($donorDocumentSelectQuery)) {
  $exactMatchDonorRegex = '(^|\\|)'.$donor.'(\\||$)';
  $exactMatchDoneeRegex = '(^|\\|)'.$donee.'(\\||$)';
  if ($causeAreaFilterString) {
    $stmt->bind_param("sss", $exactMatchDonorRegex, $exactMatchDoneeRegex, $causeAreaFilterString);
  } else {
    $stmt->bind_param("ss", $exactMatchDonorRegex, $exactMatchDoneeRegex);
  }
  $stmt->execute();
}

$donorDocumentSelectResult = $stmt->get_result();
if ($donorDocumentSelectResult -> num_rows > 0) {
  print '<h4 id="donorDoneeDocumentList">Full list of documents in reverse chronological order ('.($donorDocumentSelectResult -> num_rows)." documents)</h4>\n";
  print "\n";
  print '<table id="myTableDonorDocumentList" class="tablesorter">'."\n";
  print "  <thead>\n";
  print "    <tr>\n";
  print "      <th>Title (URL linked)</th>\n";
  print "      <th>Publication date</th>\n";
  print "      <th>Author</th>\n";
  print "      <th>Publisher</th>\n";
  print "      <th>Affected donors</th>\n";
  print "      <th>Affected donees</th>\n";
  print "      <th>Document scope</th>\n";
  print "      <th>Cause area</th>\n";
  print "      <th>Notes</th>\n";
  print "    </tr>\n";
  print "  </thead>\n  <tbody>\n";
  while ($row = $donorDocumentSelectResult->fetch_assoc()) {
    print "    <tr>\n";
    print '      <td>'.printSmartLink($row['url'],$row['title']).'</td>';
    print '      <td>'.$row['publication_date']."</td>\n";
    if ($row['author'] != '') {
      # Change this to check if author is in list
      print '      <td>'.explodeDonorPsv($row['author'])."</td>\n";
    } else {
      print "      <td></td>\n";
    }

    # Link to publisher as donor or donor?
    print '      <td>'.$row['publisher']."</td>\n";

    print '      <td>'.explodeDonorPsv($row['affected_donors'])."</td>\n";
    print '      <td>'.explodeDoneePsv($row['affected_donees'])."</td>\n";
    print '      <td>'.$row['document_scope']."</td>\n";
    print '      <td>'.$row['cause_area']."</td>\n";
    print '      <td>'.cleanNotes($row['notes'])."</td>\n";
    print "    </tr>\n";
  }
  print "  </tbody>\n</table>\n";
}

?>
