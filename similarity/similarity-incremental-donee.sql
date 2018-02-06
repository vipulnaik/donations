drop procedure if exists updateSimilarityDonee;

delimiter $$

create procedure updateSimilarityDonee(dne varchar(100))
begin
    select concat(now(), "\tdoing ", dne) as '';

    # BEGIN testing
    delete from donor_donee_pairs where donee=dne;
    insert into donor_donee_pairs (donor, donee, total_donation, num_donations)
    select
        donor,
        donee,
        coalesce(sum(amount), 0) as total_donation,
        count(*) as num_donations
    from donations where donee=dne group by donor, donee;

    delete from donor_donee_pairs_2 where donee=dne;
    insert into donor_donee_pairs_2 (donor, donee, total_donation, num_donations)
    select
        donor,
        donee,
        coalesce(sum(amount), 0) as total_donation,
        count(*) as num_donations
    from donations where donee=dne group by donor, donee;
    # END testing

    delete from two_donees_one_donor where first_donee=dne or second_donee=dne;
    insert into two_donees_one_donor (
        first_donee,
        second_donee,
        donor,
        first_donee_total,
        second_donee_total,
        first_num_donations,
        second_num_donations
    )
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
        and (donor_donee_pairs.donee=dne or donor_donee_pairs_2.donee=dne)
    where donor_donee_pairs.donee=dne or donor_donee_pairs_2.donee=dne;

    delete from donee_summary where donee=dne;
    insert into donee_summary (donee, donor_count, weighted_magnitude)
    select
        donee,
        count(distinct donor) as donor_count,
        sqrt(sum(power(total_donation, 2))) as weighted_magnitude
    from donor_donee_pairs where donee=dne group by donee;

    delete from donee_summary_2 where donee=dne;
    insert into donee_summary_2 (donee, donor_count, weighted_magnitude)
    select
        donee,
        count(distinct donor) as donor_count,
        sqrt(sum(power(total_donation, 2))) as weighted_magnitude
    from donor_donee_pairs where donee=dne group by donee;

    delete from donee_sim_pre where first_donee=dne or second_donee=dne;
    insert into donee_sim_pre (
        first_donee,
        second_donee,
        union_size,
        weighted_dot_product
    )
    select
        first_donee,
        second_donee,
        (select count(distinct donor) from donor_donee_pairs
         where donee in (first_donee, second_donee)
        ) as `union_size`,
        sum(first_donee_total * second_donee_total) as weighted_dot_product
    from two_donees_one_donor
    where first_donee=dne or second_donee=dne
    group by first_donee, second_donee;

    delete from donee_sim where first_donee=dne or second_donee=dne;
    insert into donee_sim (
        first_donee,
        second_donee,
        union_size,
        intersect_size,
        weighted_dot_product,
        first_donee_size,
        weighted_magnitude,
        second_donee_size,
        weighted_magnitude_other
    )
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
    where first_donee=dne or second_donee=dne;

    delete from donee_similarity where first_donee=dne or second_donee=dne;
    insert into donee_similarity (
        first_donee,
        second_donee,
        first_donee_size,
        second_donee_size,
        union_size,
        intersect_size,
        jaccard_index,
        cosine_similarity,
        weighted_cosine_similarity
    )
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
        and (first_donee=dne or second_donee=dne);

end$$
delimiter ;

/* call updateSimilarityDonee("Machine Intelligence Research Institute"); */
