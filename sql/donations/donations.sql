# -- Eva Vivalt
insert into donations(donor, donee, amount, fraction, donation_date, donation_date_precision, donation_date_basis, cause_area, url, notes) values
    ('Eva Vivalt','AidGrade',NULL,1.0,'2016-12-09','day','date of donation announcement','International aid/global health/global poverty/evaluation','http://effective-altruism.com/ea/14u/eas_write_about_where_they_give/','AidGrade was founded by Eva Vivalt. She describes the donation as "putting my money where my mouth is"');

# -- Jacob Trefethen
insert into donations(donor, donee, amount, fraction, donation_date, donation_date_precision, donation_date_basis, cause_area, url, notes) values
  ('Jacob Trefethen','Environmental Data and Governance Initiative',NULL,1.0,'2017-01-16','day','date of donation announcement','Environmentalism/watchdog','http://effective-altruism.com/ea/16b/why_i_donated_to_the_environmental_data/','Donation made to small nonprofit based on inside information and close contact with the organization, making it easier to evaluate');

# -- Catherine Hollander donations
insert into donations(donor, donee, amount, fraction, donation_date, donation_date_precision, donation_date_basis, cause_area, url, notes) values
  ('Catherine Hollander','Against Malaria Foundation',NULL,0.9,'2017-12-11','day','date of donation announcement','Global health/malaria','https://blog.givewell.org/2017/12/11/staff-members-personal-donations-for-giving-season-2017/#Catherine','Donation based on trust in the GiveWell process andi its recommendation of the AMF gap as the most important one to fill'),
  ('Catherine Hollander','No Lean Season',NULL,0.1,'2017-12-11','day','date of donation announcement','Cash transfers','https://blog.givewell.org/2017/12/11/staff-members-personal-donations-for-giving-season-2017/#Catherine','Like Sophie Monahan, the donor plans to support No Lean Season to increase the visibility of the new top charity, and based on being impressed with its work');

# -- Andrew Martin donations
insert into donations(donor, donee, amount, fraction, donation_date, donation_date_precision, donation_date_basis, cause_area, url, notes) values
  ('Andrew Martin','GiveWell top charities',NULL,1.0,'2017-12-11','day','date of donation announcement','Global health and cash transfers','https://blog.givewell.org/2017/12/11/staff-members-personal-donations-for-giving-season-2017/#Andrew','Donor decided to grant to GiveWell for regranting, rather than directly donating to top charities, because of his belief in the importance of the flexibility GiveWell gets to provide funding to whichever charities have the most pressing funding needs');

# -- Chelsea Tabart donations


# -- The Oxford Prioritisation Project grant
insert into donations(donor, donee, amount, fraction, donation_date,
    donation_date_precision, donation_date_basis, cause_area, url, notes,
    payment_modality, match_eligible, goal_amount, influencer, employer_match,
    matching_employer, amount_original_currency, original_currency,
    currency_conversion_date, currency_conversion_basis,
    donation_announcement_date, donation_announcement_date_precision,
    donation_announcement_url) values
    ('Oxford Prioritisation Project', '80000 Hours', 12934, NULL, '2017-05-09', 'day', 'date of donation announcement', 'Effective altruism/movement growth', 'https://oxpr.io/blog/2017/5/20/four-quantiative-models-aggregation-and-final-decision', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 10000, 'GBP', '2017-05-09', 'Bloomberg', '2017-05-09', 'day', 'https://www.facebook.com/events/336092186805365/');
