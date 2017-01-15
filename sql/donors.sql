create table donors (
    donor_id int(11) not null auto_increment primary key,
    donor varchar(40) not null,
    country varchar(40) not null, # -- Country of current residence, NOT country of origin
    employers varchar(1000), # -- All current and former employers, with censorship of employers not publicly disclosed. Any employer disclosed on LinkedIn is fair game. Internships don't count, short jobs unrelated to EA are ignored
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

# -- Not inserting bay_area ans employers columns by default
insert into donors(donor, country, facebook_username, website, donations_url, lesswrong_username, linkedin_username,employers) values
    ('Aaron Gertler', 'United States', 'aaron.gertler', 'http://aarongertler.net/', 'http://aarongertler.net/donations/','aarongertler','aarongertler',NULL),
    ('Ajeya Cotra', 'United States', NULL,'https://ajeyac.wordpress.com', 'no single location; https://eahub.org/user/ajeya-cotra, http://blog.givewell.org/2016/12/09/staff-members-personal-donations-giving-season-2016/, http://effective-altruism.com/ea/14d/donor_lotteries_a_stepbystep_guide_for_mall/',NULL,'ajeya-cotra-90942b8b',NULL),
    ('Ben Kuhn', 'United States', 'ben.s.kuhn', 'http://www.benkuhn.net/', 'http://www.benkuhn.net/ea/','benkuhn', 'benskuhn',NULL),
    ('Benjamin Hoffman', 'United States', 'benjamin.r.hoffman', 'http://benjaminrosshoffman.com/', NULL,'Benquo','benjaminrhoffman',NULL),
    ('Brayden McLean', 'United States', 'brayden.mclean', 'http://brayden.strikingly.com/',NULL,'BraydenM','braydenmclean',NULL),
    ('Catherine Olsson', 'United States', 'catherio', NULL, NULL,NULL,'catherineolsson',NULL),
    ('Eric Herboso', 'United States', 'EricHerboso','http://www.ericherboso.org', NULL,'EricHerboso','ericherboso',NULL),
    ('Glenn Willen', 'United States', 'gwillen', NULL, NULL,'gwillen', NULL,NULL),
    ('Gregory Lewis', 'United Kingdom', 'gjlewis37', NULL, NULL,NULL,'gregoryjlewis',NULL),
    ('Helen Toner', 'United States', 'helen.toner', NULL, NULL, NULL,'helen-toner-4162439a',NULL),
    ('Howie Lempel', 'United States', 'hlempel', NULL, NULL, NULL,'howie-lempel-201a6378',NULL),
    ('Ian David Moss', 'United States', 'iandavidmoss', NULL, NULL, NULL,'mossinator',NULL),
    ('Jacob Steinhardt', 'United States', 'jacob.steinhardt', NULL, NULL, 'jsteinhardt','jacob-steinhardt-a30437bb',NULL),
    ('Jeff Kaufman and Julia Wise', 'United States', 'jefftk', 'http://www.jefftk.com/', 'http://www.jefftk.com/donations', 'jkaufman','jeff-kaufman-28a8bab',NULL),
    ('Michael Dickens', 'United States', 'michael.j.dickens', 'http://mdickens.me/', 'http://mdickens.me/donations/', 'MTGandP','michael-dickens-a4173255',NULL),
    ('Nicole Ross', 'United States', 'nicolejamesross', NULL, NULL, NULL,'nicole-ross-184a6142',NULL),
    ('Pablo Stafforini', 'United Kingdom', 'stafforini', 'http://www.stafforini.com', 'http://www.stafforini.com/blog/donations/', NULL,'stafforini',NULL),
    ('Peter Hurford', 'United States', 'peterhurford', 'http://peterhurford.com/', 'http://peterhurford.com/other/donations.html','peter_hurford','peterhurford8',NULL),
    ('Rebecca Raible', 'United States', 'rebecca.paobur.raible', NULL, NULL, NULL,'rebeccaraible','GiveWell'),
    ('Rohin Shah', 'United States', 'rohinmshah', 'http://rohinshah.com/', NULL, NULL,'rohin-shah-76405832',NULL), 
    ('Timothy Telleen-Lawton', 'United States', 'TimTL', NULL, NULL, NULL,'timothytl','Frontier Group,Work For Progress,Environmen America,Environment California,Gen110,GiveWell');

insert into donors(donor, country, facebook_username, website, donations_url, income, notes, twitter_username,lesswrong_username,eaf_username,eahub_username,gratipay_username,patreon_username,predictionbook_username,github_username) values

    ('Vipul Naik', 'United States', 'vipulnaik.r', 'https://vipulnaik.com/',
        'https://vipulnaik.com/donation-history/', 90000, 'Disclosure: creator of the site', 'vipulnaik_r',
        'VipulNaik', 'vipulnaik', 'vipul-naik', NULL, NULL, 'vipulnaik', 'vipulnaik');

