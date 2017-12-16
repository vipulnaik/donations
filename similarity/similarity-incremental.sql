drop procedure if exists updateSimilarity;

delimiter $$

create procedure updateSimilarity(dnr varchar(100))
begin
    delete from donor_donee_pairs where donor=dnr;
    delete from donor_donee_pairs_2 where donor=dnr;

    insert into donor_donee_pairs (donor, donee, total_donation, num_donations)
    select
        donor,
        donee,
        coalesce(sum(amount), 0) as total_donation,
        count(*) as num_donations
    from donations where donor=dnr group by donor, donee;

    insert into donor_donee_pairs_2 (donor, donee, total_donation, num_donations)
    select
        donor,
        donee,
        coalesce(sum(amount), 0) as total_donation,
        count(*) as num_donations
    from donations where donor=dnr group by donor, donee;

    delete from two_donors_one_donee where first_donor=dnr or second_donor=dnr;
    insert into two_donors_one_donee (
        first_donor,
        second_donor,
        donee,
        first_donor_total,
        second_donor_total,
        first_num_donations,
        second_num_donations
    )
    select
        donor_donee_pairs.donor as first_donor,
        donor_donee_pairs_2.donor as second_donor,
        donor_donee_pairs.donee as donee,
        donor_donee_pairs.total_donation as first_donor_total,
        donor_donee_pairs_2.total_donation as second_donor_total,
        donor_donee_pairs.num_donations as first_num_donations,
        donor_donee_pairs_2.num_donations as second_num_donations
    from donor_donee_pairs
    left join donor_donee_pairs_2 on
        donor_donee_pairs.donee = donor_donee_pairs_2.donee
        and (donor_donee_pairs.donor=dnr or donor_donee_pairs_2.donor=dnr)
    where donor_donee_pairs.donor=dnr or donor_donee_pairs_2.donor=dnr;

    delete from donor_summary where donor=dnr;
    insert into donor_summary (donor, donee_count, weighted_magnitude)
    select
        donor,
        count(distinct donee) as donee_count,
        sqrt(sum(power(total_donation, 2))) as weighted_magnitude
    from donor_donee_pairs where donor=dnr group by donor;

    delete from donor_summary_2 where donor=dnr;
    insert into donor_summary_2 (donor, donee_count, weighted_magnitude)
    select
        donor,
        count(distinct donee) as donee_count,
        sqrt(sum(power(total_donation, 2))) as weighted_magnitude
    from donor_donee_pairs where donor=dnr group by donor;

    delete from sim_pre where first_donor=dnr or second_donor=dnr;
    insert into sim_pre (
        first_donor,
        second_donor,
        `union_size`,
         weighted_dot_product
    )
    select
        first_donor,
        second_donor,
        (select count(distinct donee) from donor_donee_pairs
         where donor in (first_donor, second_donor)
        ) as `union_size`,
        sum(first_donor_total * second_donor_total) as weighted_dot_product
    from two_donors_one_donee
    where first_donor=dnr or second_donor=dnr
    group by first_donor, second_donor;

    delete from sim where first_donor=dnr or second_donor=dnr;
    insert into sim (
        first_donor,
        second_donor,
        union_size,
        intersect_size,
        weighted_dot_product,
        first_donor_size,
        weighted_magnitude,
        second_donor_size,
        weighted_magnitude_other
    )
    select
        first_donor,
        second_donor,
        union_size,
        donor_summary.donee_count + donor_summary_2.donee_count - union_size
            as intersect_size,
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
            sim_pre.second_donor = donor_summary_2.donor
    where first_donor=dnr or second_donor=dnr;

    delete from similarity where first_donor=dnr or second_donor=dnr;
    insert into similarity (
        first_donor,
        second_donor,
        first_donor_size,
        second_donor_size,
        union_size,
        intersect_size,
        jaccard_index,
        `cosine_similarity`,
        weighted_cosine_similarity
    )
    select
        first_donor,
        second_donor,
        `first_donor_size`,
        `second_donor_size`,
        `union_size`,
        intersect_size,
        round(intersect_size / union_size, 4) as jaccard_index,
        round(intersect_size /
              (sqrt(first_donor_size) * sqrt(second_donor_size)), 4) as `cosine_similarity`,
        if(weighted_magnitude = 0 or weighted_magnitude_other = 0,
           NULL,
           round(weighted_dot_product / (weighted_magnitude *
              weighted_magnitude_other), 4)) as weighted_cosine_similarity
    from sim where intersect_size > 0 and first_donor != second_donor
        and (first_donor=dnr or second_donor=dnr);

end$$
delimiter ;

call updateSimilarity("Vipul Naik");
