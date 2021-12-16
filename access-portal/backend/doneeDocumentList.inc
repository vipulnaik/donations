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
  $documentSelectResult = $stmt->get_result();
}

if ($documentSelectResult -> num_rows > 0) {
  print '<h4 id="doneeDocumentList">Full list of documents in reverse chronological order ('.($documentSelectResult -> num_rows).' documents)</h4>';
  print "\n";
  print '<table id="myTableDoneeDocumentList" class="tablesorter">'."\n";
  include_once("documentListBase.inc");
  print "</table>\n";
}
?>
