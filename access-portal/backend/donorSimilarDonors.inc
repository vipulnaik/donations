<?php
$donorSimilarityQuery = <<<'EOD'
-- Modified from https://stackoverflow.com/a/36823694/3422337
select
    similarity.`donor`,
    similarity.`donor_size`,
    similarity.`other_donor_size`,
    similarity.`intersect`,
    similarity.`union`,
    round(sqrt(similarity.donor_size) * sqrt(similarity.other_donor_size), 4)
        as magnitude_product,
    round(similarity.intersect/similarity.union, 4) as jaccard_index,
    round(similarity.intersect / (sqrt(similarity.donor_size) *
        sqrt(similarity.other_donor_size)), 4) as cosine_similarity,
    round(similarity.weighted_magnitude, 4) as weighted_magnitude,
    round(similarity.weighted_magnitude_other, 4) as weighted_magnitude_other,
    round(similarity.weighted_dot_product, 4) as weighted_dot_product,
    round(similarity.weighted_dot_product / (similarity.weighted_magnitude *
        similarity.weighted_magnitude_other), 4) as weighted_cosine_similarity
from (
    select
        other_donors.donor as donor,
        (select count(distinct donee) from donations
            where donor = other_donors.donor
            and donee in (
                select distinct(donee) from donations
                where donor = ?
            )
        ) as `intersect`,
        (select count(distinct donee) from donations
            where donor = ?
            or donor = other_donors.donor
        ) as `union`,
        (select count(distinct donee) from donations
            where donor = ?
        ) as `donor_size`,
        (select count(distinct donee) from donations
            where donor = other_donors.donor
        ) as `other_donor_size`,
        (select sqrt(sum(sqsums.s))
            from (
                select power(sum(amount),2) as s
                from donations
                where donor = ?
                group by donee
            ) as sqsums
        ) as `weighted_magnitude`,
        (select sqrt(sum(sqsums.s))
            from (
                select donor,power(sum(amount),2) as s
                from donations
                group by donee, donor
            ) as sqsums
            where donor = other_donors.donor
        ) as `weighted_magnitude_other`,
        (select sum(sums1.s * sums2.s)
            from (
                select donor as donor1,donee,sum(amount) as s
                from donations
                group by donee, donor
            ) as sums1 left join (
                select donor as donor2,donee,sum(amount) as s
                from donations
                group by donee, donor
            ) as sums2 on sums1.donee = sums2.donee
            where donor1 = ? and donor2 = other_donors.donor
        ) as `weighted_dot_product`
    from (
        select distinct(donor) from donations
        where donor != ?
    ) as other_donors
) as similarity
having jaccard_index > 0
order by jaccard_index desc;
EOD;

if ($stmt = $mysqli->prepare($donorSimilarityQuery)) {
  $stmt->bind_param("ssssss", $donor, $donor, $donor, $donor, $donor, $donor);
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
    print '    <th>Cosine similarity</th>' . "\n";
    print '    <th>Weighted magnitude</th>' . "\n";
    print '    <th>Weighted magnitude other</th>' . "\n";
    print '    <th>Weighted dot product</th>' . "\n";
    print '    <th>Weighted cosine similarity</th>' . "\n";
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
      $weighted_magnitude = $row[8];
      $weighted_magnitude_other = $row[9];
      $weighted_dot_product = $row[10];
      $weighted_cosine_similarity = $row[11];

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
          '    <td align="right">%s</td>' . "\n" .
          '    <td align="right">%s</td>' . "\n" .
          '    <td align="right">%s</td>' . "\n" .
          '    <td align="right">%s</td>' . "\n" .
          '    <td align="right">%s</td>' . "\n",
          $donor_size, $other_donor_size, $intersect, $union,
          $magnitude_product, $jaccard_index, $cosine_similarity,
          $weighted_magnitude, $weighted_magnitude_other,
          $weighted_dot_product, $weighted_cosine_similarity
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
