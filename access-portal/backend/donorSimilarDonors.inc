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
order by jaccard_index desc;
EOD;

/* print "$donorSimilarityQuery"; */

if ($stmt = $mysqli->prepare($donorSimilarityQuery)) {
  $stmt->bind_param("sss", $donor, $donor, $donor);
  $stmt->execute();
  $stmt->bind_result($other_donor, $intersect, $union, $jaccard_index);
  print '<h4>Similarity to other donors</h4>' . "\n";
  print '<table class="tablesorter">' . "\n";
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
  while (mysqli_stmt_fetch($stmt) && $maxRows > 0) {
    if ($jaccard_index > 0) {
      print '  <tr>' . "\n";
      printf("    <td>%s</td>\n    <td>%s</td>\n" .
             "    <td>%s</td>\n    <td>%s</td>\n", $other_donor,
             $intersect, $union, $jaccard_index);
      print '  </tr>' . "\n";
      $maxRows--;
    }
  }

  print '</tbody>' . "\n";
  print '</table>' . "\n";
}
?>
