-- Modified from https://stackoverflow.com/a/36823694/3422337
select
    jaccard.donor,
    jaccard.intersect,
    jaccard.union,
    jaccard.intersect/jaccard.union as jaccard_index
from (
    select
        other_donors.donor,
        (select count(distinct donee) from donations
            where donor = 'Open Philanthropy Project' and
            donee in (select distinct(donee) from donations where
                donor = other_donors.donor
            )
        ) as 'intersect',
        (select count(distinct donee) from donations where donor = 'Open Philanthropy Project' or donor = other_donors.donor) as 'union'
    from
        (select distinct(donor) from donations
            where donor != 'Open Philanthropy Project') as other_donors
) as jaccard
order by jaccard_index desc;
