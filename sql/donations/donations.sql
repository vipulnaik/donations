# -- Eva Vivalt
insert into donations(donor, donee, amount, fraction, donation_date, donation_date_precision, donation_date_basis, cause_area, url, notes) values
    ('Eva Vivalt','AidGrade',NULL,1.0,'2016-12-09','day','date of donation announcement','International aid/global health/global poverty/evaluation','http://effective-altruism.com/ea/14u/eas_write_about_where_they_give/','AidGrade was founded by Eva Vivalt. She describes the donation as "putting my money where my mouth is"');

# -- Jacob Trefethen
insert into donations(donor, donee, amount, fraction, donation_date, donation_date_precision, donation_date_basis, cause_area, url, notes) values
  ('Jacob Trefethen','Environmental Data and Governance Initiative',NULL,1.0,'2017-01-16','day','date of donation announcement','Environmentalism/watchdog','http://effective-altruism.com/ea/16b/why_i_donated_to_the_environmental_data/','Donation made to small nonprofit based on inside information and close contact with the organization, making it easier to evaluate');

insert into donations(donor, donee, amount, fraction, donation_date, donation_date_precision, donation_date_basis, cause_area, url, notes, special_donation_reason) values
  ('Joshua Zelinsky','Internet Archive',20.0,NULL,'2011-08-21','day','date of donation announced in announcement','Digital preservation','https://www.lesswrong.com/posts/eD6TZm2r25HzYzZzY/spaced-repetition-literature-review-prize-and-the-winner-is#RydGTnYufdjxzvDKW','Charity chosen by Gwern Branwen, who won the spaced repetition literature review prize.','Prize to charity of choice');

# -- The Oxford Prioritisation Project grant
insert into donations(donor, donee, amount, fraction, donation_date, donation_date_precision, donation_date_basis, cause_area, url, payment_modality, match_eligible, goal_amount, influencer, employer_match, matching_employer, amount_original_currency, original_currency, currency_conversion_date, currency_conversion_basis, donation_announcement_date, donation_announcement_date_precision, donation_announcement_url, donation_process, intended_use_of_funds_category, intended_use_of_funds, intended_funding_timeframe_in_months, donor_donee_reason, donor_amount_reason, donor_timing_reason, donor_next_donation_thoughts, donor_retrospective, notes) values
  ('Oxford Prioritisation Project', '80,000 Hours', 12934, NULL, '2017-05-09', 'day', 'date of donation announcement', 'Effective altruism/movement growth', 'https://oxpr.io/blog/2017/5/20/four-quantiative-models-aggregation-and-final-decision', NULL, NULL, NULL, NULL, NULL, NULL, 10000, 'GBP', '2017-05-09', 'Bloomberg', '2017-05-09', 'day', 'https://www.facebook.com/events/336092186805365/',
  /* donation_process */ 'The donation is the outcome of the Oxford Prioritisation Project, a months-long group project that looks at a number of donation targets to find the best one. The donation amount of 10,000 GBP was pre-determined. 80,000 Hours is the ultimate winner and gets the entire amount',
  /* intended_use_of_funds_category */ 'Organizational general support',
  /* intended_use_of_funds */ NULL,
  /* intended_funding_timeframe_in_months */ NULL,
  /* donor_donee_reason */ 'The selection of 80,000 Hours as the target for the donation is a result of a lengthy process of deliberation and comparison. The final stage of comparison includes four charities: 80,000 Hours, Machine Intelligence Research Institute, StrongMinds, and Animal Charity Evaluators. The final comparison is carried out though a quantitative analysis summarized at https://oxpr.io/blog/2017/5/20/expected-value-estimates-we-cautiously-took-literally The post describing the model for 80,000 Hours is at https://oxpr.io/blog/2017/5/13/a-model-of-80000-hours',
  /* donor_amount_reason */ 'Amount (of 10,0000 GBP) determined at the outset of the Oxford Prioritisation Project, as the donation amount that the project seeks to allocate',
  /* donor_timing_reason */ 'Timing determined by the end of the time period for the Oxford Prioritisation Project',
  /* donor_next_donation_thoughts */ NULL,
  /* donor_retrospective */ 'See https://forum.effectivealtruism.org/posts/JfDW9LfcMFGXhLxTC/a-model-of-80-000-hours-oxford-prioritisation-project for a retrospective on the Oxford Prioritisation Project. 80,000 Hours is mentioned only once in the retrospective: "We would guess that the real costs of the £10,000 grant were low. At the outset, the probability was quite high that the money would eventually be granted to a high-impact organisation, with a cost-effectiveness not several times smaller than CEA’s counterfactual use of the money3. In fact, the grant was given to 80,000 Hours."',
  /* notes */ NULL);

# -- Also includes GiveWell and Open Phil donors who have only one year of donation information

# -- Christian Smith
insert into donations(donor, donee, amount, fraction, donation_date, donation_date_precision, donation_date_basis, cause_area, url, notes, influencer) values
  ('Christian Smith','GiveWell Maximum Impact Fund',NULL,1.0,'2017-12-11','day','date of donation announcement','Global health and cash transfers','https://blog.givewell.org/2017/12/11/staff-members-personal-donations-for-giving-season-2017/#Christian','Donor decided to grant to GiveWell for regranting, and believes more strongly in the research process of GiveWell and the importance of the funding gaps. Donor also considered animal welfare and the far future, but ultimately decided to focus on supporting causes in global health and development','GiveWell');

# -- Michael Levine
insert into donations(donor, donee, amount, fraction, donation_date, donation_date_precision, donation_date_basis, cause_area, url, notes, influencer) values
  ('Michael Levine','Against Malaria Foundation',NULL,0.7,'2017-12-18','day','date of donation announcement','Global health/malaria','https://www.openphilanthropy.org/blog/staff-members-personal-donations-giving-season-2017#Mike','Donation of 70% to Against Malaria Foundation, consistent with the GiveWell recommendation for people who want to directly donate to GiveWell Maximum Impact Fund (70% to Against Malaria Foundation, 30% to Schistosomiasis Control Initiative)','GiveWell'),
  ('Michael Levine','GiveDirectly',NULL,0.3,'2017-12-18','day','date of donation announcement','Cash transfers','https://www.openphilanthropy.org/blog/staff-members-personal-donations-giving-season-2017#Mike','Donation of 30% to GiveDirectly, which deviates from the GiveWell recommendation for people who want to directly donate to GiveWell Maximum Impact Fund (70% to Against Malaria Foundation, 30% to Schistosomiasis Control Initiative) because, as donor states: "I see value in having direct cash transfers serve as a benchmark for other interventions, and in part because I want to signal my excitement about GiveDirectly’s new universal basic income project, even if my contribution will not meaningfully advance that specific work."','GiveWell');

insert into donations(donor, donee, amount, fraction, donation_date, donation_date_precision, donation_date_basis, cause_area, url, notes, influencer) values
  ('Anonymous', 'AI Impacts', 39000, NULL, '2018-07-05', 'day', 'date of donation announcement', 'AI safety', 'https://aiimpacts.org/occasional-update-july-5-2018/', 'To support several projects from AI Impacts’s list of promising research projects https://aiimpacts.org/promising-research-projects/', NULL);

insert into donations(donor, donee, amount, fraction, donation_date, donation_date_precision, donation_date_basis, cause_area, url, notes, influencer) values
  ('Eric Rogstad', 'Lightcone Infrastructure', 10000, NULL, '2017-09-14', 'day', 'date of donation announcement', 'Rationality improvement', 'https://www.lesswrong.com/posts/rEHLk9nC5TtrNoAKT/lw-2-0-strategic-overview', NULL, NULL);
