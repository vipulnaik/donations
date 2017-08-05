<?php
$donorSimilarityQuery = <<<'EOD'
select first_donor, second_donor, first_donor_size, second_donor_size,
    intersect_size, union_size,
    jaccard_index, cosine_similarity, weighted_cosine_similarity
from similarity
where first_donor = ? or second_donor = ?
order by jaccard_index desc;
EOD;

if ($stmt = $mysqli->prepare($donorSimilarityQuery)) {
  /*
   * The number of occurrences of "s" in the string below, as well as the
   * number of occurrences of $donor, must match the number of occurrences of
   * "?" in the query stored in $donorSimilarityQuery above. */
  $stmt->bind_param("ssssss", $donor, $donor, $donor, $donor, $donor, $donor);
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
      if ($row[0] == $donor) {
        $other = $row[1];
        $other_size = $row[3];
      } else{
        $other = $row[0];
        $other_size = $row[2];
      }

      if ($jaccard_index > 0) {
        print '  <tr>' . "\n";
        printf('    <td><a href="/donor.php?donor=%s">%s</a></td>' . "\n",
               urlencode($row[0]), $row[0]);
        printf(
          '    <td align="right">%s</td>' . "\n" .
          '    <td align="right">%s</td>' . "\n" .
          '    <td align="right">%s</td>' . "\n" .
          '    <td align="right">%s</td>' . "\n" .
          '    <td align="right">%s</td>' . "\n" .
          '    <td align="right">%s</td>' . "\n",
          $row[
        );
        print '  </tr>' . "\n";
        $maxRows--;
      }
    }
    $result->close();

    print '</tbody>' . "\n";
    print '</table>' . "\n";
  }
}
?>
