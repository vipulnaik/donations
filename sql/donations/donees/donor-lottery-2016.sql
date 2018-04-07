# -- Donations *to* the 2016 donor lottery (Paul Christiano and Carl Shulman)

insert into donations(donor, donee, amount, fraction, donation_date, donation_date_precision, donation_date_basis, cause_area, url, notes) values
  ('Timothy Telleen-Lawton', 'Donor lottery', 5000.00, NULL, '2016-12-07', 'day', 'transaction', NULL, 'http://effective-altruism.com/ea/14d/donor_lotteries_a_stepbystep_guide_for_mall/', 'Reasoning explained more in https://blog.givewell.org/2016/12/09/staff-members-personal-donations-giving-season-2016/ (go to section for Timothy Telleen-Lawton)'),
  ('Gregory Lewis', 'Donor lottery', 5000.00, NULL, '2016-12-07', 'day', 'transaction', NULL, 'http://effective-altruism.com/ea/14d/donor_lotteries_a_stepbystep_guide_for_mall/', NULL),
  ('Rohin Shah', 'Donor lottery', 2800.00, NULL, '2016-12-07', 'day', 'transaction', NULL, 'http://effective-altruism.com/ea/14d/donor_lotteries_a_stepbystep_guide_for_mall/', NULL),
  ('Helen Toner', 'Donor lottery', 2500.00, 1.0, '2016-12-07', 'day', 'transaction', NULL, 'http://effective-altruism.com/ea/14d/donor_lotteries_a_stepbystep_guide_for_mall/', 'Reasoning explained more in https://blog.givewell.org/2016/12/09/staff-members-personal-donations-giving-season-2016/ (go to section for Helen Toner)'),
  ('Nicole Ross', 'Donor lottery', 500.00, NULL, '2016-12-07', 'day', 'transaction', NULL, 'http://effective-altruism.com/ea/14d/donor_lotteries_a_stepbystep_guide_for_mall/', NULL),
  ('Howie Lempel', 'Donor lottery', 5000.00, NULL, '2016-12-07', 'day', 'transaction', NULL, 'http://effective-altruism.com/ea/14d/donor_lotteries_a_stepbystep_guide_for_mall/', NULL),
  ('Rebecca Raible', 'Donor lottery', 2000.00, NULL, '2016-12-12', 'day', 'transaction', NULL, 'http://effective-altruism.com/ea/14d/donor_lotteries_a_stepbystep_guide_for_mall/', NULL),
  ('Brayden McLean', 'Donor lottery', 5000.00, NULL, '2016-12-24', 'day', 'transaction', NULL, 'http://effective-altruism.com/ea/14d/donor_lotteries_a_stepbystep_guide_for_mall/', NULL),
  ('Benjamin Hoffman', 'Donor lottery', 100.00, NULL, '2016-12-24','day', 'transaction',  NULL, 'http://effective-altruism.com/ea/14d/donor_lotteries_a_stepbystep_guide_for_mall/', NULL),
  ('Catherine Olsson', 'Donor lottery', 500.00, NULL, '2016-12-26','day', 'transaction',  NULL, 'http://effective-altruism.com/ea/14d/donor_lotteries_a_stepbystep_guide_for_mall/', NULL),
  ('Eric Herboso', 'Donor lottery', 500.00, NULL, '2016-12-31','day', 'transaction',  NULL, 'http://effective-altruism.com/ea/14d/donor_lotteries_a_stepbystep_guide_for_mall/', NULL),
  ('Ian David Moss', 'Donor lottery', 2500.00, NULL, '2016-12-31','day', 'transaction',  NULL, 'http://effective-altruism.com/ea/14d/donor_lotteries_a_stepbystep_guide_for_mall/', NULL),
  ('Glenn Willen', 'Donor lottery', 500.00, NULL, '2017-01-02','day', 'transaction',  NULL, 'http://effective-altruism.com/ea/14d/donor_lotteries_a_stepbystep_guide_for_mall/', NULL),
  ('Brandon Reinhart', 'Donor lottery', 5000.00, NULL, '2017-01-08','day', 'transaction',  NULL, 'http://effective-altruism.com/ea/14d/donor_lotteries_a_stepbystep_guide_for_mall/', NULL);

# -- Donations *from* the 2016 donor lottery

insert into donations(donor, donee, amount, fraction, donation_date, donation_date_precision, donation_date_basis, cause_area, url, notes, influencer) values
  ('Donor lottery','Effective Altruism Prague',21000,0.46,'2017-12-20','day','date of donation announcement','Effective altruism/movement growth','http://effective-altruism.com/ea/166/donor_lottery_details/cwv?context=1#cwv','Donation not yet made at the time of announcement, but decided upon. Donation to this EA chapter because Telleen-Lawton was impressed with their ability to execute difficult projects, and believes they could make a large positive impact', 'Timothy Telleen-Lawton');

