drop temporary table if exists disclosed_donations_focus_area_summary;
drop temporary table if exists donations_focus_area_summary;

create temporary table disclosed_donations_focus_area_summary as
select
    substring_index(cause_area,'/',1) as focus_area,
    sum(amount) as amount,
    count(*) as numDonations,
    count(distinct donations.donee) as numDonees
from (
    select
        donor,
        donee,
        donation_url,
        donation_date
    from disclosures
    group by
        donor,
        donee,
        donation_url,
        donation_date
) as d1
left join donations on
    d1.donation_url=donations.url
    and d1.donor=donations.donor
    and d1.donee=donations.donee
    and d1.donation_date=donations.donation_date
where donations.donor = 'Open Philanthropy Project'
group by substring_index(cause_area,'/',1);

create temporary table donations_focus_area_summary as
select
    substring_index(cause_area,'/',1) as focus_area,
    sum(amount) as amount,
    count(*) as numDonations,
    count(distinct donations.donee) as numDonees
from  donations
where donor = 'Open Philanthropy Project'
group by substring_index(cause_area,'/',1);

select
    donations_focus_area_summary.focus_area,
    donations_focus_area_summary.amount as `amount`,
    coalesce(disclosed_donations_focus_area_summary.amount,0) as `disclosed amount`,
    donations_focus_area_summary.numDonations as numDonations,
    coalesce(disclosed_donations_focus_area_summary.numDonations,0) as `disclosed numDonations`,
    donations_focus_area_summary.numDonees as numDonees,
    coalesce(disclosed_donations_focus_area_summary.numDonees,0) as `disclosed numDonees`,
    coalesce(disclosed_donations_focus_area_summary.amount,0) / donations_focus_area_summary.amount as `amount % disclosed`,
    coalesce(disclosed_donations_focus_area_summary.numDonations,0) / donations_focus_area_summary.numDonations as `donations % disclosed`,
    coalesce(disclosed_donations_focus_area_summary.numDonees,0) / donations_focus_area_summary.numDonees as `donees % disclosed`
from donations_focus_area_summary
left join disclosed_donations_focus_area_summary on
    donations_focus_area_summary.focus_area = disclosed_donations_focus_area_summary.focus_area;
