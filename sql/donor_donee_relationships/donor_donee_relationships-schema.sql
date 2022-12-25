drop table if exists donor_donee_relationships;

create table donor_donee_relationships (
    donor_donee_relationship_id int not null auto_increment primary key,
    donor varchar(100),
    donee varchar(200),
    relationship_start_date date,
    relationship_start_date_precision enum('day','month','year','multi-year'),
    key_interaction_urls varchar(2000),
    notes varchar(2000)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

