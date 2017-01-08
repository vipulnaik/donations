create table donors (
    donor_id int(11) not null auto_increment primary key,
    donor varchar(40) not null,
    facebook_username varchar(100),
    website varchar(40),
    donations_url varchar(100),
    income int(12),
    notes varchar(2000) default null,
    twitter_username varchar(40),
    lesswrong_username varchar(40),
    eaf_username varchar(40),
    gratipay_username varchar(40),
    patreon_username varchar(40),
    predictionbook_username varchar(40),
    github_username varchar(40),
    unique key donor(`donor`)
) ENGINE=InnoDB AUTO_INCREMENT=15239276 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

insert into donors(donor) values
    ('Jeff Kaufman')
    ('Ben Kuhn')
    ('Vipul Naik')
    ('Peter Hurford')
    ('Michael Dickens')
    ('Timothy Telleen-Lawton')
    ('Gregory Lewis')
    ('Ajeya Cotra')
    ('Rohin Shah')
    ('Helen Toner')
    ('Nicole Ross')
    ('Howie Lempel')
    ('Rebecca Raible')
    ('Pablo Stafforini')
    ('Aaron Gertler')
    ('Brayden McLean')
    ('Benjamin Hoffman')
    ('Catherine Olsson')
    ('Eric Herboso')
    ('Ian David Moss')
    ('Glenn Willen')
    ('Jacob Steinhardt')
;

update donors set website='http://jefftk.com/' where donor = 'Jeff Kaufman';
