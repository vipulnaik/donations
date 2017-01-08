create table donations(
    donation_id int(11) not null auto_increment primary key,
    donor varchar(40),
    donee varchar(40),
    amount float(14,2),
    fraction float(3, 2),
    donation_date date NOT NULL,
    cause_area varchar(100) NOT NULL,
    url varchar(100),
    notes varchar(2000) DEFAULT NULL,
    payment_modality varchar(100),
    matched boolean,
    goal_amount float(14,2),
) ENGINE=InnoDB AUTO_INCREMENT=15239276 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

insert into donations(donor, donee, amount, fraction, donation_date,
    cause_area, url, notes, payment_modality, matched, goal_amount) values
    ('Vipul Naik', 'GiveDirectly', 500.00, NULL, '2012-12', 'Global poverty',
    'https://vipulnaik.com/donation-history/', NULL, NULL, NULL, NULL),
    ('Vipul Naik', 'VillageReach', 5100.00, NULL, '2010-12', NULL,
    'https://vipulnaik.com/donation-history/', NULL, NULL, NULL, NULL)
;
