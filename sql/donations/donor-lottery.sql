# -- Donations *to* the 2016 donor lottery (Paul Christiano and Carl Shulman)

insert into donations(donor, donee, amount, fraction, donation_date, donation_date_precision, donation_date_basis, cause_area, url, notes) values
  ('Timothy Telleen-Lawton', 'Donor lottery', 5000.00, NULL, '2016-12-07', 'day', 'transaction', NULL, 'http://effective-altruism.com/ea/14d/donor_lotteries_a_stepbystep_guide_for_mall/', 'Reasoning explained more in https://blog.givewell.org/2016/12/09/staff-members-personal-donations-giving-season-2016/ (go to section for Timothy Telleen-Lawton)'),
  ('Gregory Lewis', 'Donor lottery', 5000.00, NULL, '2016-12-07', 'day', 'transaction', NULL, 'http://effective-altruism.com/ea/14d/donor_lotteries_a_stepbystep_guide_for_mall/'),
  ('Rohin Shah', 'Donor lottery', 2800.00, NULL, '2016-12-07', 'day', 'transaction', NULL, 'http://effective-altruism.com/ea/14d/donor_lotteries_a_stepbystep_guide_for_mall/'),
  ('Helen Toner', 'Donor lottery', 2500.00, 1.0, '2016-12-07', 'day', 'transaction', NULL, 'http://effective-altruism.com/ea/14d/donor_lotteries_a_stepbystep_guide_for_mall/', 'Reasoning explained more in https://blog.givewell.org/2016/12/09/staff-members-personal-donations-giving-season-2016/ (go to section for Helen Toner)'),
  ('Nicole Ross', 'Donor lottery', 500.00, NULL, '2016-12-07', 'day', 'transaction', NULL, 'http://effective-altruism.com/ea/14d/donor_lotteries_a_stepbystep_guide_for_mall/'),
  ('Howie Lempel', 'Donor lottery', 5000.00, NULL, '2016-12-07', 'day', 'transaction', NULL, 'http://effective-altruism.com/ea/14d/donor_lotteries_a_stepbystep_guide_for_mall/'),
  ('Rebecca Raible', 'Donor lottery', 2000.00, NULL, '2016-12-12', 'day', 'transaction', NULL, 'http://effective-altruism.com/ea/14d/donor_lotteries_a_stepbystep_guide_for_mall/'),
  ('Brayden McLean', 'Donor lottery', 5000.00, NULL, '2016-12-24', 'day', 'transaction', NULL, 'http://effective-altruism.com/ea/14d/donor_lotteries_a_stepbystep_guide_for_mall/'),
  ('Benjamin Hoffman', 'Donor lottery', 100.00, NULL, '2016-12-24','day', 'transaction',  NULL, 'http://effective-altruism.com/ea/14d/donor_lotteries_a_stepbystep_guide_for_mall/'),
  ('Catherine Olsson', 'Donor lottery', 500.00, NULL, '2016-12-26','day', 'transaction',  NULL, 'http://effective-altruism.com/ea/14d/donor_lotteries_a_stepbystep_guide_for_mall/'),
  ('Eric Herboso', 'Donor lottery', 500.00, NULL, '2016-12-31','day', 'transaction',  NULL, 'http://effective-altruism.com/ea/14d/donor_lotteries_a_stepbystep_guide_for_mall/'),
  ('Ian David Moss', 'Donor lottery', 2500.00, NULL, '2016-12-31','day', 'transaction',  NULL, 'http://effective-altruism.com/ea/14d/donor_lotteries_a_stepbystep_guide_for_mall/'),
  ('Glenn Willen', 'Donor lottery', 500.00, NULL, '2017-01-02','day', 'transaction',  NULL, 'http://effective-altruism.com/ea/14d/donor_lotteries_a_stepbystep_guide_for_mall/'),
  ('Brandon Reinhart', 'Donor lottery', 5000.00, NULL, '2017-01-08','day', 'transaction',  NULL, 'http://effective-altruism.com/ea/14d/donor_lotteries_a_stepbystep_guide_for_mall/');

# -- Donations *from* the 2016 donor lottery

insert into donations(donor, donee, amount, fraction, donation_date, donation_date_precision, donation_date_basis, cause_area, url, notes, influencer) values
  ('Donor lottery','Effective Altruism Prague',21000,0.46,'2017-12-20','day','date of donation announcement','Effective altruism/movement growth','http://effective-altruism.com/ea/166/donor_lottery_details/cwv?context=1#cwv','Donation not yet made at the time of announcement, but decided upon. Donation to this EA chapter because Telleen-Lawton was impressed with their ability to execute difficult projects, and believes they could make a large positive impact', 'Timothy Telleen-Lawton');

# -- 2017 donor lottery (coordinated by CEA)

insert into donations(donor, donee, amount, donation_date, donation_date_precision, donation_date_basis, url, notes)
  values
  ('Paul Christiano', 'Donor lottery', 97.50, '2017-12-16', 'day', 'transaction', 'https://app.effectivealtruism.org/lotteries/31553453298138','See https://app.effectivealtruism.org/lotteries for general background; see http://effective-altruism.com/ea/1ip/announcing_the_2017_donor_lottery/ for the blog post announcing this lottery'),
  ('JP Addison','Donor lottery',12000, '2017-12-16', 'day', 'transaction', 'https://app.effectivealtruism.org/lotteries/31553453298138','See https://app.effectivealtruism.org/lotteries for general background; see http://effective-altruism.com/ea/1ip/announcing_the_2017_donor_lottery/ for the blog post announcing this lottery'),
  ('Sam Deere','Donor lottery',195.30, '2017-12-16', 'day', 'transaction', 'https://app.effectivealtruism.org/lotteries/31553453298138','See https://app.effectivealtruism.org/lotteries for general background; see http://effective-altruism.com/ea/1ip/announcing_the_2017_donor_lottery/ for the blog post announcing this lottery'),
  ('Kevin Watkinson','Donor lottery',19.44,'2017-12-16', 'day', 'transaction','https://app.effectivealtruism.org/lotteries/31553453298138','See https://app.effectivealtruism.org/lotteries for general background; see http://effective-altruism.com/ea/1ip/announcing_the_2017_donor_lottery/ for the blog post announcing this lottery'),
  # -- Ajeya Cotra is covered in her own doc
  ('Eric Herboso','Donor lottery',19.26,'2017-12-16', 'day', 'transaction','https://app.effectivealtruism.org/lotteries/31553453298138','See https://app.effectivealtruism.org/lotteries for general background; see http://effective-altruism.com/ea/1ip/announcing_the_2017_donor_lottery/ for the blog post announcing this lottery'),
  ('Sören Mindermann','Donor lottery',2664.71,'2017-12-16', 'day', 'transaction','https://app.effectivealtruism.org/lotteries/31553453298138','See https://app.effectivealtruism.org/lotteries for general background; see http://effective-altruism.com/ea/1ip/announcing_the_2017_donor_lottery/ for the blog post announcing this lottery'),
  ('Rohin Shah','Donor lottery',10540,'2017-12-17','day', 'transaction','https://app.effectivealtruism.org/lotteries/31553453298138','See https://app.effectivealtruism.org/lotteries for general background; see http://effective-altruism.com/ea/1ip/announcing_the_2017_donor_lottery/ for the blog post announcing this lottery'),
  ('Robert Yaman','Donor lottery',97.50,'2017-12-18','day', 'transaction','https://app.effectivealtruism.org/lotteries/31553453298138','See https://app.effectivealtruism.org/lotteries for general background; see http://effective-altruism.com/ea/1ip/announcing_the_2017_donor_lottery/ for the blog post announcing this lottery'),
  ('Julio Banfi','Donor lottery',19.26,'2017-12-18','day', 'transaction','https://app.effectivealtruism.org/lotteries/31553453298138','See https://app.effectivealtruism.org/lotteries for general background; see http://effective-altruism.com/ea/1ip/announcing_the_2017_donor_lottery/ for the blog post announcing this lottery');
