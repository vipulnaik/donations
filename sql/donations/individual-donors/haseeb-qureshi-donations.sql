insert into donations(donor, donee, amount, fraction, donation_date, donation_date_precision, donation_date_basis, cause_area, url, notes, payment_modality, match_eligible, goal_amount, influencer) values
  ('Haseeb Qureshi', 'Against Malaria Foundation', 12650, 0.25, '2016-01-01','year','date of donation announced in announcement','Global health/malaria','http://haseebq.com/2016-donations-and-some-thoughts/','Highlighted rock-solid work at saving lives and the need to spend on surefire things in addition to speculative investments', NULL, NULL, 50600, 'GiveWell'),
  ('Haseeb Qureshi', 'Rethink Charity',12650,0.25,'2016-01-01','year','date of donation announced in announcement','Effective altruism/movement growth','http://haseebq.com/2016-donations-and-some-thoughts/','Highlighted its projects including the Effective Altruism Forum', NULL, NULL, 50600,NULL),
  ('Haseeb Qureshi', '80,000 Hours',25300, 0.5,'2016-01-01','year','date of donation announced in announcement','Effective altruism/movement growth','http://haseebq.com/2016-donations-and-some-thoughts/','Highlighted impact potential, significant growth, and personal anecdote of how it influenced the author', NULL, NULL, 50600,NULL),
  ('Haseeb Qureshi','Against Malaria Foundation',11340,0.25,'2017-01-01','year','date of donation announced in announcement','Global health/malaria','https://medium.freecodecamp.org/yearly-donations-and-why-you-should-give-now-not-later-cba890cabfbe','Donor called it "the same organization I donate to every year, and the #1 top ranked charity on Givewell for multiple years."',NULL,NULL,45370,NULL),
  ('Haseeb Qureshi','Alex Flint AI risk fund',34030,0.75,'2017-01-01','year','date of donation announced in announcement','AI safety','https://medium.freecodecamp.org/yearly-donations-and-why-you-should-give-now-not-later-cba890cabfbe','Donor said "I’m donating to a donor-advised fund to be donated to a promising AI safety charity. The fund is managed by my good friend Alex Flint, a computer vision PhD from Oxford who’s very well-versed in AI risk"',NULL,NULL,45370,NULL);

insert into donations(donor, donee, amount, donation_date, donation_date_precision, donation_date_basis, cause_area, url, goal_amount, fraction, influencer, donation_announcement_date, donation_announcement_date_precision,donation_announcement_url, donation_process, intended_use_of_funds_category, intended_use_of_funds, intended_funding_timeframe_in_months, donor_donee_reason, donor_amount_reason, donor_timing_reason, donor_next_donation_thoughts, donor_retrospective, notes) values
  ('Haseeb Qureshi','GiveDirectly', 25000, '2013-01-01', 'year', 'donation log', 'Cash transfers', 'https://eahub.org/user/haseeb-qureshi', 25000, 1.0, 'GiveWell', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),

  ('Haseeb Qureshi','Against Malaria Foundation', 5300, '2015-01-01','year','date of donation announced in announcement','Global health/malaria','https://haseebq.com/my-first-year-earning-to-give-a-retrospective/',21200, 0.25, 'GiveWell', '2015-12-31','day','https://haseebq.com/my-first-year-earning-to-give-a-retrospective/',
  /* donation_process */ 'The announcement post says: "In all I gave 33% of my pre-tax income, which since I started my job in June, amounts to $21,200 USD I donated to high-impact charities." The allocation of this $21,200 is based on analysis of the individual target charities',
  /* intended_use_of_funds_category */ 'Organizational general support',
  /* intended_use_of_funds */ 'The donee "distributes low-cost anti-mosquito bednets in parts of Africa that are ravaged by malaria"',
  /* intended_funding_timeframe_in_months */ NULL,
  /* donor_donee_reason */ 'The announcement post says of the donee: "AMF is ranked by Givewell as the most marginally impactful charity in the world."',
  /* donor_amount_reason */ 'The announcement post says: "In all I gave 33% of my pre-tax income, which since I started my job in June, amounts to $21,200 USD I donated to high-impact charities." AMF gets 25% of this money; the amount it gets is likely constrained by the needs of other recipients',
  /* donor_timing_reason */ 'End-of-year round of donations of 33% of income in the year; this is part of the donor''s earning-to-give strategy',
  /* donor_next_donation_thoughts */ NULL,
  /* donor_retrospective */ 'The donor would continue to donate to Against Malaria Foundation for the next two years; see https://haseebq.com/2016-donations-and-some-thoughts/ and https://medium.freecodecamp.org/yearly-donations-and-why-you-should-give-now-not-later-cba890cabfbe but would stop donating to it in 2018',
  /* notes */ NULL),

  ('Haseeb Qureshi','Rethink Charity', 5300, '2015-01-01','year','date of donation announced in announcement','Effective altruism/movement growth','https://haseebq.com/my-first-year-earning-to-give-a-retrospective/',21200, 0.25, 'GiveWell', '2015-12-31','day','https://haseebq.com/my-first-year-earning-to-give-a-retrospective/',
  /* donation_process */ 'The announcement post says: "In all I gave 33% of my pre-tax income, which since I started my job in June, amounts to $21,200 USD I donated to high-impact charities." The allocation of this $21,200 is based on analysis of the individual target charities',
  /* intended_use_of_funds_category */ 'Organizational general support',
  /* intended_use_of_funds */ 'At the time of the donation, the donee is known as .impact (it would later rename itself to Rethink Charity). The announcement post calls it "a grassroots EA organization with which I’ve grown more involved over the last year. .impact is best known for creating a ton of EA infrastructure, including the EA Forums and EA Hub. Their latest project is LEAN, which helps to seed and support EA chapters all around the world, helping to foster the movement at the grassroots level."',
  /* intended_funding_timeframe_in_months */ NULL,
  /* donor_donee_reason */ 'The announcement post says: ".impact is best known for creating a ton of EA infrastructure, including the EA Forums and EA Hub. Their latest project is LEAN, which helps to seed and support EA chapters all around the world, helping to foster the movement at the grassroots level."',
  /* donor_amount_reason */ 'The announcement post says: "In all I gave 33% of my pre-tax income, which since I started my job in June, amounts to $21,200 USD I donated to high-impact charities." Rethink Charity gets 25% of this money; the amount it gets is likely constrained by the needs of other recipients',
  /* donor_timing_reason */ 'End-of-year round of donations of 33% of income in the year; this is part of the donor''s earning-to-give strategy',
  /* donor_next_donation_thoughts */ NULL,
  /* donor_retrospective */ 'The donor would continue to make similar donations in later years: to Rethink Charity in 2016 https://haseebq.com/2016-donations-and-some-thoughts/and to the Local Effective Altruism Network in 2018 https://haseebq.com/2018-donations/',
  /* notes */ NULL),

  ('Haseeb Qureshi','Centre for Effective Altruism', 10600,'2015-01-01','year','date of donation announced in announcement','Effective altruism/movement growth','https://haseebq.com/my-first-year-earning-to-give-a-retrospective/',21200, 0.5, 'GiveWell', '2015-12-31','day','https://haseebq.com/my-first-year-earning-to-give-a-retrospective/',
  /* donation_process */ 'The announcement post says: "In all I gave 33% of my pre-tax income, which since I started my job in June, amounts to $21,200 USD I donated to high-impact charities." The allocation of this $21,200 is based on analysis of the individual target charities',
  /* intended_use_of_funds_category */ 'Direct project expenses',
  /* intended_use_of_funds */ 'Donation for the EA Outreach team run by Kerry Vaughan and Tyler Alterman. The announcement post says: "EA Outreach was responsible for EA Global, the major EA conference this year at Google HQ, and have ambitious plans on how to grow the movement and influence more of the world toward evidence-based giving."'
  /* intended_funding_timeframe_in_months */ NULL,
  /* donor_donee_reason */ 'The announcement post says: "[EA Outreach] have ambitious plans on how to grow the movement and influence more of the world toward evidence-based giving. I think the impact they could have is enormous, and so I decided to give them half of my donations this year."',
  /* donor_amount_reason */ 'The announcement post says: "In all I gave 33% of my pre-tax income, which since I started my job in June, amounts to $21,200 USD I donated to high-impact charities." EA Outreach gets 50% of this money; the amount it gets is likely constrained by the needs of other recipients',
  /* donor_timing_reason */ 'End-of-year round of donations of 33% of income in the year; this is part of the donor''s earning-to-give strategy',
  /* donor_next_donation_thoughts */ NULL,
  /* donor_retrospective */ NULL,
  /* notes */ NULL);

