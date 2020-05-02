create table documents (
  document_id int(11) not null auto_increment primary key,
  url varchar(200),
  title varchar(400),
  publication_date date,
  modified_date date,
  author varchar(200),
  publisher varchar(40),
  affected_donors varchar(2000),
  affected_donees varchar(2000),
  document_scope enum('Launch','Merger','Shutdown','Pre-launch planning','Broad donor strategy','Single donation documentation','Donee periodic update','Donee donation case','Evaluator review of donee','Evaluator update on donee','Evaluator consolidated recommendation list','Periodic donation list documentation','Reasoning supplement','Third-party coverage of donor strategy','Third-party case for donation','Third-party case against donation','Donation suggestion list', 'Unsolicited third-party suggestions for donor','Review of current state of cause area', 'Status change','Miscellaneous commentary', 'Donee AMA', 'Evaluator retrospective','Evaluator quantification approach','Job advertisement','Request for proposals','Request for reviews of donee','Partnership'),
  cause_area varchar(200),
  notes varchar(2000),
  unique key url(`url`)
) ENGINE=InnoDB AUTO_INCREMENT=15239276 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
