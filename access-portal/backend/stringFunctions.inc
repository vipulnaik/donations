<?php

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

function explodeDonorCsv($donorCsv) {
  return explodeDonorCharSepValues($donorCsv, ",");
}

function explodeDoneeCsv($doneeCsv) {
  return explodeDoneeCharSepValues($doneeCsv, ",");
}

function explodeDonorCharSepValues($donorCsv, string $char) {
  $donorsList = explode($char,$donorCsv);
  $formattedString = '';
  foreach ($donorsList as $donor) {
    $formattedString = $formattedString . '<a href="/donor.php?donor='.urlencode($donor).'">'.$donor.'</a> ';
  }
  return $formattedString;
}

function explodeDoneeCharSepValues($doneeCsv, string $char) {
  $doneesList = explode($char,$doneeCsv);
  $formattedString = '';
  foreach ($doneesList as $donee) {
    $formattedString = $formattedString . '<a href="/donee.php?donee='.urlencode($donee).'">'.$donee.'</a> ';
  }
  return $formattedString;
}

?>
