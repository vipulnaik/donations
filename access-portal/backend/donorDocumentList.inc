<?php

$query = "select * from documents where (affected_donors REGEXP ? or publisher = ? or author = ?)". ($causeAreaFilterString ? " and cause_area REGEXP ?" : "") . " order by publication_date desc";
if ($stmt = $mysqli->prepare($query)) {
  $exactMatchDonorRegex = '(^|\\|)'.$donor.'(\\||$)';
  if ($causeAreaFilterString) {
    $stmt->bind_param("ssss", $exactMatchDonorRegex, $donor, $donor, $causeAreaFilterString);
  } else {
    $stmt->bind_param("sss", $exactMatchDonorRegex, $donor, $donor);
  }
  $stmt->execute();
  $documentSelectResult = $stmt->get_result();
}

if ($documentSelectResult -> num_rows > 0) {
  print '<h4 id="donorDocumentList">Full list of documents in reverse chronological order ('.($documentSelectResult -> num_rows).' documents)</h4>';
  print "\n";
  print '<table id="myTableDonorDocumentList" class="tablesorter">'."\n"; 
  include_once("documentListBase.inc");
  print "</table>\n";
}

?>
