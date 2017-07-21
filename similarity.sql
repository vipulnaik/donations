-- Modified from https://stackoverflow.com/a/36823694/3422337
select
    similarity.donor,
    similarity.donor_size,
    similarity.other_donor_size,
    similarity.intersect,
    similarity.union,
    sqrt(similarity.donor_size) * sqrt(similarity.other_donor_size)
        as magnitude_product,
    similarity.intersect/similarity.union as jaccard_index,
    similarity.intersect / (sqrt(similarity.donor_size) *
        sqrt(similarity.other_donor_size)) as cosine_similarity
from (
    select
        other_donors.donor as donor,
        (select count(distinct donee) from donations
            where donor = other_donors.donor
            and donee in (
                select distinct(donee) from donations
                where donor = 'Open Philanthropy Project'
            )
        ) as 'intersect',
        (select count(distinct donee) from donations
            where donor = 'Open Philanthropy Project'
            or donor = other_donors.donor
        ) as 'union',
        (select count(distinct donee) from donations
            where donor = 'Open Philanthropy Project'
        ) as 'donor_size',
        (select count(distinct donee) from donations
            where donor = other_donors.donor
        ) as 'other_donor_size'
    from (
        select distinct(donor) from donations
        where donor != 'Open Philanthropy Project'
    ) as other_donors
) as similarity
having jaccard_index > 0
order by jaccard_index desc;
