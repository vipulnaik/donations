create table donors (
    donor_id int(11) not null auto_increment primary key,
    donor varchar(100) not null,
    donor_type enum('Individual','Couple','Donor group','Subsidiary','Private foundation') default 'Individual',
    country varchar(40) not null, # -- Country of current residence, NOT country of origin
    affiliated_orgs varchar(1000), # -- All current and former employers, plus orgs they are board members or advisors for, but restricting to orgs that are either potential donees or other nonprofits with significant footprint in the associated communities
    bay_area boolean, # -- Whether the person currently lives in the San Francisco Bay Area
    facebook_username varchar(100),
    linkedin_username varchar(100),
    website varchar(100),
    donations_url varchar(1000),
    income int(12),
    notes varchar(2000) default null,
    twitter_username varchar(40),
    lesswrong_username varchar(40),
    eaf_username varchar(40),
    eahub_username varchar(40),
    gratipay_username varchar(40),
    patreon_username varchar(40),
    predictionbook_username varchar(40),
    github_username varchar(40),
    unique key donor(`donor`)
) ENGINE=InnoDB AUTO_INCREMENT=15239276 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

insert into donors(donor, donor_type, country, facebook_username, website, donations_url, lesswrong_username, linkedin_username,affiliated_orgs,eaf_username, eahub_username,github_username,twitter_username) values
  ('Laura and John Arnold Foundation','Private foundation','United States','Laura-and-John-Arnold-Foundation-177757582300684','http://www.arnoldfoundation.org/','http://www.arnoldfoundation.org/grants/',NULL,NULL,NULL,NULL,NULL,NULL,'lja_foundation'),
  ('Open Philanthropy Project','Private foundation','United States','openphilanthropy','http://www.openphilanthropy.org/','http://www.openphilanthropy.org/giving/grants',NULL,NULL,'GiveWell,Good Ventures',NULL,NULL,NULL,'open_phil'),
  ('GiveWell Incubation Grants','Subsidiary','United States',NULL,'http://www.givewell.org/research/incubation-grants','http://www.givewell.org/research/incubation-grants',NULL,NULL,'GiveWell,Good Ventures',NULL,NULL,NULL,NULL),
  ('Good Ventures/GiveWell top and standout charities','Subsidiary','United States',NULL,NULL,NULL,NULL,NULL,'GiveWell,Good Ventures,Open Philanthropy Project',NULL,NULL,NULL,NULL),
  ('Good Ventures/not recommended by GiveWell or Open Philanthropy Project','Subsidiary','United States',NULL,NULL,NULL,NULL,NULL,'Good Ventures',NULL,NULL,NULL,NULL),
  ('GiveWell discretionary regranting','Subsidiary','United States',NULL,NULL,NULL,NULL,NULL,'GiveWell',NULL,NULL,NULL,NULL),
  ('Effective Altruism Funds','Subsidiary','United Kingdom',NULL,'https://app.effectivealtruism.org/','http://effective-altruism.com/ea/19d/update_on_effective_altruism_funds/',NULL,NULL,'Centre for Effective Altruism',NULL,NULL,NULL,NULL);

insert into donors(donor, donor_type, country, facebook_username, website, donations_url, lesswrong_username, linkedin_username,affiliated_orgs,eaf_username, eahub_username,github_username,twitter_username) values
    ('Jeff Kaufman and Julia Wise', 'Couple', 'United States', 'jefftk', 'http://www.jefftk.com/', 'http://www.jefftk.com/donations', 'jkaufman','jeff-kaufman-28a8bab','Centre for Effective Altruism','Jeff_Kaufman','jeff-kaufman','jeffkaufman',NULL);

insert into donors(donor, country, facebook_username, website, donations_url, lesswrong_username, linkedin_username,affiliated_orgs,eaf_username, eahub_username,github_username,twitter_username) values
    ('Aaron Gertler', 'United States', 'aaron.gertler', 'http://aarongertler.net/', 'http://aarongertler.net/donations/','aarongertler','aarongertler',NULL,'aarongertler','aaron-gertler','aarongertler','aarongertler'),
    ('Ajeya Cotra', 'United States', 'https://www.facebook.com/profile.php?id=1638572396','https://ajeyac.wordpress.com', 'no single location; https://eahub.org/user/ajeya-cotra, http://blog.givewell.org/2016/12/09/staff-members-personal-donations-giving-season-2016/, http://effective-altruism.com/ea/14d/donor_lotteries_a_stepbystep_guide_for_mall/',NULL,'ajeya-cotra-90942b8b','Open Philanthropy Project',NULL,'ajeya-cotra',NULL,NULL),
    ('Ben Kuhn', 'United States', 'ben.s.kuhn', 'http://www.benkuhn.net/', 'http://www.benkuhn.net/ea/','benkuhn', 'benskuhn',NULL,NULL,'ben-kuhn','benkuhn','benskuhn'),
    ('Benjamin Hoffman', 'United States', 'benjamin.r.hoffman', 'http://benjaminrosshoffman.com/', NULL,'Benquo','benjaminrhoffman','GiveWell','BenHoffman','ben-hoffman',NULL, NULL),
    ('Brayden McLean', 'United States', 'brayden.mclean', 'http://brayden.strikingly.com/',NULL,'BraydenM','braydenmclean',NULL,NULL,'brayden-mclean','braydenm','brayden_mclean'),
    ('Catherine Olsson', 'United States', 'catherio', NULL, NULL,'catherio','catherineolsson','OpenAI',NULL,NULL,'catherio','catherineols'),
    ('Eric Herboso', 'United States', 'EricHerboso','http://www.ericherboso.org', NULL,'EricHerboso','ericherboso','Animal Charity Evaluators','EricHerboso','eric-herboso',NULL,'ericherboso'),
    ('Glenn Willen', 'United States', 'gwillen', NULL, NULL,'gwillen', NULL,NULL,'gwillen',NULL,'gwillen',NULL),
    ('Gregory Lewis', 'United Kingdom', 'gjlewis37', NULL, NULL,NULL,'gregoryjlewis','Giving What We Can','Gregory_Lewis','gregory-lewis',NULL,NULL),
    ('Helen Toner', 'United States', 'helen.toner', NULL, NULL, NULL,'helen-toner-4162439a','Open Philanthropy Project','HelenToner','helen-toner',NULL,'hlntnr'),
    ('Howie Lempel', 'United States', 'hlempel', NULL, NULL, NULL,'howie-lempel-201a6378','Open Philanthropy Project',NULL,NULL,NULL,'howielempel'),
    ('Ian David Moss', 'United States', 'iandavidmoss', NULL, NULL, NULL,'mossinator',NULL,NULL,'david-moss',NULL,NULL),
    ('Jacob Steinhardt', 'United States', 'jacob.steinhardt', NULL, NULL, 'jsteinhardt','jacob-steinhardt-a30437bb',NULL,'jsteinhardt',NULL,'jsteinha','jacobsteinhardt'),
    ('Michael Dickens', 'United States', 'michael.j.dickens', 'http://mdickens.me/', 'http://mdickens.me/donations/', 'MTGandP','michael-dickens-a4173255',NULL, 'MichaelDickens','michael-dickens','michaeldickens',NULL),
    ('Nicole Ross', 'United States', 'nicolejamesross', NULL, NULL, NULL,'nicole-ross-184a6142','GiveWell,Open Philanthropy Project', NULL, NULL, NULL, NULL),
    ('Pablo Stafforini', 'United Kingdom', 'stafforini', 'http://www.stafforini.com', 'http://www.stafforini.com/blog/donations/', NULL,'stafforini','Centre for Effective Altruism,80,000 Hours',NULL,'pablo-stafforini', NULL,'stafforini'),
    ('Peter Hurford', 'United States', 'peterhurford', 'http://peterhurford.com/', 'http://peterhurford.com/other/donations.html','peter_hurford','peterhurford8','.impact,Animal Charity Evaluators,Charity Science Health','Peter_Hurford','peter-hurford','peterhurford','peterhurford'),
    ('Rebecca Raible', 'United States', 'rebecca.paobur.raible', NULL, NULL, NULL,'rebeccaraible','GiveWell','rebecca_raible','rebecca-raible',NULL,'RebeccaRaible'),
    ('Rohin Shah', 'United States', 'rohinmshah', 'http://rohinshah.com/', NULL, NULL,'rohin-shah-76405832',NULL,'rohinmshah','rohin-shah','rohinmshah', NULL), 
    ('Timothy Telleen-Lawton', 'United States', 'TimTL', NULL, NULL, NULL,'timothytl','GiveWell',NULL,'timothy-telleen-lawton',NULL,'timtl'),
    ('Brian Tomasik','United States','brian.tomasik','http://briantomasik.com/','http://reducing-suffering.org/my-donations-past-and-present/',NULL,'briantomasik','Foundational Research Institute',NULL,'brian-tomasik','Brian-Tomasik','reducesuffering'),
    ('Patrick Brinich-Langlois','United States','pbrinichlanglois','http://www.patbl.com/','http://www.patbl.com/misc/other/donations/',NULL,'patbl',NULL,NULL,'patrick-brinich-langlois','patbl','notnotpat'),
    ('Ozy Brennan','United States','https://www.facebook.com/profile.php?id=100007139566626','https://thingofthings.wordpress.com/','https://thingofthings.wordpress.com/2016/12/22/donations-post-2016/',NULL,'ozy-brennan-1b86b3b2','Foundational Research Institute',NULL,NULL,'ozybrennan',NULL),
    ('Elizabeth Van Nostrand','United States','li.van.nostrand','http://acesounderglass.com/','Multiple posts: https://acesounderglass.com/2016/12/01/5167/,https://acesounderglass.com/2015/12/31/2015-donations/,https://acesounderglass.com/2014/12/29/how-to-figure-out-how-much-to-donate/',NULL,'elizabethvannostrand',NULL,'Elizabeth','elizabeth-van-nostrand','AcesoUnderGlass','AcesoUnderGlass'),
    ('Neil Sinhababu','Singapore','neilsinhababu','http://www.neilsinhababu.com/','http://neilsinhababu.blogspot.com/2016/12/2016-utilitarian-financial-activity.html',NULL,'neil-sinhababu-21a7a3b',NULL,NULL,'neil-sinhababu',NULL,'neilsinhababu'),
    ('Blake Borgeson','United States','blakeborgeson','http://www.blakeb.org/',NULL,NULL,'blakeborgeson',NULL,NULL,'blakeborgeson','blakeweb','blakeweb'),
    ('Eric Friedman','United States','friedman.eric','http://reinventingphilanthropy.com/',NULL,NULL,'ericfriedman',NULL,NULL,'eric-friedman',NULL,NULL),
    ('Haseeb Qureshi','United States','someguynamedhaseeb','http://haseebq.com/',NULL,NULL,'imhaseeb',NULL,NULL,'haseeb-qureshi','Haseeb-Qureshi','hosseeb'),
    ('Jacob Trefethen','United States','jacob.trefethen','https://jacobtrefethen.com/',NULL,NULL,'jacob-trefethen-82105350',NULL,'JacobTref',NULL,'jacobtref','JacobTref'),
    ('Ben Hoskin','United States','ben.944',NULL,NULL,'Larks','ben-hoskin-024b9021','Machine Intelligence Research Institute,Giving What We Can','Larks',NULL,NULL,NULL),
    ('Eva Vivalt','United States','eva.vivalt','http://evavivalt.com/',NULL,NULL,'eva-vivalt-a1579b54','AidGrade',NULL,'eva-vivalt',NULL,'evavivalt'),
    ('Holden Karnofsky','United States','holden.karnofsky','https://medium.com/@holden0',NULL,'HoldenKarnofsky','holden-karnofsky-75970b7','GiveWell,Open Philanthropy Project','HoldenKarnofsky',NULL,NULL,'holdenkarnofsky'),
    ('Elie Hassenfeld','United States','elie.hassenfeld',NULL,NULL,NULL,'elie-hassenfeld-92072a9','GiveWell,Open Philanthropy Project',NULL,NULL,NULL,'eliehassenfeld'),
    ('Alexander Berger','United States','alexander.is','http://marginalchange.blogspot.com/',NULL,NULL,'alexander-berger-58906098','GiveWell,Open Philanthropy Project',NULL,NULL,NULL,'albrgr'),
    ('Josh Rosenberg','United States','jhrosenberg',NULL,NULL,NULL,'josh-rosenberg-07590626','GiveWell,Open Philanthropy Project',NULL,NULL,NULL,NULL),
    ('Sophie Monahan','United States','sophical',NULL,NULL,NULL,'sophie-monahan-8160a9a2','GiveWell,Open Philanthropy Project',NULL,NULL,NULL,NULL);

# -- insert into donors(donor, country, facebook_username, website, donations_url, lesswrong_username, linkedin_username,affiliated_orgs,eaf_username, eahub_username,github_username,twitter_username) values

insert into donors(donor, country, facebook_username, website, donations_url, income, notes, twitter_username,lesswrong_username,eaf_username,eahub_username,gratipay_username,patreon_username,predictionbook_username,github_username) values

    ('Vipul Naik', 'United States', 'vipulnaik.r', 'https://vipulnaik.com/',
        'https://vipulnaik.com/donation-history/', 90000, 'Disclosure: creator of the site', 'vipulnaik_r',
        'VipulNaik', 'vipulnaik', 'vipul-naik', NULL, NULL, 'vipulnaik', 'vipulnaik');

