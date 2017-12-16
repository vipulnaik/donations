# This is basically like similarity/similarity-incremental.sql except now we
# have to compute the similarity by cause area.  The non-incremental version
# of this procedure is similarity/similarity-4.sql.

drop procedure if exists updateSimilarityCauseArea;

delimiter $$

create procedure updateSimilarityCauseArea(dnr varchar(100))
begin
    delete from cause_area_donor_donee_pairs where donor=dnr;
    insert into cause_area_donor_donee_pairs (cause_area, donor, donee, total_donation, num_donations)
    select
        substring_index(cause_area,'/',1) as cause_area,
        donor,
        donee,
        coalesce(sum(amount), 0) as total_donation,
        count(*) as num_donations
    from donations where donor=dnr group by donor, donee, substring_index(cause_area,'/',1);

    delete from cause_area_donor_donee_pairs_2 where donor=dnr;
    insert into cause_area_donor_donee_pairs_2 (cause_area, donor, donee, total_donation, num_donations)
    select
        substring_index(cause_area,'/',1) as cause_area,
        donor,
        donee,
        coalesce(sum(amount), 0) as total_donation,
        count(*) as num_donations
    from donations where donor=dnr group by donor, donee, substring_index(cause_area,'/',1);

    delete from cause_area_two_donors_one_donee where first_donor=dnr or second_donor=dnr;
    insert into cause_area_two_donors_one_donee (
        cause_area,
        first_donor,
        second_donor,
        donee,
        first_donor_total,
        second_donor_total,
        first_num_donations,
        second_num_donations
    )
    select
        cause_area_donor_donee_pairs.cause_area as cause_area,
        cause_area_donor_donee_pairs.donor as first_donor,
        cause_area_donor_donee_pairs_2.donor as second_donor,
        cause_area_donor_donee_pairs.donee as donee,
        cause_area_donor_donee_pairs.total_donation as first_donor_total,
        cause_area_donor_donee_pairs_2.total_donation as second_donor_total,
        cause_area_donor_donee_pairs.num_donations as first_num_donations,
        cause_area_donor_donee_pairs_2.num_donations as second_num_donations
    from cause_area_donor_donee_pairs
    left join cause_area_donor_donee_pairs_2 on
        cause_area_donor_donee_pairs.donee = cause_area_donor_donee_pairs_2.donee
        and cause_area_donor_donee_pairs.cause_area = cause_area_donor_donee_pairs_2.cause_area
        and (cause_area_donor_donee_pairs.donor=dnr or cause_area_donor_donee_pairs_2.donor=dnr)
    where cause_area_donor_donee_pairs.donor=dnr or cause_area_donor_donee_pairs_2.donor=dnr;

    delete from cause_area_donor_summary where donor=dnr;
    insert into cause_area_donor_summary (cause_area, donor, donee_count, weighted_magnitude)
    select
        cause_area,
        donor,
        count(distinct donee) as donee_count,
        sqrt(sum(power(total_donation, 2))) as weighted_magnitude
    from cause_area_donor_donee_pairs where donor=dnr group by donor, cause_area;

    delete from cause_area_donor_summary_2 where donor=dnr;
    insert into cause_area_donor_summary_2 (cause_area, donor, donee_count, weighted_magnitude)
    select
        cause_area,
        donor,
        count(distinct donee) as donee_count,
        sqrt(sum(power(total_donation, 2))) as weighted_magnitude
    from cause_area_donor_donee_pairs where donor=dnr group by donor, cause_area;

    delete from cause_area_sim_pre where first_donor=dnr or second_donor=dnr;
    insert into cause_area_sim_pre (
        cause_area,
        first_donor,
        second_donor,
        `union_size`,
         weighted_dot_product
    )
    select
        cause_area,
        first_donor,
        second_donor,
        (select count(distinct donee) from cause_area_donor_donee_pairs
           where donor in (first_donor, second_donor) and cause_area=cause_area_two_donors_one_donee.cause_area
         ) as `union_size`,
        sum(first_donor_total * second_donor_total) as weighted_dot_product
    from cause_area_two_donors_one_donee
    where first_donor=dnr or second_donor=dnr
    group by first_donor, second_donor, cause_area;

    delete from cause_area_sim where first_donor=dnr or second_donor=dnr;
    insert into cause_area_sim (
        cause_area,
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
        cause_area_sim_pre.cause_area,
        first_donor,
        second_donor,
        union_size,
        cause_area_donor_summary.donee_count + cause_area_donor_summary_2.donee_count - union_size
            as intersect_size,
        weighted_dot_product,
        cause_area_donor_summary.donee_count as first_donor_size,
        cause_area_donor_summary.weighted_magnitude as weighted_magnitude,
        cause_area_donor_summary_2.donee_count as second_donor_size,
        cause_area_donor_summary_2.weighted_magnitude as weighted_magnitude_other
    from
      cause_area_sim_pre
      left join cause_area_donor_summary on
        cause_area_sim_pre.first_donor = cause_area_donor_summary.donor
        and cause_area_sim_pre.cause_area = cause_area_donor_summary.cause_area
      left join cause_area_donor_summary_2 on
        cause_area_sim_pre.second_donor = cause_area_donor_summary_2.donor
        and cause_area_sim_pre.cause_area = cause_area_donor_summary_2.cause_area
    where first_donor=dnr or second_donor=dnr;

    delete from cause_area_similarity where first_donor=dnr or second_donor=dnr;
    insert into cause_area_similarity (
        cause_area,
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
        cause_area,
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
    from cause_area_sim where intersect_size > 0 and first_donor != second_donor
        and (first_donor=dnr or second_donor=dnr);

end$$
delimiter ;

call updateSimilarityCauseArea("Vipul Naik");
