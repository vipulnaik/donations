<?php
$donorSimilarityQuery = <<<'EOD'
select
    similarity.donor,
    similarity.donor_size,
    similarity.other_donor_size,
    similarity.intersect,
    similarity.union,
    round(sqrt(similarity.donor_size) * sqrt(similarity.other_donor_size), 4)
        as magnitude_product,
    round(similarity.intersect/similarity.union, 4) as jaccard_index,
    round(similarity.intersect / (sqrt(similarity.donor_size) *
        sqrt(similarity.other_donor_size)), 4) as cosine_similarity
from (
    select
        other_donors.donor as donor,
        (select count(distinct donee) from donations
            where donor = other_donors.donor
            and donee in (
                select distinct(donee) from donations
                where donor = ?
            )
        ) as 'intersect',
        (select count(distinct donee) from donations
            where donor = ?
            or donor = other_donors.donor
        ) as 'union',
        (select count(distinct donee) from donations
            where donor = ?
        ) as 'donor_size',
        (select count(distinct donee) from donations
            where donor = other_donors.donor
        ) as 'other_donor_size'
    from (
        select distinct(donor) from donations
        where donor != ?
    ) as other_donors
) as similarity
having jaccard_index > 0
order by jaccard_index desc;
EOD;

if ($stmt = $mysqli->prepare($donorSimilarityQuery)) {
  $stmt->bind_param("ssss", $donor, $donor, $donor, $donor);
  $stmt->execute();
  $result = $stmt->get_result();

  print '<h4 id="donorSimilarDonors">Similarity to other donors</h4>' . "\n";
  if ((! $result) || ($result->num_rows <= 0)) {
    printf("<p>Sorry, we couldn't find any similar donors.</p>");
  } else {
    print '<p>The following table uses the ' .
      '<a href="https://en.wikipedia.org/wiki/Jaccard_index">' .
      'Jaccard index</a> and ' .
      '<a href="https://en.wikipedia.org/wiki/Cosine_similarity">' .
      'cosine similarity</a>' .
      ' to compare the similarity of donors.</p>' . "\n";
    print '<table id="myTableDonorSimilarDonors" class="tablesorter">' . "\n";
    print '<thead>' . "\n";
    print '  <tr>' . "\n";
    print '    <th>Donor</th>' . "\n";
    print '    <th>Donor size</th>' . "\n";
    print '    <th>Other donor size</th>' . "\n";
    print '    <th>Number of donees in common (intersect)</th>' . "\n";
    print '    <th>Union size</th>' . "\n";
    print '    <th>Magnitude product</th>' . "\n";
    print '    <th>Jaccard similarity</th>' . "\n";
    print '    <th>Cosine similarity</th>';
    print '  </tr>' . "\n";
    print '</thead>' . "\n";
    print '<tbody>' . "\n";

    $maxRows = 30;
    while (($row = $result->fetch_row()) && $maxRows > 0) {
      $other_donor = $row[0];
      $donor_size = $row[1];
      $other_donor_size = $row[2];
      $intersect = $row[3];
      $union = $row[4];
      $magnitude_product = $row[5];
      $jaccard_index = $row[6];
      $cosine_similarity = $row[7];

      if ($jaccard_index > 0) {
        print '  <tr>' . "\n";
        printf('    <td><a href="/donor.php?donor=%s">%s</a></td>' . "\n",
               urlencode($other_donor), $other_donor);
        printf(
          '    <td align="right">%s</td>' . "\n" .
          '    <td align="right">%s</td>' . "\n" .
          '    <td align="right">%s</td>' . "\n" .
          '    <td align="right">%s</td>' . "\n" .
          '    <td align="right">%s</td>' . "\n" .
          '    <td align="right">%s</td>' . "\n" .
          '    <td align="right">%s</td>' . "\n",
          $donor_size, $other_donor_size, $intersect, $union,
          $magnitude_product, $jaccard_index, $cosine_similarity
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
