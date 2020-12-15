<?php

function printSmartLink($url, $title) {
  $stringToPrint = '<a href="'.$url.'">'.$title.'</a>';
  if (strlen($url) >= 32 and substr($url,0,31) == "https://www.lesswrong.com/posts") {
    $greaterWrongUrl = str_replace("https://www.lesswrong.com", "https://www.greaterwrong.com", $url);
    $readerUrl = str_replace("https://www.lesswrong.com", "https://lw2.issarice.com", $url);
    $stringToPrint .= ' (<a href="'.$greaterWrongUrl.'">GW</a>, <a href="'.$readerUrl.'">IR</a>)';
  } else if (strlen($url) >= 42 and substr($url,0,41) == "https://forum.effectivealtruism.org/posts") {
    $greaterWrongUrl = str_replace("https://forum.effectivealtruism.org", "https://ea.greaterwrong.com", $url);
    $readerUrl = str_replace("https://forum.effectivealtruism.org", "https://eaforum.issarice.com", $url);
    $stringToPrint .= ' (<a href="'.$greaterWrongUrl.'">GW</a>, <a href="'.$readerUrl.'">IR</a>)';
  }
  return $stringToPrint;
}

function printDonationDate($donationDate, $donationDatePrecision, $donationDateBasis) {
  if ($donationDatePrecision == 'month' or $donationDatePrecision == 'quarter') {
    $donationDate = substr($donationDate,0,7);
  } else if ($donationDatePrecision == 'year' or $donationDatePrecision == 'multi-year') {
    $donationDate = substr($donationDate,0,4);
  }
  print '<td align="left"><element title="'.$donationDatePrecision.' precision, based on '.$donationDateBasis.'">'.$donationDate.'</element></td>';
}

function printAmountWithRank($amount, $amountList, $amountOriginalCurrency, $originalCurrency) {
  if ($amountOriginalCurrency && $originalCurrency) {
      $originalCurrStr = ' title="'
        . number_format($row['amount_original_currency'],2)
        . ' ' . $originalCurrency . '"';
    } else {
      $originalCurrStr = "";
    }
    print '<td align="right"' . $originalCurrStr . '>'.number_format($amount,2).'</td>';
    print '<td align="right">'.(array_search($amount, array_reverse($amountList)) + 1).'</td>';
}

function cleanNotes($notes) {
  $notesList = explode(" ",$notes);
  $augmentedNotes = "";
  foreach ($notesList as $notesWord) {
    if (substr($notesWord,0,4) == "http") {
      $augmentedNotes = $augmentedNotes . printSmartLink($notesWord, $notesWord). " ";
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

// For passing arguments containing user input to a python script.
function trimEncodeEscape(string $x, int $limit = 300) {
  return escapeshellarg(base64_encode(substr($x, 0, $limit)));
}

?>
