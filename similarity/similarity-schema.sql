create table similarity (
    -- similarity_id int(11) not null auto_increment primary key,
    first_donor varchar(100),
    second_donor varchar(100),
    first_donor_size int(11),
    second_donor_size int(11),
    union_size int(11),
    intersect_size int(11),
    jaccard_index decimal(5,4),
    cosine_similarity decimal(5,4),
    weighted_cosine_similarity decimal(5,4)
) ENGINE=InnoDB AUTO_INCREMENT=15239276 DEFAULT CHARSET=utf8mb4;
