# -- Eva Vivalt
insert into donations(donor, donee, amount, fraction, donation_date,
    donation_date_precision, donation_date_basis, cause_area, url, notes,
    payment_modality, match_eligible, goal_amount, influencer, employer_match,
    matching_employer) values 
    ('Eva Vivalt','AidGrade',NULL,1.0,'2016-12-09','day','date of donation announcement','International aid/global health/global poverty/evaluation','http://effective-altruism.com/ea/14u/eas_write_about_where_they_give/','AidGrade was founded by Eva Vivalt. She describes the donation as "putting my money where my mouth is"',NULL,NULL,NULL,NULL,NULL,NULL);

# -- Jacob Trefethen
insert into donations(donor, donee, amount, fraction, donation_date,
    donation_date_precision, donation_date_basis, cause_area, url, notes,
    payment_modality, match_eligible, goal_amount, influencer, employer_match,
    matching_employer) values 
    ('Jacob Trefethen','Environmental Data and Governance Initiative',NULL,1.0,'2017-01-16','day','date of donation announcement','Environmentalism/watchdog','http://effective-altruism.com/ea/16b/why_i_donated_to_the_environmental_data/','Donation made to small nonprofit based on inside information and close contact with the organization, making it easier to evaluate',NULL,NULL,NULL,NULL,NULL,NULL);

# -- Blake Borgeson donations

insert into donations(donor, donee, amount, fraction, donation_date,
    donation_date_precision, donation_date_basis, cause_area, url, notes,
    payment_modality, match_eligible, goal_amount, influencer, employer_match,
    matching_employer) values 
    ('Blake Borgeson','Machine Intelligence Research Institute',50460,NULL,'2015-01-01','year','donee contributor list','AI risk','https://intelligence.org/topdonors/','Took total donation amount and subtracted known donation of 300000 for 2016',NULL, NULL, NULL, NULL, NULL, NULL),
    ('Blake Borgeson','Machine Intelligence Research Institute',300000,0.50,'2016-01-01','year','donee contributor list','AI risk','https://intelligence.org/2016/08/05/miri-strategy-update-2016/','Second biggest donation in the history of MIRI, see also http://effective-altruism.com/ea/14u/eas_write_about_where_they_give/ for more context on overall donations for the year',NULL, NULL, NULL, NULL, NULL, NULL),
    ('Blake Borgeson','Center for Applied Rationality',90000,0.15,'2016-01-01','year','date of donation announced in announcement',NULL,'http://effective-altruism.com/ea/14u/eas_write_about_where_they_give/','Borgeson did not specify numerical amounts but gave percentages, combined these with other info of 300000 dollars to MIRI in https://intelligence.org/2016/08/05/miri-strategy-update-2016/',NULL, NULL, NULL, NULL, NULL, NULL);

# -- Sophie Monahan donations
insert into donations(donor, donee, amount, fraction, donation_date,
    donation_date_precision, donation_date_basis, cause_area, url, notes,
    payment_modality, match_eligible, goal_amount, influencer, employer_match,
    matching_employer) values 
    ('Sophie Monahan','Against Malaria Foundation',NULL,1.0,'2015-12-09','day','date of donation announcement','Global health/malaria','https://blog.givewell.org/2015/12/09/staff-members-personal-donations-for-giving-season-2015/','Following GiveWell recommendation, does not believe there is information that gives her reason to do better than overall GiveWell recommendation',NULL,NULL,NULL,'GiveWell',NULL,NULL),
    ('Sophie Monahan','GiveDirectly',NULL,1.0,'2016-12-09','day','date of donation announcement','Cash transfers','https://blog.givewell.org/2016/12/09/staff-members-personal-donations-giving-season-2016/','Some differences with GiveWell re: cost-effectiveness estimates. Believes all charities recommended by GiveWell are roughly equal, but GiveWell prioritizes GiveDirectly lowest. Hence, donating to GiveDirectly',NULL,NULL,NULL,'GiveWell',NULL,NULL);

# -- Ajeya Cotra donations
insert into donations(donor, donee, amount, fraction, donation_date,
    donation_date_precision, donation_date_basis, cause_area, url, notes,
    payment_modality, match_eligible, goal_amount, influencer, employer_match,
    matching_employer) values 
    ('Ajeya Cotra','A political campaign',2700,0.55,'2016-10-01','month','date of donation announced in announcement','Politics/United States','https://blog.givewell.org/2016/12/09/staff-members-personal-donations-giving-season-2016/','Target of donation not specified, but this donation was in mid-October, in the runup to the November 2016 United States presidential and legislative elections. Also, amount not explicitly specified, but inferred from 55-45 split in donations and knowledge of donor lottery amount from http://effective-altruism.com/ea/14d/donor_lotteries_a_stepbystep_guide_for_mall/ Note also that political campaign donations are capped at 2700 USD in the United States.',NULL,NULL,NULL,NULL,NULL,NULL),
    ('Ajeya Cotra', 'Donor lottery', 2200.00, 0.45, '2016-12-07', 'day', 'transaction', NULL, 'http://effective-altruism.com/ea/14d/donor_lotteries_a_stepbystep_guide_for_mall/', 'Reasoning explained more in https://blog.givewell.org/2016/12/09/staff-members-personal-donations-giving-season-2016/ (go to section for Ajeya Cotra)', NULL, NULL, NULL, NULL, NULL, NULL);

# -- The Oxford Prioritisation Project grant
insert into donations(donor, donee, amount, fraction, donation_date,
    donation_date_precision, donation_date_basis, cause_area, url, notes,
    payment_modality, match_eligible, goal_amount, influencer, employer_match,
    matching_employer, amount_original_currency, original_currency,
    currency_conversion_date, currency_conversion_basis,
    donation_announcement_date, donation_announcement_date_precision,
    donation_announcement_url) values
    ('Oxford Prioritisation Project', '80000 Hours', 12934, NULL, '2017-05-09', 'day', 'date of donation announcement', 'Effective altruism/movement growth', 'https://oxpr.io/blog/2017/5/20/four-quantiative-models-aggregation-and-final-decision', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 10000, 'GBP', '2017-05-09', 'Bloomberg', '2017-05-09', 'day', 'https://www.facebook.com/events/336092186805365/');
