# -- Josh Rosenberg donations
insert into donations(donor, donee, amount, fraction, donation_date,
    donation_date_precision, donation_date_basis, cause_area, url, notes,
    payment_modality, match_eligible, goal_amount, influencer, employer_match,
    matching_employer) values 
    ('Josh Rosenberg','GiveDirectly',NULL,1.0,'2013-12-12','day','date of donation announcement','Cash transfers','http://blog.givewell.org/2013/12/12/staff-members-personal-donations/','Split donation in half, one half for giving now and the other half for giving next year at the latest. The half to give now went entirely to GiveDirectly',NULL,NULL,NULL,'GiveWell',NULL,NULL),
    ('Josh Rosenberg','GiveWell top charities',NULL,1.0,'2014-12-17','day','date of donation announcement','Global health and cash transfers','http://blog.givewell.org/2014/12/17/staff-members-personal-donations-giving-season-2014/','More convinced of GiveWell allocation recommendation, so following that',NULL,NULL,NULL,'GiveWell',NULL,NULL),
    ('Josh Rosenberg','Against Malaria Foundation',NULL,0.8,'2015-12-09','day','date of donation announcement','Global health/malaria','http://blog.givewell.org/2015/12/09/staff-members-personal-donations-for-giving-season-2015/','More confidence in cost-effectiveness model and in GiveWell recommendation to donate almost all to AMF. 10% for other causes for other reasons',NULL,NULL,NULL,'GiveWell',NULL,NULL),
    ('Josh Rosenberg','GiveDirectly',NULL,0.1,'2015-12-09','day','date of donation announcement','Cash transfers','http://blog.givewell.org/2015/12/09/staff-members-personal-donations-for-giving-season-2015/','Large potential upside, reward to GiveDirectly for being an outstanding organization, and funds directly to individuals to spend for themselves',NULL,NULL,NULL,'GiveWell',NULL,NULL),
    ('Josh Rosenberg','A political campaign',NULL,0.3,'2016-12-09','day','date of donation announcement','Politics/United States','http://blog.givewell.org/2016/12/09/staff-members-personal-donations-giving-season-2016/','Details of political campaign not specified, but 2016 is a presidential election year in the United States',NULL,NULL,NULL,NULL,NULL,NULL),
    ('Josh Rosenberg','GiveWell top charities',NULL,0.65,'2016-12-09','day','date of donation announcement','Global health and cash transfers','http://blog.givewell.org/2016/12/09/staff-members-personal-donations-giving-season-2016/','Believed in collective wisdom of GiveWell. Rather than dissent by donating elsewhere, considered it more productive to raise issues in debate and have combined wisdom of fellow staffers',NULL,NULL,NULL,'GiveWell',NULL,NULL);