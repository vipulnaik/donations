-- Modified from https://stackoverflow.com/a/36823694/3422337
select
    jaccard.donor,
    jaccard.intersect,
    jaccard.union,
    jaccard.intersect/jaccard.union as jaccard_index,
    jaccard.intersect / (sqrt(jaccard.donor_size) *
        sqrt(jaccard.other_donor_size)) as cosine_similarity
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
) as jaccard
having jaccard_index > 0
order by jaccard_index desc;
