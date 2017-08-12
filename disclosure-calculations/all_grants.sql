select
    donee,
    amount,
    donation_date,
    substring_index(cause_area,'/',1) as focus_area,
    (donor, donee, url, donation_date) in (
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
    ) as disclosed
from donations
where donor = 'Open Philanthropy Project';
