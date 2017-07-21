<?php
$donorSimilarityQuery = <<<'EOD'
select
    jaccard.donor,
    jaccard.intersect,
    jaccard.union,
    jaccard.intersect/jaccard.union as jaccard_index
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
        ) as 'union'
    from (
        select distinct(donor) from donations
        where donor != ?
    ) as other_donors
) as jaccard
having jaccard_index > 0
order by jaccard_index desc;
EOD;

/* print "$donorSimilarityQuery"; */

if ($stmt = $mysqli->prepare($donorSimilarityQuery)) {
  $stmt->bind_param("sss", $donor, $donor, $donor);
  $stmt->execute();
  $result = $stmt->get_result();

  print '<h4 id="donorSimilarDonors">Similarity to other donors</h4>' . "\n";
  if ((! $result) || ($result->num_rows <= 0)) {
    printf("<p>Sorry, we couldn't find any similar donors.</p>");
  } else {
    printf("%s", $result->num_rows);
    print '<p>The following table uses the ' .
      '<a href="https://en.wikipedia.org/wiki/Jaccard_index">' .
      'Jaccard index</a> to compare the similarity of donors.</p>' . "\n";
    print '<table id="myTableDonorSimilarDonors" class="tablesorter">' . "\n";
    print '<thead>' . "\n";
    print '  <tr>' . "\n";
    print '    <th>Donor</th>' . "\n";
    print '    <th>Number of donees in common (intersect)</th>' . "\n";
    print '    <th>Union size</th>' . "\n";
    print '    <th>Jaccard similarity</th>';
    print '  </tr>' . "\n";
    print '</thead>' . "\n";
    print '<tbody>' . "\n";

    $maxRows = 30;
    /* $stmt->bind_result($other_donor, $intersect, $union, $jaccard_index); */
    while (($row = $result->fetch_row()) && $maxRows > 0) {
      $other_donor = $row[0];
      $intersect = $row[1];
      $union = $row[2];
      $jaccard_index = $row[3];

      if ($jaccard_index > 0) {
        print '  <tr>' . "\n";
        printf('    <td><a href="/donor.php?donor=%s">%s</a></td>' . "\n",
               urlencode($other_donor), $other_donor);
        printf("    <td>%s</td>\n" .
               "    <td>%s</td>\n    <td>%s</td>\n",
               $intersect, $union, $jaccard_index);
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
