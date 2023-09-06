create table cause_area_similarity (
    -- similarity_id int not null auto_increment primary key,
    cause_area varchar(100),
    first_donor varchar(100),
    second_donor varchar(100),
    first_donor_size int,
    second_donor_size int,
    union_size int,
    intersect_size int,
    jaccard_index decimal(5,4),
    cosine_similarity decimal(5,4),
    weighted_cosine_similarity decimal(5,4)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4;
