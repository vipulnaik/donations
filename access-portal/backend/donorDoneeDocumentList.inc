<?php

$query = "select * from documents where (affected_donors REGEXP ? or publisher = ? or author = ?) and (affected_donees REGEXP ? or author = ? or publisher = ?)"
  . ($causeAreaFilterString ? " and cause_area REGEXP ?" : "")
  . " order by publication_date desc";

if ($stmt = $mysqli->prepare($query)) {
  $exactMatchDonorRegex = '(^|\\|)'.$donor.'(\\||$)';
  $exactMatchDoneeRegex = '(^|\\|)'.$donee.'(\\||$)';
  if ($causeAreaFilterString) {
    $stmt->bind_param("sssssss", $exactMatchDonorRegex, $donor, $donor, $exactMatchDoneeRegex, $donee, $donee, $causeAreaFilterString);
  } else {
    $stmt->bind_param("ssssss", $exactMatchDonorRegex, $donor, $donor, $exactMatchDoneeRegex, $donee, $donee);
  }
  $stmt->execute();
}

$documentSelectResult = $stmt->get_result();

print '<h4 id="donorDoneeDocumentList">Full list of documents in reverse chronological order ('.($documentSelectResult -> num_rows)." documents)</h4>\n";
print "\n";

if ($documentSelectResult -> num_rows > 0) {
  print '<table id="myTableDonorDocumentList" class="tablesorter">'."\n";
  include_once("documentListBase.inc");
  print "</table>\n";
} else {
  print "<p>There are no documents associated with this combination of donor and donee.</p>";
}

?>
