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
    where donor_donee_pairs.donor=dnr;

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


end$$
delimiter ;

call updateSimilarity("Vipul Naik");
