-- Modified from https://stackoverflow.com/a/36823694/3422337

drop table if exists donee_similarity_donor_donee_pairs;

drop table if exists donee_similarity_donor_donee_pairs_2;

drop table if exists donee_similarity_two_donors_one_donee;

drop table if exists donee_similarity_donor_summary;

drop table if exists donee_similarity_donor_summary_2;

drop table if exists donee_similarity_sim_pre;

drop table if exists donee_similarity_sim;

create table donee_similarity_donor_donee_pairs as select donor, donee, coalesce(sum(amount), 0) as total_donation, count(*) as num_donations from donations group by donor, donee;

create table donee_similarity_donor_donee_pairs_2 as select * from donee_similarity_donor_donee_pairs;

create table donee_similarity_two_donors_one_donee as select
  donee_similarity_donor_donee_pairs.donor as first_donor,
  donee_similarity_donor_donee_pairs_2.donor as second_donor,
  donee_similarity_donor_donee_pairs.donee as donee,
  donee_similarity_donor_donee_pairs.total_donation as first_donor_total,
  donee_similarity_donor_donee_pairs_2.total_donation as second_donor_total,
  donee_similarity_donor_donee_pairs.num_donations as first_num_donations,
  donee_similarity_donor_donee_pairs_2.num_donations as second_num_donations
from donee_similarity_donor_donee_pairs left join donee_similarity_donor_donee_pairs_2 on donee_similarity_donor_donee_pairs.donee = donee_similarity_donor_donee_pairs_2.donee;


create table donee_similarity_donor_summary as select
  donor,
  count(distinct donee) as donee_count,
  sqrt(sum(power(total_donation, 2))) as weighted_magnitude
from donee_similarity_donor_donee_pairs group by donor;

create table donee_similarity_donor_summary_2 as select * from donee_similarity_donor_summary;

create table donee_similarity_sim_pre as select
  first_donor,
  second_donor,
  (select count(distinct donee) from donee_similarity_donor_donee_pairs
     where donor in (first_donor, second_donor)
   ) as `union_size`,
  sum(first_donor_total * second_donor_total) as weighted_dot_product
from donee_similarity_two_donors_one_donee group by first_donor, second_donor;

create table donee_similarity_sim as select
  first_donor,
  second_donor,
  union_size,
  donee_similarity_donor_summary.donee_count + donee_similarity_donor_summary_2.donee_count - union_size
      as intersect_size,
  weighted_dot_product,
  donee_similarity_donor_summary.donee_count as first_donor_size,
  donee_similarity_donor_summary.weighted_magnitude as weighted_magnitude,
  donee_similarity_donor_summary_2.donee_count as second_donor_size,
  donee_similarity_donor_summary_2.weighted_magnitude as weighted_magnitude_other
from
  donee_similarity_sim_pre
  left join donee_similarity_donor_summary on
    donee_similarity_sim_pre.first_donor = donee_similarity_donor_summary.donor
  left join donee_similarity_donor_summary_2 on
    donee_similarity_sim_pre.second_donor = donee_similarity_donor_summary_2.donor;

truncate table donee_similarity_similarity;

insert into donee_similarity_similarity
select
  first_donor,
  second_donor,
  `first_donor_size`,
  `second_donor_size`,
  `union_size`,
  intersect_size,
  round(intersect_size / union_size, 4) as jaccard_index,
  round(intersect_size /
        (sqrt(first_donor_size) * sqrt(second_donor_size)), 4) as cosine_similarity,
  if(weighted_magnitude = 0 or weighted_magnitude_other = 0,
     NULL,
     round(weighted_dot_product / (weighted_magnitude *
        weighted_magnitude_other), 4)) as weighted_cosine_similarity
from donee_similarity_sim where intersect_size > 0 and first_donor != second_donor;
