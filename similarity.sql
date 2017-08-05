-- Modified from https://stackoverflow.com/a/36823694/3422337
insert into similarity
select
    'Open Philanthropy Project',
    similarity.`donor`,
    similarity.`donor_size`,
    similarity.`other_donor_size`,
    similarity.`intersect`,
    similarity.`union`,
    -- round(sqrt(similarity.donor_size) * sqrt(similarity.other_donor_size), 4)
    --     as magnitude_product,
    round(similarity.intersect/similarity.union, 4) as jaccard_index,
    round(similarity.intersect / (sqrt(similarity.donor_size) *
        sqrt(similarity.other_donor_size)), 4) as cosine_similarity,
    1.0
    -- round(similarity.weighted_magnitude, 4) as weighted_magnitude,
    -- round(similarity.weighted_magnitude_other, 4) as weighted_magnitude_other,
    -- round(similarity.weighted_dot_product, 4) as weighted_dot_product,
    -- round(similarity.weighted_dot_product / (similarity.weighted_magnitude *
    --     similarity.weighted_magnitude_other), 4) as weighted_cosine_similarity
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
            where donor1 = 'Open Philanthropy Project' and donor2 = other_donors.donor
        ) as `weighted_dot_product`
    from (
        select distinct(donor) from donations
        where donor != 'Open Philanthropy Project'
    ) as other_donors
) as similarity
having jaccard_index > 0
order by jaccard_index desc;
