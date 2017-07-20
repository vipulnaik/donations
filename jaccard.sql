-- Modified from https://stackoverflow.com/a/36823694/3422337
select
    jaccard.donor,
    jaccard.intersect,
    jaccard.union,
    jaccard.intersect/jaccard.union as jaccard_index
from (
    select
        d2.donor as donor,
        count(distinct dt2.donee) as 'intersect',
        (select count(distinct dt3.donee) from
         donations dt3 where dt3.donor in(d1.donor, d2.donor)) as 'union'
    from
        donors as d1
        inner join donors as d2 on d1.donor != d2.donor
        left join donations as dt1 on dt1.donor = d1.donor
        left join donations as dt2 on dt2.donor = d2.donor and dt1.donee = dt2.donee
    where d1.donor = 'Open Philanthropy Project'
    group by d1.donor, d2.donor
) as jaccard
order by jaccard_index desc;
