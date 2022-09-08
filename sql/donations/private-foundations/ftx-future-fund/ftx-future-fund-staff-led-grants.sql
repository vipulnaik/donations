/* Separate files:
   - Biosecurity: ftx-future-fund-biosecurity-staff-led-grants.sql
   - Effective altruism: ftx-future-fund-effective-altruism-staff-led-grants.sql
   All other grants are here
 */


/* Grants to Legal Priorities Project */
insert into donations(donor, donee, amount, donation_date, donation_date_precision, donation_date_basis, cause_area, url, donor_cause_area_url, donation_earmark, influencer, donation_announcement_date, donation_announcement_date_precision, donation_announcement_url, predictions, donation_process, intended_use_of_funds_category, intended_use_of_funds, intended_funding_timeframe_in_months, donor_donee_reason, donor_amount_reason, donor_timing_reason, donor_next_donation_thoughts, donor_retrospective, notes) values
  ('FTX Future Fund','Legal Priorities Project',480000,'2022-04-01','month','donation log',NULL,'https://ftxfuturefund.org/our-grants/?_funding_stream=ad-hoc',NULL,NULL,NULL,NULL,NULL,NULL,NULL,
  /* donation_process */ 'This grant is part of staff-led grantmaking by FTX Future Fund. https://forum.effectivealtruism.org/posts/paMYXYFYbbjpdjgbt/future-fund-june-2022-update#Staff_led_grantmaking_in_more_detail says: "Unlike the open call and regranting, these grants and investments are not a test of a particular potentially highly scalable funding model. These are projects we funded because we became aware of them and thought they were good ideas."',
  /* intended_use_of_funds_category */ 'Direct project expenses',
  /* intended_use_of_funds */ 'Grant to "support the Legal Priorities Project’s ongoing research and outreach activities. This will allow LPP to pay two new hires and to put on a summer institute for non-US law students in Oxford."',
  /* intended_funding_timeframe_in_months */ NULL,
  /* donor_donee_reason */ NULL,
  /* donor_amount_reason */ NULL,
  /* donor_timing_reason */ NULL,
  /* donor_next_donation_thoughts */ NULL,
  /* donor_retrospective */ 'FTX Future Fund would make a further grant of $700,000 in June 2022, about two months later, indicating continued satisfaction with the grantee.',
  /* notes */ NULL),

  ('FTX Future Fund','Legal Priorities Project',700000,'2022-06-01','month','donation log',NULL,'https://ftxfuturefund.org/our-grants/?_funding_stream=ad-hoc',NULL,NULL,NULL,NULL,NULL,NULL,NULL,
  /* donation_process */ 'This grant is part of staff-led grantmaking by FTX Future Fund. https://forum.effectivealtruism.org/posts/paMYXYFYbbjpdjgbt/future-fund-june-2022-update#Staff_led_grantmaking_in_more_detail says: "Unlike the open call and regranting, these grants and investments are not a test of a particular potentially highly scalable funding model. These are projects we funded because we became aware of them and thought they were good ideas."',
  /* intended_use_of_funds_category */ 'Direct project expenses',
  /* intended_use_of_funds */ 'Grant to "support one year of operating expenses and salaries at the Legal Priorities Project, a longtermist legal research and field-building organization."',
  /* intended_funding_timeframe_in_months */ 12,
  /* donor_donee_reason */ NULL,
  /* donor_amount_reason */ NULL,
  /* donor_timing_reason */ NULL,
  /* donor_next_donation_thoughts */ NULL,
  /* donor_retrospective */ NULL,
  /* notes */ 'This is the second grant from FTX Future Fund to Legal Priorities Project; the preceding grant of $480,000 was in April 2022.');

/* Other grants */

insert into donations(donor, donee, amount, donation_date, donation_date_precision, donation_date_basis, cause_area, url, donor_cause_area_url, donation_earmark, influencer, donation_announcement_date, donation_announcement_date_precision, donation_announcement_url, predictions, donation_process, intended_use_of_funds_category, intended_use_of_funds, intended_funding_timeframe_in_months, donor_donee_reason, donor_amount_reason, donor_timing_reason, donor_next_donation_thoughts, donor_retrospective, notes) values
  ('FTX Future Fund','Brown University',500000,'2022-01-01','month','donation log','Economic growth','https://ftxfuturefund.org/our-grants/?_funding_stream=ad-hoc','https://ftxfuturefund.org/area-of-interest/economic-growth/','Oded Galor',NULL,NULL,NULL,NULL,NULL,
  /* donation_process */ 'This grant is part of staff-led grantmaking by FTX Future Fund. https://forum.effectivealtruism.org/posts/paMYXYFYbbjpdjgbt/future-fund-june-2022-update#Staff_led_grantmaking_in_more_detail says: "Unlike the open call and regranting, these grants and investments are not a test of a particular potentially highly scalable funding model. These are projects we funded because we became aware of them and thought they were good ideas."',
  /* intended_use_of_funds_category */ 'Direct project expenses',
  /* intended_use_of_funds */ 'Grant to "support two years of academic research on long-term economic growth."',
  /* intended_funding_timeframe_in_months */ 24,
  /* donor_donee_reason */ NULL,
  /* donor_amount_reason */ NULL,
  /* donor_timing_reason */ NULL,
  /* donor_next_donation_thoughts */ NULL,
  /* donor_retrospective */ NULL,
  /* notes */ NULL),

  ('FTX Future Fund','The Atlas Fellowship',5000000,'2022-01-01','month','donation log','Education|Talent pipeline','https://ftxfuturefund.org/our-grants/?_funding_stream=ad-hoc','https://ftxfuturefund.org/area-of-interest/empowering-exceptional-people/',NULL,NULL,NULL,NULL,NULL,NULL,
  /* donation_process */ 'This grant is part of staff-led grantmaking by FTX Future Fund. https://forum.effectivealtruism.org/posts/paMYXYFYbbjpdjgbt/future-fund-june-2022-update#Staff_led_grantmaking_in_more_detail says: "Unlike the open call and regranting, these grants and investments are not a test of a particular potentially highly scalable funding model. These are projects we funded because we became aware of them and thought they were good ideas."',
  /* intended_use_of_funds_category */ 'Direct project expenses',
  /* intended_use_of_funds */ 'Grant to "support scholarships for talented and promising high school students to use towards educational opportunities and enrolling in a summer program."',
  /* intended_funding_timeframe_in_months */ NULL,
  /* donor_donee_reason */ NULL,
  /* donor_amount_reason */ NULL,
  /* donor_timing_reason */ NULL,
  /* donor_next_donation_thoughts */ NULL,
  /* donor_retrospective */ NULL,
  /* notes */ NULL),

  ('FTX Future Fund','Longview Philanthropy',15000000,'2022-02-01','month','donation log',NULL,'https://ftxfuturefund.org/our-grants/?_funding_stream=ad-hoc',NULL,NULL,NULL,NULL,NULL,NULL,NULL,
  /* donation_process */ 'This grant is part of staff-led grantmaking by FTX Future Fund. https://forum.effectivealtruism.org/posts/paMYXYFYbbjpdjgbt/future-fund-june-2022-update#Staff_led_grantmaking_in_more_detail says: "Unlike the open call and regranting, these grants and investments are not a test of a particular potentially highly scalable funding model. These are projects we funded because we became aware of them and thought they were good ideas."',
  /* intended_use_of_funds_category */ 'Regranting',
  /* intended_use_of_funds */ 'Grant to "support Longview’s independent grantmaking on global priorities research, nuclear weapons policy, and other longtermist issues."',
  /* intended_funding_timeframe_in_months */ NULL,
  /* donor_donee_reason */ NULL,
  /* donor_amount_reason */ NULL,
  /* donor_timing_reason */ NULL,
  /* donor_next_donation_thoughts */ NULL,
  /* donor_retrospective */ NULL,
  /* notes */ NULL),

  ('FTX Future Fund','The Center for Election Science',300000,'2022-03-01','month','donation log','Epistemic institutions|Politics','https://ftxfuturefund.org/our-grants/?_funding_stream=ad-hoc','https://ftxfuturefund.org/area-of-interest/epistemic-institutions/',NULL,NULL,NULL,NULL,NULL,NULL,
  /* donation_process */ 'This grant is part of staff-led grantmaking by FTX Future Fund. https://forum.effectivealtruism.org/posts/paMYXYFYbbjpdjgbt/future-fund-june-2022-update#Staff_led_grantmaking_in_more_detail says: "Unlike the open call and regranting, these grants and investments are not a test of a particular potentially highly scalable funding model. These are projects we funded because we became aware of them and thought they were good ideas."',
  /* intended_use_of_funds_category */ 'Direct project expenses',
  /* intended_use_of_funds */ 'The grant description says: "We recommended a grant to support the development of statewide ballot initiatives to institute approval voting. Approval voting is a simple voting method reform that lets voters select all the candidates they wish."',
  /* intended_funding_timeframe_in_months */ NULL,
  /* donor_donee_reason */ NULL,
  /* donor_amount_reason */ NULL,
  /* donor_timing_reason */ NULL,
  /* donor_next_donation_thoughts */ NULL,
  /* donor_retrospective */ NULL,
  /* notes */ NULL),

  ('FTX Future Fund','Rethink Priorities',700000,'2022-03-01','month','donation log',NULL,'https://ftxfuturefund.org/our-grants/?_funding_stream=ad-hoc',NULL,NULL,NULL,NULL,NULL,NULL,NULL,
  /* donation_process */ 'This grant is part of staff-led grantmaking by FTX Future Fund. https://forum.effectivealtruism.org/posts/paMYXYFYbbjpdjgbt/future-fund-june-2022-update#Staff_led_grantmaking_in_more_detail says: "Unlike the open call and regranting, these grants and investments are not a test of a particular potentially highly scalable funding model. These are projects we funded because we became aware of them and thought they were good ideas."',
  /* intended_use_of_funds_category */ 'Direct project expenses',
  /* intended_use_of_funds */ 'Grant to "support Rethink’s research and projects aimed at improving humanity’s long-term prospects." Rethink Priorities also does non-human-centric work (such as research into animal welfare) and more neartermist work, and the grant seems limited to the longtermist work.',
  /* intended_funding_timeframe_in_months */ NULL,
  /* donor_donee_reason */ NULL,
  /* donor_amount_reason */ NULL,
  /* donor_timing_reason */ NULL,
  /* donor_next_donation_thoughts */ NULL,
  /* donor_retrospective */ NULL,
  /* notes */ NULL),

  ('FTX Future Fund','Pathos Labs',50000,'2022-01-01','year','donation log','Values and reflective processes','https://ftxfuturefund.org/our-grants/?_funding_stream=ad-hoc','https://ftxfuturefund.org/area-of-interest/values-and-reflective-processes/',NULL,NULL,NULL,NULL,NULL,NULL,
  /* donation_process */ 'This grant is part of staff-led grantmaking by FTX Future Fund. https://forum.effectivealtruism.org/posts/paMYXYFYbbjpdjgbt/future-fund-june-2022-update#Staff_led_grantmaking_in_more_detail says: "Unlike the open call and regranting, these grants and investments are not a test of a particular potentially highly scalable funding model. These are projects we funded because we became aware of them and thought they were good ideas."',
  /* intended_use_of_funds_category */ 'Direct project expenses',
  /* intended_use_of_funds */ 'Grant to "support Pathos Labs to produce a PopShift convening connecting experts on the future of technology and existential risks with television writers to inspire new ideas for their shows."',
  /* intended_funding_timeframe_in_months */ NULL,
  /* donor_donee_reason */ NULL,
  /* donor_amount_reason */ NULL,
  /* donor_timing_reason */ NULL,
  /* donor_next_donation_thoughts */ NULL,
  /* donor_retrospective */ NULL,
  /* notes */ NULL);
