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
    similarity.weighted_magnitude,
    similarity.weighted_magnitude_other
from (
    select
        other_donors.donor as donor,
        (select count(distinct donee) from donations
            where donor = other_donors.donor
            and donee in (
                select distinct(donee) from donations
                where donor = 'Open Philanthropy Project'
            )
        ) as `intersect`,
        (select count(distinct donee) from donations
            where donor = 'Open Philanthropy Project'
            or donor = other_donors.donor
        ) as `union`,
        (select count(distinct donee) from donations
            where donor = 'Open Philanthropy Project'
        ) as `donor_size`,
        (select count(distinct donee) from donations
            where donor = other_donors.donor
        ) as `other_donor_size`,
        (select sqrt(sum(sqsums.s))
            from (
                select power(sum(amount),2) as s
                from donations
                where donor = 'Open Philanthropy Project'
                group by donee
            ) as sqsums
        ) as `weighted_magnitude`,
        (select sqrt(sum(sqsums.s))
            from (
                select donor,power(sum(amount),1) as s
                from donations
                group by donee, donor
            ) as sqsums
            where donor = other_donors.donor
        ) as `weighted_magnitude_other`,
        (1) as `weighted_dot_product`
    from (
        select distinct(donor) from donations
        where donor != 'Open Philanthropy Project'
    ) as other_donors
) as similarity
having jaccard_index > 0
order by jaccard_index desc;
