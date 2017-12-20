# -- Sophie Monahan donations
insert into donations(donor, donee, amount, fraction, donation_date,
    donation_date_precision, donation_date_basis, cause_area, url, notes,
    payment_modality, match_eligible, goal_amount, influencer, employer_match,
    matching_employer) values 
    ('Sophie Monahan','Against Malaria Foundation',NULL,1.0,'2015-12-09','day','date of donation announcement','Global health/malaria','https://blog.givewell.org/2015/12/09/staff-members-personal-donations-for-giving-season-2015/','Following GiveWell recommendation, does not believe there is information that gives her reason to do better than overall GiveWell recommendation',NULL,NULL,NULL,'GiveWell',NULL,NULL),
    ('Sophie Monahan','GiveDirectly',NULL,1.0,'2016-12-09','day','date of donation announcement','Cash transfers','https://blog.givewell.org/2016/12/09/staff-members-personal-donations-giving-season-2016/','Some differences with GiveWell re: cost-effectiveness estimates. Believes all charities recommended by GiveWell are roughly equal, but GiveWell prioritizes GiveDirectly lowest. Hence, donating to GiveDirectly',NULL,NULL,NULL,'GiveWell',NULL,NULL);
