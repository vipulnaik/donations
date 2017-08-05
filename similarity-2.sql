-- Modified from https://stackoverflow.com/a/36823694/3422337

drop temporary table if exists donor_donee_pairs;

drop temporary table if exists donor_donee_pairs_2;

drop temporary table if exists two_donors_one_donee;

drop temporary table if exists donor_summary;

drop temporary table if exists donor_summary_2;

drop temporary table if exists sim_pre;

drop temporary table if exists sim;

create temporary table donor_donee_pairs as select donor, donee, coalesce(sum(amount), 0) as total_donation, count(*) as num_donations from donations group by donor, donee;

create temporary table donor_donee_pairs_2 as select * from donor_donee_pairs;

create temporary table two_donors_one_donee as select
  donor_donee_pairs.donor as first_donor,
  donor_donee_pairs_2.donor as second_donor,
  donor_donee_pairs.donee as donee,
  donor_donee_pairs.total_donation as first_donor_total,
  donor_donee_pairs_2.total_donation as second_donor_total,
  donor_donee_pairs.num_donations as first_num_donations,
  donor_donee_pairs_2.num_donations as second_num_donations
from donor_donee_pairs left join donor_donee_pairs_2 on donor_donee_pairs.donee = donor_donee_pairs_2.donee;


create temporary table donor_summary as select
  donor,
  count(distinct donee) as donee_count,
  sum(power(total_donation, 2)) as weighted_magnitude
from donor_donee_pairs group by donor;

create temporary table donor_summary_2 as select * from donor_summary;

create temporary table sim_pre as select
  first_donor,
  second_donor,
  (select count(distinct donee) from donor_donee_pairs
     where donor in (first_donor, second_donor)
   ) as `union_size`,
  sum(first_donor_total * second_donor_total) as weighted_dot_product
from two_donors_one_donee group by first_donor, second_donor;

create temporary table sim as select
  first_donor,
  second_donor,
  union_size,
  weighted_dot_product,
  donor_summary.donee_count as first_donor_size,
  donor_summary.weighted_magnitude as weighted_magnitude,
  donor_summary_2.donee_count as second_donor_size,
  donor_summary_2.weighted_magnitude as weighted_magnitude_other
from
  sim_pre
  left join donor_summary on
    sim_pre.first_donor = donor_summary.donor
  left join donor_summary_2 on
    sim_pre.second_donor = donor_summary_2.donor;

insert into similarity
select
  first_donor,
  second_donor,
  `first_donor_size`,
  `second_donor_size`,
  `union_size`,
  first_donor_size + second_donor_size - union_size as intersect_size,
  round((first_donor_size + second_donor_size - union_size) /
        union_size, 4) as jaccard_index,
  round((first_donor_size + second_donor_size - union_size) /
        (sqrt(first_donor_size) * sqrt(second_donor_size)), 4) as cosine_sim,
  round(weighted_dot_product / (weighted_magnitude *
        weighted_magnitude_other), 4) as weighted_cosine_similarity
from sim where weighted_magnitude > 0 and weighted_magnitude_other > 0 and weighted_dot_product > 0 and first_donor != second_donor;
