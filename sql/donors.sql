create table donors (
    donor_id int(11) not null auto_increment primary key,
    donor varchar(40) not null,
    country varchar(40) not null, # -- Country of current residence, NOT country of origin
    affiliated_orgs varchar(1000), # -- All current and former employers, plus orgs they are board members or advisors for, but restricting to orgs that are either potential donees or other nonprofits with significant footprint in the associated communities
    bay_area boolean, # -- Whether the person currently lives in the San Francisco Bay Area
    facebook_username varchar(100),
    linkedin_username varchar(100),
    website varchar(40),
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

insert into donors(donor, country, facebook_username, website, donations_url, lesswrong_username, linkedin_username,affiliated_orgs,eaf_username, eahub_username,github_username,twitter_username) values
    ('Aaron Gertler', 'United States', 'aaron.gertler', 'http://aarongertler.net/', 'http://aarongertler.net/donations/','aarongertler','aarongertler',NULL,'aarongertler','aaron-gertler','aarongertler','aarongertler'),
    ('Ajeya Cotra', 'United States', 'https://www.facebook.com/profile.php?id=1638572396','https://ajeyac.wordpress.com', 'no single location; https://eahub.org/user/ajeya-cotra, http://blog.givewell.org/2016/12/09/staff-members-personal-donations-giving-season-2016/, http://effective-altruism.com/ea/14d/donor_lotteries_a_stepbystep_guide_for_mall/',NULL,'ajeya-cotra-90942b8b','Open Philanthropy Project',NULL,'ajeya-cotra',NULL,NULL),
    ('Ben Kuhn', 'United States', 'ben.s.kuhn', 'http://www.benkuhn.net/', 'http://www.benkuhn.net/ea/','benkuhn', 'benskuhn',NULL,NULL,'ben-kuhn','benkuhn','benskuhn'),
    ('Benjamin Hoffman', 'United States', 'benjamin.r.hoffman', 'http://benjaminrosshoffman.com/', NULL,'Benquo','benjaminrhoffman','GiveWell','BenHoffman','ben-hoffman',NULL, NULL),
    ('Brayden McLean', 'United States', 'brayden.mclean', 'http://brayden.strikingly.com/',NULL,'BraydenM','braydenmclean',NULL,NULL,'brayden-mclean','braydenm','brayden_mclean'),
    ('Catherine Olsson', 'United States', 'catherio', NULL, NULL,NULL,'catherineolsson',NULL,NULL,NULL,'catherio','catherineols'),
    ('Eric Herboso', 'United States', 'EricHerboso','http://www.ericherboso.org', NULL,'EricHerboso','ericherboso','Animal Charity Evaluators','EricHerboso','eric-herboso',NULL,'ericherboso'),
    ('Glenn Willen', 'United States', 'gwillen', NULL, NULL,'gwillen', NULL,NULL,'gwillen',NULL,'gwillen',NULL),
    ('Gregory Lewis', 'United Kingdom', 'gjlewis37', NULL, NULL,NULL,'gregoryjlewis','Giving What We Can','Gregory_Lewis','gregory-lewis',NULL,NULL),
    ('Helen Toner', 'United States', 'helen.toner', NULL, NULL, NULL,'helen-toner-4162439a','Open Philanthropy Project','HelenToner','helen-toner',NULL,'hlntnr'),
    ('Howie Lempel', 'United States', 'hlempel', NULL, NULL, NULL,'howie-lempel-201a6378','Open Philanthropy Project',NULL,NULL,NULL,'howielempel'),
    ('Ian David Moss', 'United States', 'iandavidmoss', NULL, NULL, NULL,'mossinator',NULL,NULL,'david-moss',NULL,NULL),
    ('Jacob Steinhardt', 'United States', 'jacob.steinhardt', NULL, NULL, 'jsteinhardt','jacob-steinhardt-a30437bb',NULL,'jsteinhardt',NULL,'jsteinha','jacobsteinhardt'),
    ('Jeff Kaufman and Julia Wise', 'United States', 'jefftk', 'http://www.jefftk.com/', 'http://www.jefftk.com/donations', 'jkaufman','jeff-kaufman-28a8bab',NULL,'Jeff_Kaufman','jeff-kaufman','jeffkaufman',NULL),
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
    ('Elizabeth Van Nostrand','United States','li.van.nostrand','http://acesounderglass.com/','Multiple posts: https://acesounderglass.com/2016/12/01/5167/,https://acesounderglass.com/2015/12/31/2015-donations/,https://acesounderglass.com/2014/12/29/how-to-figure-out-how-much-to-donate/',NULL,'elizabethvannostrand',NULL,NULL,'elizabeth-van-nostrand','AcesoUnderGlass','AcesoUnderGlass'),
    ('Neil Sinhababu','Singapore','neilsinhababu','http://www.neilsinhababu.com/','http://neilsinhababu.blogspot.com/2016/12/2016-utilitarian-financial-activity.html',NULL,'neil-sinhababu-21a7a3b',NULL,NULL,'neil-sinhababu',NULL,'neilsinhababu');

# -- insert into donors(donor, country, facebook_username, website, donations_url, lesswrong_username, linkedin_username,affiliated_orgs,eaf_username, eahub_username,github_username,twitter_username) values

insert into donors(donor, country, facebook_username, website, donations_url, income, notes, twitter_username,lesswrong_username,eaf_username,eahub_username,gratipay_username,patreon_username,predictionbook_username,github_username) values

    ('Vipul Naik', 'United States', 'vipulnaik.r', 'https://vipulnaik.com/',
        'https://vipulnaik.com/donation-history/', 90000, 'Disclosure: creator of the site', 'vipulnaik_r',
        'VipulNaik', 'vipulnaik', 'vipul-naik', NULL, NULL, 'vipulnaik', 'vipulnaik');

