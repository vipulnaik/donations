create table disclosures (
  disclosure_id int(11) not null auto_increment primary key,
  donor varchar(100),
  donee varchar(200),
  url varchar(300),
  donation_url varchar(200),
  donation_date date,
  donor_side_name varchar(100),
  donee_side_name varchar(100),
  relationship_nature enum('Romantic relationship', 'Friendship', 'Personal', 'Professional', 'Marriage', 'Social', 'Academic'),
  notes varchar(2000),
  cardinality int(11) default 1,
  full_relationship varchar(2000),
  index disclosure_key(donor, donee, url, donation_date)
) ENGINE=InnoDB AUTO_INCREMENT=15239276 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
