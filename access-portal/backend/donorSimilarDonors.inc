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

print "$donorSimilarityQuery";

if ($stmt = $mysqli->prepare($donorSimilarityQuery)) {
  $stmt->bind_param("sss", $donor, $donor, $donor);
  $stmt->execute();
  $stmt->bind_result($other_donor, $intersect, $union, $jaccard_index);
  print "JACCARD INDEX GOES HERE:\n";
  while (mysqli_stmt_fetch($stmt)) {
    printf("%s %s<br/>\n", $other_donor, $jaccard_index);
  }
  print "JACCARD INDEX IS ABOVE HERE\n";
}
?>
