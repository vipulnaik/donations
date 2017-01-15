create table donees (
    donee_id int(11) not null auto_increment primary key,
    donee varchar(100) not null,
    former_name varchar(100),
    country varchar(40) not null, # -- Country of main activity
    bay_area boolean, # -- Whether the person currently lives in the San Francisco Bay Area
    facebook_username varchar(100),
    website varchar(100),
    donate_page varchar(100),
    donor_list_page varchar(100),
    transparency_and_financials_page varchar(100),
    donation_case_page varchar(1000), # -- The most recent case(s) made for donations to the org
    donation_statistics_page varchar(1000),
    contact_email varchar(40),
    twitter_username varchar(40),
    eahub_username varchar(40),
    notes varchar(2000) default null,
    unique key donee(`donee`)
) ENGINE=InnoDB AUTO_INCREMENT=15239276 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

insert into donees(donee, former_name, country, bay_area, facebook_username, website, donate_page, donor_list_page, transparency_and_financials_page, donation_case_page, donation_statistics_page, twitter_username, eahub_username) values
  ('Machine Intelligence Research Institute','Singularity Institute for Artificial Intelligence','United States',true,'MachineIntelligenceResearchInstitute','https://intelligence.org','https://intelligence.org/donate/','https://intelligence.org/topdonors/','https://intelligence.org/transparency/','http://effective-altruism.com/ea/12n/miri_update_and_fundraising_case/',NULL,'MIRIBerkeley','miri'),
  ('Against Malaria Foundation',NULL,'United Kingdom',false,'AgainstMalaria','https://www.againstmalaria.com/','https://www.againstmalaria.com/Donation.aspx','https://www.againstmalaria.com/Donations.aspx','https://www.againstmalaria.com/Transparency.aspx',NULL,'https://www.againstmalaria.com/DonationStatistics.aspx','againstmalaria','against-malaria-foundation'),
  ('Centre for Effective Altruism',NULL,'United Kingdom',false,'CentreforEffectiveAltruism','https://www.centreforeffectivealtruism.org/','https://www.centreforeffectivealtruism.org/donate/',NULL,NULL,'https://www.centreforeffectivealtruism.org/fundraising/',NULL,NULL,'centre-effective-altruism'),
  ('EA Giving Group',NULL,'United States',true,NULL,'https://docs.google.com/spreadsheets/d/1H2hF3SaO0_QViYq2j1E7mwoz3sDjdf9pdtuBcrq7pRU/edit#gid=0','https://docs.google.com/forms/d/e/1FAIpQLScFYVJs3Inhmg50eGyENNg3CRvbfQ-L-KNJyywYtwl67dc56w/viewform',NULL,NULL,'blog.givewell.org/2016/12/09/staff-members-personal-donations-giving-season-2016/',NULL,NULL,NULL),
  ('GiveWell top charities',NULL,'United States',true,'GiveWell.org','http://www.givewell.org','https://secure.givewell.org/',NULL,NULL,'http://blog.givewell.org/2016/11/28/updated-top-charities-giving-season-2016/','http://www.givewell.org/about/impact', 'givewell','givewell'),
  ('GiveWell',NULL,'United States',true,'GiveWell.org','http://www.givewell.org','https://secure.givewell.org/support-givewell',NULL,'http://www.givewell.org/about/official-records','http://blog.givewell.org/2015/12/25/december-2015-update-on-givewells-funding-needs/',NULL, 'givewell','givewell');

