insert into donations(donor, donee, amount, fraction, donation_date, donation_date_precision, donation_date_basis,
    cause_area, url, notes, payment_modality, match_eligible, goal_amount, influencer, employer_match, matching_employer)
    values
    ('Michael Dickens', 'The Humane League', 500.00, NULL, '2014-05-01', 'month', 'donation log', NULL, 'http://mdickens.me/donations/', 'Donated as part of Stanford EA consensus', NULL, NULL, NULL, 'Stanford EA', NULL, NULL),
    ('Michael Dickens', 'Animal Charity Evaluators', 3000.00, NULL, '2015-05-01', 'month', 'donation log', 'Animal welfare/factory farming/meta/charity evaluator', 'http://mdickens.me/donations/', 'Part of a collective donation by Stanford EA; Dickens had a preference for THL but deferred to group consensus', NULL, NULL, NULL, 'Stanford EA', NULL, NULL),
    ('Michael Dickens', 'Raising for Effective Giving', 20000.00, NULL, '2015-10-01', 'month', 'donation log', 'Effective altruism/meta/fundraising', 'http://mdickens.me/donations/', 'See http://effective-altruism.com/ea/ns/my_cause_selection_michael_dickens/ for the full reasoning; also mirrored at http://mdickens.me/2015/09/15/my_cause_selection/', NULL, NULL, NULL, NULL, NULL, NULL),
    ('Michael Dickens','The Good Food Institute',26400,1.0,'2017-02-01','month','donation log','Animal welfare/meat alternatives','http://mdickens.me/donations/','See http://mdickens.me/2016/10/31/where_i_am_donating_in_2016/ for a full explanation of the reasons for donation. Note that the donation was for 2016 but was made in 2017 for personal finance and tax reasons',NULL,NULL,26400,NULL,20000,'Affirm Inc'),
    ('Michael Dickens', 'The Humane League', 20.00, NULL, '2015-11-01', 'month', 'donation log', NULL, 'http://mdickens.me/donations/small.html', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
    ('Michael Dickens', 'Raising for Effective Giving', 20.00, NULL, '2015-12-01', 'month', 'donation log', 'Effective altruism/meta/fundraising', 'http://mdickens.me/donations/small.html', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
    ('Michael Dickens', 'Machine Intelligence Research Institute', 20.00, NULL, '2016-01-01', 'month', 'donation log', NULL, 'http://mdickens.me/donations/small.html', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
    ('Michael Dickens', 'Animal Equality', 10.00, NULL, '2016-03-01', 'month', 'donation log', NULL, 'http://mdickens.me/donations/small.html', NULL, NULL, NULL, NULL, NULL, NULL, NULL);