# -- Eva Vivalt
insert into donations(donor, donee, amount, fraction, donation_date, donation_date_precision, donation_date_basis, cause_area, url, notes) values
    ('Eva Vivalt','AidGrade',NULL,1.0,'2016-12-09','day','date of donation announcement','International aid/global health/global poverty/evaluation','http://effective-altruism.com/ea/14u/eas_write_about_where_they_give/','AidGrade was founded by Eva Vivalt. She describes the donation as "putting my money where my mouth is"');

# -- Jacob Trefethen
insert into donations(donor, donee, amount, fraction, donation_date, donation_date_precision, donation_date_basis, cause_area, url, notes) values
  ('Jacob Trefethen','Environmental Data and Governance Initiative',NULL,1.0,'2017-01-16','day','date of donation announcement','Environmentalism/watchdog','http://effective-altruism.com/ea/16b/why_i_donated_to_the_environmental_data/','Donation made to small nonprofit based on inside information and close contact with the organization, making it easier to evaluate');

# -- The Oxford Prioritisation Project grant
insert into donations(donor, donee, amount, fraction, donation_date,
    donation_date_precision, donation_date_basis, cause_area, url, notes,
    payment_modality, match_eligible, goal_amount, influencer, employer_match,
    matching_employer, amount_original_currency, original_currency,
    currency_conversion_date, currency_conversion_basis,
    donation_announcement_date, donation_announcement_date_precision,
    donation_announcement_url) values
    ('Oxford Prioritisation Project', '80000 Hours', 12934, NULL, '2017-05-09', 'day', 'date of donation announcement', 'Effective altruism/movement growth', 'https://oxpr.io/blog/2017/5/20/four-quantiative-models-aggregation-and-final-decision', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 10000, 'GBP', '2017-05-09', 'Bloomberg', '2017-05-09', 'day', 'https://www.facebook.com/events/336092186805365/');

# -- Also includes GiveWell and Open Phil donors who have only one year of donation information

# -- Michael Levine
insert into donations(donor, donee, amount, fraction, donation_date, donation_date_precision, donation_date_basis, cause_area, url, notes, influencer) values
  ('Michael Levine','Against Malaria Foundation',NULL,0.7,'2017-12-18','day','date of donation announcement','Global health/malaria','https://www.openphilanthropy.org/blog/staff-members-personal-donations-giving-season-2017#Mike','Donation of 70% to Against Malaria Foundation, consistent with the GiveWell recommendation for people who want to directly donate to GiveWell top charities (70% to Against Malaria Foundation, 30% to Schistosomiasis Control Initiative)','GiveWell'),
  ('Michael Levine','GiveDirectly',NULL,0.3,'2017-12-18','day','date of donation announcement','Global health/malaria','https://www.openphilanthropy.org/blog/staff-members-personal-donations-giving-season-2017#Mike','Donation of 30% to GiveDirectly, which deviates from the GiveWell recommendation for people who want to directly donate to GiveWell top charities (70% to Against Malaria Foundation, 30% to Schistosomiasis Control Initiative) because, as donor states: "I see value in having direct cash transfers serve as a benchmark for other interventions, and in part because I want to signal my excitement about GiveDirectly’s new universal basic income project, even if my contribution will not meaningfully advance that specific work."','GiveWell');
