drop table if exists two_donees_one_donor;
drop table if exists donee_summary;
drop table if exists donee_summary_2;
drop table if exists donee_sim_pre;
drop table if exists donee_sim;
drop table if exists donee_similarity;

set @dne = "Machine Intelligence Research Institute" COLLATE utf8_unicode_ci;

create table two_donees_one_donor as
select
    donor_donee_pairs.donee as first_donee,
    donor_donee_pairs_2.donee as second_donee,
    donor_donee_pairs.donor as donor,
    donor_donee_pairs.total_donation as first_donee_total,
    donor_donee_pairs_2.total_donation as second_donee_total,
    donor_donee_pairs.num_donations as first_num_donations,
    donor_donee_pairs_2.num_donations as second_num_donations
from donor_donee_pairs
left join donor_donee_pairs_2 on
    donor_donee_pairs.donor = donor_donee_pairs_2.donor
    # yes, we already have the following condition in the "where" clause
    # below, but having it here in addition seems to make the
    # procedure run faster
    and (donor_donee_pairs.donee=@dne or donor_donee_pairs_2.donee=@dne)
where donor_donee_pairs.donee=@dne or donor_donee_pairs_2.donee=@dne;

create table donee_summary as
select
    donee,
    count(distinct donor) as donor_count,
    sqrt(sum(power(total_donation, 2))) as weighted_magnitude
from donor_donee_pairs where donee=@dne group by donee;

create table donee_summary_2 as select * from donee_summary;

create table donee_sim_pre as
select
    first_donee,
    second_donee,
    (select count(distinct donor) from donor_donee_pairs
     where donee in (first_donee, second_donee)
    ) as `union_size`,
    sum(first_donee_total * second_donee_total) as weighted_dot_product
from two_donees_one_donor
where first_donee=@dne or second_donee=@dne
group by first_donee, second_donee;

create table donee_sim as
select
    first_donee,
    second_donee,
    union_size,
    donee_summary.donor_count + donee_summary_2.donor_count - union_size
        as intersect_size,
    weighted_dot_product,
    donee_summary.donor_count as first_donee_size,
    donee_summary.weighted_magnitude as weighted_magnitude,
    donee_summary_2.donor_count as second_donee_size,
    donee_summary_2.weighted_magnitude as weighted_magnitude_other
from
    donee_sim_pre
    left join donee_summary on
        donee_sim_pre.first_donee = donee_summary.donee
    left join donee_summary_2 on
        donee_sim_pre.second_donee = donee_summary_2.donee
where first_donee=@dne or second_donee=@dne;

create table donee_similarity as
select
    first_donee,
    second_donee,
    `first_donee_size`,
    `second_donee_size`,
    `union_size`,
    intersect_size,
    round(intersect_size / union_size, 4) as jaccard_index,
    round(intersect_size /
          (sqrt(first_donee_size) * sqrt(second_donee_size)), 4) as `cosine_similarity`,
    if(weighted_magnitude = 0 or weighted_magnitude_other = 0,
       NULL,
       round(weighted_dot_product / (weighted_magnitude *
          weighted_magnitude_other), 4)) as weighted_cosine_similarity
from donee_sim where intersect_size > 0 and first_donee != second_donee
    and (first_donee=@dne or second_donee=@dne);
