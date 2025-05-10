<?php
include_once("access-portal/backend/globalVariables/passwordFile.inc");

/* Get list of donors */
$temp = $mysqli -> query("select distinct donor from donations");
$donors = array();
for ($i = 0; $i < $temp -> num_rows; $i++) {
  $row = $temp -> fetch_assoc();
  array_push($donors, $row['donor']);
}

/* We will be running the following query for each donor */
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

foreach ($donors as $donor) {
  if ($stmt = $mysqli->prepare($donorSimilarityQuery)) {
    /*
     * The number of occurrences of "s" in the string below, as well as the
     * number of occurrences of $donor, must match the number of occurrences of
     * "?" in the query stored in $donorSimilarityQuery above. */
    $stmt->bind_param("ssssss", $donor, $donor, $donor, $donor, $donor, $donor);
    $stmt->execute();
    $result = $stmt->get_result();

    print "Doing " . htmlspecialchars($donor) . "\n";
    if ((! $result) || ($result->num_rows <= 0)) {
      printf("<p>Sorry, we couldn't find any similar donors.</p>");
    } else {
      $maxRows = 30;
      $shownRows = min($maxRows, $result->num_rows);

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
          $sql = "insert into similarity (first_donor, second_donor,"
            . "first_donor_distinct_donees, second_donor_distinct_donees,"
            . "intersection_size, union_size, jaccard_index, cosine_similarity,"
            . "weighted_cosine_similarity) values (?, ?, ?, ?, ?, ?, ?, ?, ?)";
          if ($stmt_insert = $mysqli->prepare($sql)) {
            $stmt_insert->bind_param("ssiiiiddd", $donor, $other_donor,
              $donor_size, $other_donor_size, $intersect, $union,
              $jaccard_index, $cosine_similarity, $weighted_cosine_similarity);
            $stmt_insert->execute();
          }

          $maxRows--;
        }
      }
      $result->close();
    }
  }
}

$mysqli->close();
?>
