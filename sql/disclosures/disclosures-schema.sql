create table disclosures (
  disclosure_id int not null auto_increment primary key,
  donor varchar(100),
  donee varchar(200),
  url varchar(300),
  donation_url varchar(200),
  donation_date date,
  donor_side_name varchar(100),
  donee_side_name varchar(100),
  -- 'Social' is used for general social relationships, e.g. when a
  -- relationship is not specifically stated to be a friendship. 'Academic' is
  -- used for pre-professional academic relationships, e.g. a connection from
  -- law school or undergraduate studies.
  relationship_nature enum('Romantic relationship', 'Friendship', 'Personal', 'Professional', 'Marriage', 'Social', 'Academic', 'Hybrid'),
  notes varchar(2000),
  cardinality int default 1,
  -- Each chain in full_relationship is of the form:
  --     A (B) ↔ C (D)
  -- Where A and C are individuals and B and D are organizations. The chain
  -- means that a relationship extends between B and D because of the
  -- relationship between A and C. This can happen in one (or more) of the
  -- following ways:
  -- 1. A=C. This means that the same individual is or was part of both
  --    organizations.
  -- 2. B=D. This means that A and C have a relationship by virtue of being
  --    part of the same organization.
  -- 3. A has a relationship with C for some other reason than merely being
  --    part of the same organization (e.g. a friendship).
  -- 4. B and D are organizations that are close for some reason other than a
  --    relationship between individuals, or because there are many
  --    relationships between individuals. For instance, one organization could
  --    be the parent of the other.
  -- When full_relationship is NULL, it is the trivial relationship:
  --     donor_side_name (donor) ↔ donee_side_name (donee)
  full_relationship varchar(2000),
  index disclosure_key(donor, donee, url, donation_date)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
