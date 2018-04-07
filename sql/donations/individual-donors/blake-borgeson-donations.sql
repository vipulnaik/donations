# -- Blake Borgeson donations

insert into donations(donor, donee, amount, fraction, donation_date,
    donation_date_precision, donation_date_basis, cause_area, url, notes,
    payment_modality, match_eligible, goal_amount, influencer, employer_match,
    matching_employer) values 
    ('Blake Borgeson','Machine Intelligence Research Institute',50460,NULL,'2015-01-01','year','donee contributor list','AI safety','https://intelligence.org/topdonors/','Took total donation amount and subtracted known donation of 300000 for 2016',NULL, NULL, NULL, NULL, NULL, NULL),
    ('Blake Borgeson','Machine Intelligence Research Institute',300000,0.50,'2016-01-01','year','donee contributor list','AI safety','https://intelligence.org/2016/08/05/miri-strategy-update-2016/','Second biggest donation in the history of MIRI, see also http://effective-altruism.com/ea/14u/eas_write_about_where_they_give/ for more context on overall donations for the year',NULL, NULL, NULL, NULL, NULL, NULL),
    ('Blake Borgeson','Center for Applied Rationality',90000,0.15,'2016-01-01','year','date of donation announced in announcement',NULL,'http://effective-altruism.com/ea/14u/eas_write_about_where_they_give/','Borgeson did not specify numerical amounts but gave percentages, combined these with other info of 300000 dollars to MIRI in https://intelligence.org/2016/08/05/miri-strategy-update-2016/',NULL, NULL, NULL, NULL, NULL, NULL);
