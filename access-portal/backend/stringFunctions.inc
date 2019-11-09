<?php

function printSmartLink($url, $title) {
  $stringToPrint = '<a href="'.$url.'">'.$title.'</a>';
  if (strlen($url) >= 32 and substr($url,0,31) == "https://www.lesswrong.com/posts") {
    $greaterWrongUrl = str_replace("https://www.lesswrong.com", "https://www.greaterwrong.com", $url);
    $readerUrl = str_replace("https://www.lesswrong.com", "https://lw2.issarice.com", $url);
    $stringToPrint .= ' (<a href="'.$greaterWrongUrl.'">GW</a>, <a href="'.$readerUrl.'">IR</a>)';
  } else if (strlen($url) >= 42 and substr($url,0,41) == "https://forum.effectivealtruism.org/posts") {
    $greaterWrongUrl = str_replace("https://forum.effectivealtruism.org", "https://ea.greaterwrong.com", $url);
    $readerUrl = str_replace("https://forum.effectivealtrruism.org", "https://eaforum.issarice.com", $url);
    $stringToPrint .= ' (<a href="'.$greaterWrongUrl.'">GW</a>, <a href="'.$readerUrl.'">IR</a>)';
  }
  return $stringToPrint;
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

function explodeDonorCsv($donorCsv) {
  return explodeDonorCharSepValues($donorCsv, ",");
}

function explodeDoneeCsv($doneeCsv) {
  return explodeDoneeCharSepValues($doneeCsv, ",");
}

function explodeDonorPsv($donorPsv) {
  return explodeDonorCharSepValues($donorPsv, "|");
}

function explodeDoneePsv($doneePsv) {
  return explodeDoneeCharSepValues($doneePsv, "|");
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
