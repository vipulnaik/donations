create table donor_donee_relationships (
    donor_donee_relationship_id int(11) not null auto_increment primary key,
    donor varchar(100),
    donee varchar(200),
    relationship_start_date date,
    relationship_start_date_precision enum('day','month','year','multi-year'),
    key_interaction_urls varchar(2000),
    notes varchar(2000)
) ENGINE=InnoDB AUTO_INCREMENT=15239276 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

insert into donor_donee_relationships(donor, donee, relationship_start_date, relationship_start_date_precision, key_interaction_urls, notes) values
    (
        'Open Philanthropy Project', /* donor */
        'Machine Intelligence Research Institute', /* donee */
        NULL, /* relationship_start_date */
        NULL, /* relationship_start_date_precision */
        'http://lesswrong.com/lw/cbs/thoughts_on_the_singularity_institute_si|https://intelligence.org/2014/01/27/existential-risk-strategy-conversation-with-holden-karnofsky/|https://intelligence.org/2014/01/13/miri-strategy-conversation-with-steinhardt-karnofsky-and-amodei/|https://www.openphilanthropy.org/blog/three-key-issues-ive-changed-my-mind-about|https://www.lesswrong.com/posts/xQ9tMMk3RArodLtDq/intellectual-progress-inside-and-outside-academia|https://www.lesswrong.com/posts/QSHwKqyY4GAXKi9tX/a-personal-history-of-involvement-with-effective-altruism#ZEbsmuyk7DW4fgLvm|https://intelligence.org/files/OpenPhil2016Supplement.pdf|https://groups.yahoo.com/neo/groups/givewell/conversations/topics/270', /* key_interaction_urls */
        'Open Philanthropy Project staff have interacted with MIRI staff from the time before Open Philanthropy Project existed. The first published conversation between GiveWell staff (Holden Karnofsky) and MIRI staff dates back to February 2011 (six months before GiveWell Labs is announced), where Karnofsky decides against recommending MIRI due to lack of track record and room for more funding. In May 2012, Karnofsky publishes “Thoughts on the Singularity Institute (SI)” on LessWrong; the blog post outlines Karnofsky’s reasons for not recommending MIRI. However, over the years Karnofsky in particular has come to agree with more of MIRI’s views, as described in his post “Three Key Issues I’ve Changed My Mind About” (published September 2016). Since 2016, Open Philanthropy Project has given MIRI a steady stream of grants, despite some significant reservations about its output.' /* notes */
    )
    ,(
        'Open Philanthropy Project', /* donor */
        'Center for Applied Rationality', /* donee */
        NULL, /* relationship_start_date */
        NULL, /* relationship_start_date_precision */
        'https://www.openphilanthropy.org/giving/grants/center-applied-rationality-general-support|https://www.openphilanthropy.org/giving/grants/center-applied-rationality-sparc', /* key_interaction_urls */
        'Since 2016, Open Philanthropy Project has given a steady stream of grants to CFAR, both for general support and for specific programs like SPARC and ESPR.' /* notes */
    )
    ,(
        'Open Philanthropy Project', /* donor */
        'The Humane League', /* donee */
        NULL, /* relationship_start_date */
        NULL, /* relationship_start_date_precision */
        'https://www.openphilanthropy.org/focus/us-policy/farm-animal-welfare/humane-league-corporate-cage-free-campaigns|https://www.openphilanthropy.org/files/Conversations/The_Humane_League_02-28-17_(public).pdf|https://www.openphilanthropy.org/sites/default/files/The_Humane_League_08-22-16_%28public%29.pdf', /* key_interaction_urls */
        'Since 2016, Open Philanthropy Project has given a steady stream of grants to The Humane League, both for general support and for corporate cage-free campaign spending.' /* notes */
    )
    ,(
        'Effective Altruism Funds', /* donor */
        'Machine Intelligence Research Institute', /* donee */
        NULL, /* relationship_start_date */
        NULL, /* relationship_start_date_precision */
        'https://forum.effectivealtruism.org/posts/CJJDwgyqT4gXktq6g/long-term-future-fund-april-2019-grant-decisions', /* key_interaction_urls */
        'The Long-Term Future fund of Effective Altruism Funds has given out several grants to MIRI, both under the initial fund manager (Nick Beckstead) and the new fund managers (Oliver Habryka et al.).' /* notes */
    )
;
