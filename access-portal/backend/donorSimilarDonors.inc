<?php
if (isset($_REQUEST['cause_area_filter'])) {
  $donorSimilarityQuery = <<<'EOD'
      select first_donor, second_donor, first_donor_size, second_donor_size,
          intersect_size, union_size,
          jaccard_index, cosine_similarity, weighted_cosine_similarity
      from cause_area_similarity
      where first_donor = ?
            and cause_area = ?
      order by jaccard_index desc;
EOD;
} else {
  $donorSimilarityQuery = <<<'EOD'
      select first_donor, second_donor, first_donor_size, second_donor_size,
          intersect_size, union_size,
          jaccard_index, cosine_similarity, weighted_cosine_similarity
      from similarity
      where first_donor = ?
      order by jaccard_index desc;
EOD;
}

if ($stmt = $mysqli->prepare($donorSimilarityQuery)) {
  /*
   * The number of occurrences of "s" in the string below, as well as the
   * number of occurrences of $donor, must match the number of occurrences of
   * "?" in the query stored in $donorSimilarityQuery above. */
  if (isset($_REQUEST['cause_area_filter'])) {
    $stmt->bind_param("ss", $donor, $_REQUEST['cause_area_filter']);
  } else {
    $stmt->bind_param("s", $donor);
  }
  $stmt->execute();
  $result = $stmt->get_result();

  print '<h4 id="donorSimilarDonors">Similarity to other donors</h4>' . "\n";
  if ((! $result) || ($result->num_rows <= 0)) {
    printf("<p>Sorry, we couldn't find any similar donors.</p>");
  } else {
    $maxRows = 30;
    $shownRows = min($maxRows, $result->num_rows);
    print '<p>The following table uses the ' .
      '<a href="https://en.wikipedia.org/wiki/Jaccard_index">' .
      'Jaccard index</a> and ' .
      '<a href="https://en.wikipedia.org/wiki/Cosine_similarity">' .
      'cosine similarity</a>' .
      ' to compare the similarity of donors.' .
      " We are showing the top $shownRows donors by the Jaccard index because" .
      " we show up to $maxRows donors and" .
      " show only donors with at least one donee in common." .
      '</p>' . "\n";
    print '<table id="myTableDonorSimilarDonors" class="tablesorter">' . "\n";
    print '<thead>' . "\n";
    print '  <tr>' . "\n";
    print '    <th>Donor</th>' . "\n";
    print '    <th>Number of distinct donees</th>' . "\n";
    print '    <th>Number of donees in common (intersection)</th>' . "\n";
    print '    <th>Union size</th>' . "\n";
    print '    <th>Jaccard similarity</th>' . "\n";
    print '    <th>Cosine similarity</th>' . "\n";
    print '    <th>Weighted cosine similarity</th>' . "\n";
    print '  </tr>' . "\n";
    print '</thead>' . "\n";
    print '<tbody>' . "\n";

    while (($row = $result->fetch_row()) && $maxRows > 0) {
      /* Print if jaccard index is positive */
      if ($row[6] > 0) {
        print '  <tr>' . "\n";
        printf('    <td><a href="/donor.php?donor=%s">%s</a></td>' . "\n",
               urlencode($row[1]), $row[1]);
        printf(
          '    <td align="right">%s</td>' . "\n" .
          '    <td align="right">%s</td>' . "\n" .
          '    <td align="right">%s</td>' . "\n" .
          '    <td align="right">%s</td>' . "\n" .
          '    <td align="right">%s</td>' . "\n" .
          '    <td align="right">%s</td>' . "\n",
          $row[3], $row[4], $row[5], $row[6], $row[7], $row[8]
        );
        print '  </tr>' . "\n";
        $maxRows--;
      }
    }
    $result->close();

    print '</tbody>' . "\n";
    print '</table>' . "\n";
  }
} else {
  /* Enable this for debugging */
  /* print 'failed: ' . $mysqli->error; */
}
?>
