-- Modified from https://stackoverflow.com/a/36823694/3422337
insert into similarity
select
    sim.first_donor,
    sim.second_donor,
    sim.`first_donor_size`,
    sim.`second_donor_size`,
    sim.`union_size`,
    sim.first_donor_size + sim.second_donor_size - sim.union_size as intersect_size,
    round((sim.first_donor_size + sim.second_donor_size - sim.union_size) /
        sim.union_size, 4) as jaccard_index,
    round((sim.first_donor_size + sim.second_donor_size - sim.union_size) /
        (sqrt(sim.first_donor_size) * sqrt(sim.second_donor_size)), 4) as cosine_sim,
    round(sim.weighted_dot_product / (sim.weighted_magnitude *
        sim.weighted_magnitude_other), 4) as weighted_cosine_similarity
from (
    select
        d1.donor as first_donor,
        d2.donor as second_donor,
        (select count(distinct donee) from donations
            where donor = d1.donor
            or donor = d2.donor
        ) as `union_size`,
        (select count(distinct donee) from donations
            where donor = d1.donor
        ) as `first_donor_size`,
        (select count(distinct donee) from donations
            where donor = d2.donor
        ) as `second_donor_size`,
        (select sqrt(sum(sqsums.s))
            from (
                select donor,power(sum(amount),2) as s
                from donations
                group by donee, donor
            ) as sqsums
            where donor = d1.donor
        ) as `weighted_magnitude`,
        (select sqrt(sum(sqsums.s))
            from (
                select donor,power(sum(amount),2) as s
                from donations
                group by donee, donor
            ) as sqsums
            where donor = d2.donor
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
            where donor1 = d1.donor and donor2 = d2.donor
        ) as `weighted_dot_product`
    from (
        select distinct(donor) from donations
    ) as d1, (
        select distinct(donor) from donations
    ) as d2
    where d1.donor < d2.donor
) as sim
having jaccard_index > 0
order by jaccard_index desc;
