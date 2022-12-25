create table money_moved(
  move_id int(11) not null auto_increment primary key,
  influencer varchar(100),
  identified_donees varchar(200),
  identified_donors varchar(200),
  amount decimal(14,2),
  start_date date,
  end_date date,
  document_url varchar(200),
  document_title varchar(200),
  notes varchar(1000)
)  ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4;
