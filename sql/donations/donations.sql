# -- Eva Vivalt
insert into donations(donor, donee, amount, fraction, donation_date, donation_date_precision, donation_date_basis, cause_area, url, notes) values
    ('Eva Vivalt','AidGrade',NULL,1.0,'2016-12-09','day','date of donation announcement','International aid/global health/global poverty/evaluation','http://effective-altruism.com/ea/14u/eas_write_about_where_they_give/','AidGrade was founded by Eva Vivalt. She describes the donation as "putting my money where my mouth is"');

# -- Jacob Trefethen
insert into donations(donor, donee, amount, fraction, donation_date, donation_date_precision, donation_date_basis, cause_area, url, notes) values
  ('Jacob Trefethen','Environmental Data and Governance Initiative',NULL,1.0,'2017-01-16','day','date of donation announcement','Environmentalism/watchdog','http://effective-altruism.com/ea/16b/why_i_donated_to_the_environmental_data/','Donation made to small nonprofit based on inside information and close contact with the organization, making it easier to evaluate');

insert into donations(donor, donee, amount, fraction, donation_date, donation_date_precision, donation_date_basis, cause_area, url, notes, special_donation_reason) values
  ('Joshua Zelinsky','Internet Archive',20.0,NULL,'2011-08-21','day','date of donation announced in announcement','Digital preservation','https://www.lesswrong.com/posts/eD6TZm2r25HzYzZzY/spaced-repetition-literature-review-prize-and-the-winner-is#RydGTnYufdjxzvDKW','Charity chosen by Gwern Branwen, who won the spaced repetition literature review prize.','Prize to charity of choice');

# -- The Oxford Prioritisation Project grant
insert into donations(donor, donee, amount, fraction, donation_date,
    donation_date_precision, donation_date_basis, cause_area, url, notes,
    payment_modality, match_eligible, goal_amount, influencer, employer_match,
    matching_employer, amount_original_currency, original_currency,
    currency_conversion_date, currency_conversion_basis,
    donation_announcement_date, donation_announcement_date_precision,
    donation_announcement_url) values
    ('Oxford Prioritisation Project', '80,000 Hours', 12934, NULL, '2017-05-09', 'day', 'date of donation announcement', 'Effective altruism/movement growth', 'https://oxpr.io/blog/2017/5/20/four-quantiative-models-aggregation-and-final-decision', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 10000, 'GBP', '2017-05-09', 'Bloomberg', '2017-05-09', 'day', 'https://www.facebook.com/events/336092186805365/');

# -- Also includes GiveWell and Open Phil donors who have only one year of donation information

# -- Christian Smith
insert into donations(donor, donee, amount, fraction, donation_date, donation_date_precision, donation_date_basis, cause_area, url, notes, influencer) values
  ('Christian Smith','GiveWell top charities',NULL,1.0,'2017-12-11','day','date of donation announcement','Global health and cash transfers','https://blog.givewell.org/2017/12/11/staff-members-personal-donations-for-giving-season-2017/#Christian','Donor decided to grant to GiveWell for regranting, and believes more strongly in the research process of GiveWell and the importance of the funding gaps. Donor also considered animal welfare and the far future, but ultimately decided to focus on supporting causes in global health and development','GiveWell');

# -- Morgan Davis
insert into donations(donor, donee, amount, fraction, donation_date, donation_date_precision, donation_date_basis, cause_area, url, notes, influencer) values
  ('Morgan Davis','Effective Altruism Funds',NULL,1.0,'2017-12-18','day','date of donation announcement',NULL,'https://www.openphilanthropy.org/blog/staff-members-personal-donations-giving-season-2017#Morgan','Split between the different funds: 5% for animal welfare, 5% for global development, 15% for EA Community, and 75% for the long-term future fund. Donor also considered donating to Berkeley Existential Risk Initiative (BERI), which she is impressed by, and sees a need for after encountering bureaucracy in academia while working as grant manager for the Open Philanthropy Project. However, she ultimately felt that the fund managers for Effective Altruism Funds would be able to make better decisions', NULL);

# -- Michael Levine
insert into donations(donor, donee, amount, fraction, donation_date, donation_date_precision, donation_date_basis, cause_area, url, notes, influencer) values
  ('Michael Levine','Against Malaria Foundation',NULL,0.7,'2017-12-18','day','date of donation announcement','Global health/malaria','https://www.openphilanthropy.org/blog/staff-members-personal-donations-giving-season-2017#Mike','Donation of 70% to Against Malaria Foundation, consistent with the GiveWell recommendation for people who want to directly donate to GiveWell top charities (70% to Against Malaria Foundation, 30% to Schistosomiasis Control Initiative)','GiveWell'),
  ('Michael Levine','GiveDirectly',NULL,0.3,'2017-12-18','day','date of donation announcement','Cash transfers','https://www.openphilanthropy.org/blog/staff-members-personal-donations-giving-season-2017#Mike','Donation of 30% to GiveDirectly, which deviates from the GiveWell recommendation for people who want to directly donate to GiveWell top charities (70% to Against Malaria Foundation, 30% to Schistosomiasis Control Initiative) because, as donor states: "I see value in having direct cash transfers serve as a benchmark for other interventions, and in part because I want to signal my excitement about GiveDirectly’s new universal basic income project, even if my contribution will not meaningfully advance that specific work."','GiveWell');
