-- Modified from https://stackoverflow.com/a/36823694/3422337
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
                where donor = 'Open Philanthropy Project'
            )
        ) as 'intersect',
        (select count(distinct donee) from donations
            where donor = 'Open Philanthropy Project'
            or donor = other_donors.donor
        ) as 'union'
    from (
        select distinct(donor) from donations
        where donor != 'Open Philanthropy Project'
    ) as other_donors
) as jaccard
having jaccard_index > 0
order by jaccard_index desc;
