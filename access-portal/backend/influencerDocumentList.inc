<?php

if (!isset($causeAreaFilterString)) {
  $causeAreaFilterString = '';
}

$query = "select * from documents where (affected_influencers REGEXP ? or publisher = ? or author = ?)". ($causeAreaFilterString ? " and cause_area REGEXP ?" : "") . " order by publication_date desc";
if ($stmt = $mysqli->prepare($query)) {
  $exactMatchInfluencerRegex = '(^|\\|)'.$influencer.'(\\||$)';
  if ($causeAreaFilterString) {
    $stmt->bind_param("ssss", $exactMatchInfluencerRegex, $influencer, $influencer, $causeAreaFilterString);
  } else {
    $stmt->bind_param("sss", $exactMatcgInfluencerRegex, $influencer, $influencer);
  }
  $stmt->execute();
  $documentSelectResult = $stmt->get_result();
}

print '<h4 id="influencerDocumentList">Full list of documents in reverse chronological order ('.($documentSelectResult -> num_rows).' documents)</h4>';
print "\n";

if ($documentSelectResult -> num_rows > 0) {
  print '<table id="myTableInfluencerDocumentList" class="tablesorter">'."\n";
  include_once("documentListBase.inc");
  print "</table>\n";
} else {
  print "<p>There are no documents associated with this influencer.</p>";
}

?>
