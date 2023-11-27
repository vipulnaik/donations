/* NOTE: For the pure AI safety grants, see open-phil-ai-safety-grants.sql and for the pure biosecurity grants, see open-phil-biosecurity-grants.sql This file covers grants that are not narrowly only about AI safety and biosecurity, though part of the grant may be used to address those issues */

/* Center for Security and Emerging Technology (CSET) */
insert into donations(donor, donee, amount, donation_date, donation_date_precision, donation_date_basis, cause_area, url, donor_cause_area_url, influencer, donation_announcement_date, donation_announcement_date_precision, donation_announcement_url, predictions, donation_process, intended_use_of_funds_category, intended_use_of_funds, intended_funding_timeframe_in_months, donor_donee_reason, donor_amount_reason, donor_timing_reason, donor_next_donation_thoughts, donor_retrospective, notes) values
  ('Open Philanthropy','Center for Security and Emerging Technology',55000000,'2019-01-01','month','donation log','Security/Biosecurity and pandemic preparedness/Global catastrophic risks/AI safety','https://www.openphilanthropy.org/giving/grants/georgetown-university-center-security-and-emerging-technology',NULL,'Luke Muehlhauser','2019-02-28','day',NULL,NULL,
  /* donation_process */ NULL,
  /* intended_use_of_funds_category */ 'Organizational general support',
  /* intended_use_of_funds */ 'Grant via Georgetown University for the Center for Security and Emerging Technology (CSET), a new think tank led by Jason Matheny, formerly of IARPA, dedicated to policy analysis at the intersection of national and international security and emerging technologies. CSET plans to provide nonpartisan technical analysis and advice related to emerging technologies and their security implications to the government, key media outlets, and other stakeholders.',
  /* intended_funding_timeframe_in_months */ 60,
  /* donor_donee_reason */ 'Open Phil thinks that one of the key factors in whether AI is broadly beneficial for society is whether policymakers are well-informed and well-advised about the nature of AI’s potential benefits, potential risks, and how these relate to potential policy actions. As AI grows more powerful, calls for government to play a more active role are likely to increase, and government funding and regulation could affect the benefits and risks of AI. Thus: "Overall, we feel that ensuring high-quality and well-informed advice to policymakers over the long run is one of the most promising ways to increase the benefits and reduce the risks from advanced AI, and that the team put together by CSET is uniquely well-positioned to provide such advice." Despite risks and uncertainty, the grant is described as worthwhile under Open Phil''s hits-based giving framework',
  /* donor_amount_reason */ 'The large amount over an extended period (5 years) is explained at https://www.openphilanthropy.org/blog/questions-we-ask-ourselves-making-grant "In the case of the new Center for Security and Emerging Technology, we think it will take some time to develop expertise on key questions relevant to policymakers and want to give CSET the commitment necessary to recruit key people, so we provided a five-year grant."',
  /* donor_timing_reason */ 'Likely determined by the timing that the grantee plans to launch. More timing details are not discussed',
  /* donor_next_donation_thoughts */ NULL,
  /* donor_retrospective */ NULL,
  /* notes */ 'Donee is entered as Center for Security and Emerging Technology rather than as Georgetown University for consistency with future grants directly to the organization once it is set up. Founding members of CSET include Dewey Murdick from the Chan Zuckerberg Initiative, William Hannas from the CIA, and Helen Toner from the Open Philanthropy Project. The grant is discussed in the broader context of giving by the Open Philanthropy Project into global catastrophic risks and AI safety in the Inside Philanthropy article https://www.insidephilanthropy.com/home/2019/3/22/why-this-effective-altruist-funder-is-giving-millions-to-ai-security');

/* Tampere University grants */
insert into donations(donor, donee, amount, donation_date, donation_date_precision, donation_date_basis, cause_area, url, donor_cause_area_url, donation_earmark, influencer, donation_announcement_date, donation_announcement_date_precision, donation_announcement_url, predictions, donation_process, intended_use_of_funds_category, intended_use_of_funds, intended_funding_timeframe_in_months, donor_donee_reason, donor_amount_reason, donor_timing_reason, donor_next_donation_thoughts, donor_retrospective, notes) values
  ('Open Philanthropy','Tampere University',15000,'2019-04-01','month','donation log','Global catastrophic risks','https://www.openphilanthropy.org/focus/global-catastrophic-risks/miscellaneous/tampere-university-2019','https://www.openphilanthropy.org/focus/global-catastrophic-risks','Hiski Haukkala','Claire Zabel','2019-06-07','day',NULL,NULL,
  /* donation_process */ 'Discretionary grant',
  /* intended_use_of_funds_category */ 'Direct project expenses',
  /* intended_use_of_funds */ 'Grant "to support Professor Hiski Haukkala’s efforts related to global catastrophic risks. Haukkala, a Finnish professor of international relations, plans to use the funding to bring speakers to Finland to discuss existential risks, to attend events related to existential risks, and to support networking and related projects."',
  /* intended_funding_timeframe_in_months */ NULL,
  /* donor_donee_reason */ NULL,
  /* donor_amount_reason */ NULL,
  /* donor_timing_reason */ NULL,
  /* donor_next_donation_thoughts */ NULL,
  /* donor_retrospective */ NULL,
  /* notes */ NULL);

/* Future of Humanity Institute grants */
insert into donations(donor, donee, amount, donation_date, donation_date_precision, donation_date_basis, cause_area, url, donor_cause_area_url, influencer, donation_announcement_date, donation_announcement_date_precision, donation_announcement_url, predictions, donation_process, intended_use_of_funds_category, intended_use_of_funds, intended_funding_timeframe_in_months, donor_donee_reason, donor_amount_reason, donor_timing_reason, donor_next_donation_thoughts, donor_retrospective, notes) values
  ('Open Philanthropy','Future of Humanity Institute',12066808.93,'2018-07-01','month','donation log','Global catastrophic risks','https://www.openphilanthropy.org/focus/global-catastrophic-risks/biosecurity/future-humanity-institute-work-on-global-catastrophic-risks','https://www.openphilanthropy.org/focus/global-catastrophic-risks','Nick Beckstead','2018-09-01','day',NULL,NULL,
  /* donation_process */ 'This is a series of awards totaling £13,428,434 ($16,200,062.78 USD at market rate on September 2, 2019); as of September 18, 2019, $12,066,808.93 of the amount has been allocated',
  /* intended_use_of_funds_category */ 'Direct project expenses',
  /* intended_use_of_funds */ 'Grant to support work on risks from advanced artificial intelligence, biosecurity and pandemic preparedness, and macrostrategy. The grant page says: "The largest pieces of the omnibus award package will allow FHI to recruit and hire for an education and training program led by Owen Cotton­Barratt, and retain and attract talent in biosecurity research and FHI’s Governance of AI program."',
  /* intended_funding_timeframe_in_months */ 36,
  /* donor_donee_reason */ NULL,
  /* donor_amount_reason */ NULL,
  /* donor_timing_reason */ NULL,
  /* donor_next_donation_thoughts */ NULL,
  /* donor_retrospective */ NULL,
  /* notes */ NULL);

/* MIT Media Lab grant(s) */
insert into donations(donor, donee, amount, donation_date, donation_date_precision, donation_date_basis, cause_area, url, donor_cause_area_url, influencer, donation_announcement_date, donation_announcement_date_precision, donation_announcement_url, predictions, donation_process, intended_use_of_funds_category, intended_use_of_funds, intended_funding_timeframe_in_months, donor_donee_reason, donor_amount_reason, donor_timing_reason, donor_next_donation_thoughts, donor_retrospective, notes) values
  ('Open Philanthropy','MIT Media Lab',1000000,'2019-03-01','month','donation log','Global catastrophic risks|Global health|Animal welfare','https://www.openphilanthropy.org/focus/global-catastrophic-risks/miscellaneous/massachusetts-institute-technology-media-lab-kevin-esvelt','https://www.openphilanthropy.org/focus/global-catastrophic-risks','Claire Zabel','2019-06-26','day',NULL,NULL,
  /* donation_process */ NULL,
  /* intended_use_of_funds_category */ 'Direct project expenses',
  /* intended_use_of-funds */ 'Grant over two years to the MIT Media Lab to support the research of Professor Kevin Esvelt. Professor Esvelt plans to use this funding to conduct research on global catastrophic risks, global health, and animal welfare.',
  /* intended_funding_timeframe_in_months */ 24,
  /* donor_donee_reason */ NULL,
  /* donor_amount_reason */ NULL,
  /* donor_timing_reason */ NULL,
  /* donor_next_donation_thoughts */ NULL,
  /* donor_retrospective */ NULL,
  /* notes */ NULL);

/* Ethan Alley donations */
insert into donations(donor, donee, amount, donation_date, donation_date_precision, donation_date_basis, cause_area, url, donor_cause_area_url, influencer, donation_announcement_date, donation_announcement_date_precision, donation_announcement_url, predictions, donation_process, intended_use_of_funds_category, intended_use_of_funds, intended_funding_timeframe_in_months, donor_donee_reason, donor_amount_reason, donor_timing_reason, donor_next_donation_thoughts, donor_retrospective, notes) values
  ('Open Philanthropy','Ethan Alley',437800,'2019-05-01','month','donation log','Global catastrophic risks','https://www.openphilanthropy.org/focus/global-catastrophic-risks/scholarship-support-2019','https://www.openphilanthropy.org/focus/global-catastrophic-risks','Claire Zabel','2019-07-18','day',NULL,NULL,
  /* donation_process */ NULL,
  /* intended_use_of_funds_category */ 'Living expenses during project',
  /* intended_use_of_funds */ 'The grant page says the grant is "over four years in scholarship funds support to Ethan Alley to pursue a PhD at the Massachusetts Institute of Technology. The funding is intended to be used for his tuition, fees, healthcare, and a living stipend during his degree program',
  /* intended_funding_timeframe_in_months */ 48,
  /* donor_donee_reason */ 'The grant page says the grant "is part of an effort to support value-aligned and qualified early-career researchers interested in global catastrophic risks."',
  /* donor_amount_reason */ 'The grant page says: "The funding is intended to be used for his tuition, fees, healthcare, and a living stipend during his degree program [over four years]" so the amount is likely determined based on the sum of the costs of these over four years',
  /* donor_timing_reason */ 'Likely determined by the start time of the grantee''s PhD program',
  /* donor_next_donation_thoughts */ 'The grant page calls the grant "part of an effort to support value-aligned and qualified early-career researchers interested in global catastrophic risks" so it will likely be followed by other similar grants to other researchers',
  /* donor_retrospective */ NULL,
  /* notes */ NULL);

/* Future of Life Institute grants -- note that one grant specific to AI safety is in open-phil-ai-safety-grants.sql instead */
insert into donations(donor, donee, amount, donation_date, donation_date_precision, donation_date_basis, cause_area, url, donor_cause_area_url, donation_earmark, influencer, donation_announcement_date, donation_announcement_date_precision, donation_announcement_url, predictions, donation_process, intended_use_of_funds_category, intended_use_of_funds, intended_funding_timeframe_in_months, donor_donee_reason, donor_amount_reason, donor_timing_reason, donor_next_donation_thoughts, donor_retrospective, notes) values
  ('Open Philanthropy','Future of Life Institute',100000,'2016-03-01','month','donation log','Global catastrophic risks/general research','https://www.openphilanthropy.org/focus/global-catastrophic-risks/miscellaneous/future-life-institute-general-support','https://www.openphilanthropy.org/focus/global-catastrophic-risks',NULL,NULL,'2016-03-18', 'day', 'https://groups.google.com/a/openphilanthropy.org/forum/#!topic/newly.published/N4IaorAmqWc',NULL,
  /* donation_process */ 'According to https://www.openphilanthropy.org/focus/global-catastrophic-risks/miscellaneous/future-life-institute-general-support#Our_process "Following our collaboration last year, we kept in touch with FLI regarding its funding situation and plans for future activities."',
  /* intended_use_of_funds_category */ 'Organizational general support',
  /* intended_use_of_funds */ 'Main planned activities for 2016 include: news operation, nuclear weapons campaign, AI safety conference, and AI conference travel.',
  /* intended_funding_timeframe_in_months */ NULL,
  /* donor_donee_reason */ 'https://www.openphilanthropy.org/focus/global-catastrophic-risks/miscellaneous/future-life-institute-general-support#The_case_for_the_grant says: "In organizing its 2015 [Puerto Rico] AI safety conference (which we attended), FLI demonstrated a combination of network, ability to execute, and values that impressed us. We felt that the conference was well-organized, attracted the attention of high-profile individuals who had not previously demonstrated an interest in AI safety, and seemed to lead many of those individuals to take the issue more seriously." There is more detail in the grant page, as well as a list of reservations about the grant.',
  /* donor_amount_reason */ NULL,
  /* donor_timing_reason */ 'Open Phil needed enough time to evaluate the results of its first Future of Life Institute grant that was focused on AI safety, and to see the effects of the Puerto Rico 2015 AI safety conference. Timing also likely determined by FLI explicitly seeking more money to meet its budget.',
  /* donor_next_donation_thoughts */ 'According to https://www.openphilanthropy.org/focus/global-catastrophic-risks/miscellaneous/future-life-institute-general-support#Key_questions_for_follow-up "We expect to have a conversation with FLI staff every 3-6 months for the next 12 months. After that, we plan to consider renewal." A list of questions is included.',
  /* donor_retrospective */ 'The followup grants in 2017, 2018, and 2019, for similar or larger amounts, suggest that Open Phil would continue to stand by its assessment of the grantee.',
  /* notes */ NULL),
  ('Open Philanthropy','Future of Life Institute',100000,'2017-05-01','month','donation log','Global catastrophic risks/AI safety','https://www.openphilanthropy.org/focus/global-catastrophic-risks/miscellaneous/future-life-institute-general-support-2017','https://www.openphilanthropy.org/focus/global-catastrophic-risks',NULL,'Nick Beckstead','2017-09-27','day','https://groups.google.com/a/openphilanthropy.org/forum/#!topic/newly.published/5UjOZN6KlWQ',NULL,
  /* donation_process */ NULL,
  /* intended_use_of_funds_category */ 'Organizational general support',
  /* intended_use_of_funds */ 'Grant for general support. However, the primary use of the grant will be to administer a request for proposals in AI safety similar to a request for proposals in 2015 https://www.openphilanthropy.org/focus/global-catastrophic-risks/potential-risks-advanced-artificial-intelligence/update-fli-grant',
  /* intended_funding_timeframe_in_months */ NULL,
  /* donor_donee_reason */ NULL,
  /* donor_amount_reason */ NULL,
  /* donor_timing_reason */ NULL,
  /* donor_next_donation_thoughts */ NULL,
  /* donor_retrospective */ 'The followup grants in 2018 and 2019, for similar or larger amounts, suggest that Open Phil would continue to stand by its assessment of the grantee.',
  /* notes */ NULL),
  ('Open Philanthropy','Future of Life Institute',250000,'2018-06-01','month','donation log','Global catastrophic risks','https://www.openphilanthropy.org/focus/global-catastrophic-risks/miscellaneous/future-life-institute-general-support-2018','https://www.openphilanthropy.org/focus/global-catastrophic-risks',NULL,'Nick Beckstead','2018-07-05','day',NULL,NULL, /* date adjusted */
  /* donation_process */ NULL,
  /* intended_use_of_funds_category */ 'Organizational general support',
  /* intended_use_of_funds */ 'Grant for general support. It is a renewal of the May 2017 grant https://www.openphilanthropy.org/focus/global-catastrophic-risks/miscellaneous/future-life-institute-general-support-2017 whose primary purpose to administer a request for proposals in AI safety similar to a request for proposals in 2015 https://www.openphilanthropy.org/focus/global-catastrophic-risks/potential-risks-advanced-artificial-intelligence/update-fli-grant',
  /* intended_funding_timeframe_in_months */ NULL,
  /* donor_donee_reason */ NULL,
  /* donor_amount_reason */ NULL,
  /* donor_timing_reason */ NULL,
  /* donor_next_donation_thoughts */ NULL,
  /* donor_retrospective */ 'The followup grant in 2019 suggests that Open Phil would continue to stand by its assessment of the grantee.',
  /* notes */ NULL),
  ('Open Philanthropy','Future of Life Institute',100000,'2019-10-01','month','donation log','Global catastrophic risks','https://www.openphilanthropy.org/focus/global-catastrophic-risks/miscellaneous/future-life-institute-general-support-2019','https://www.openphilanthropy.org/focus/global-catastrophic-risks',NULL,'Daniel Dewey','2019-11-18','day',NULL,NULL, /* date adjusted */
  /* donation_process */ NULL,
  /* intended_use_of_funds_category */ 'Organizational general support',
  /* intended_use_of_funds */ NULL,
  /* intended_funding_timeframe_in_months */ NULL,
  /* donor_donee_reason */ NULL,
  /* donor_amount_reason */ NULL,
  /* donor_timing_reason */ NULL,
  /* donor_next_donation_thoughts */ NULL,
  /* donor_retrospective */ NULL,
  /* notes */ NULL);


/* Global catastrophic risks donations */
insert into donations(donor, donee, amount, donation_date, donation_date_precision, donation_date_basis, cause_area, url, donor_cause_area_url, notes, donation_earmark, influencer, donation_announcement_date, donation_announcement_date_precision, donation_announcement_url, predictions) values
  ('Open Philanthropy','University of Cape Town',493425,'2016-09-01','month','donation log','Global catastrophic risks/geomagnetic currents and power systems','https://www.openphilanthropy.org/focus/global-catastrophic-risks/miscellaneous/university-cape-town-geomagnetics-research','https://www.openphilanthropy.org/focus/global-catastrophic-risks','Grant over three years to Professor Trevor Gaunt, Emeritus Professor of Electrical Engineering at the University of Cape Town (UCT) in South Africa, to research the potential risks that geomagnetic storms could pose to the electric power system','Trevor Gaunt',NULL,'2016-10-06', 'day', 'https://groups.google.com/a/openphilanthropy.org/forum/#!topic/newly.published/n74CZiSb9u8','https://predictionbook.com/predictions/185267|https://predictionbook.com/predictions/185268|https://predictionbook.com/predictions/185269'),
  ('Open Philanthropy','Rutgers University',2982206,'2017-03-01','month','donation log','Global catastrophic risks/nuclear war','https://www.openphilanthropy.org/focus/global-catastrophic-risks/miscellaneous/rutgers-university-nuclear-conflict-climate-modeling','https://www.openphilanthropy.org/focus/global-catastrophic-risks','Grant over three years to support a series of modeling studies on the climatological and subsequent ecological and social effects of large nuclear conflict. Research to beconducted by Alan Robock of Rutgers University and Owen Brian Toon of the University of Colorado Boulder.','Alan Robock', NULL, '2017-04-19','day','https://groups.google.com/a/openphilanthropy.org/forum/#!topic/newly.published/2N1Rk80n-Kk',NULL),
  ('Open Philanthropy','Center for a New American Security',260000,'2017-08-01','month','donation log','Global catastrophic risks','https://www.openphilanthropy.org/focus/global-catastrophic-risks/miscellaneous/center-for-a-new-american-security-richard-danzig-outreach-on-technological-risk','https://www.openphilanthropy.org/focus/global-catastrophic-risks','Grant awarded to support outreach by Richard Danzig,1 former Secretary of the Navy, on technological risks. Specifically, this funding will allow Mr. Danzig to revise and publish an already-drafted manuscript exploring and providing guidance on issues facing the US government related to potential risks from advanced technology (e.g., biosecurity, cybersecurity, and artificial intelligence risks). The funding would be used by Dr. Danzig to produce Technology Roulette https://www.cnas.org/publications/reports/technology-roulette a report intended for the national security community detailing the management of risks from losing control of advanced technology.','Richard Danzig','Helen Toner','2017-10-16','day','https://groups.google.com/a/openphilanthropy.org/forum/#!topic/newly.published/BuZwG_DW5fY',NULL),
  ('Open Philanthropy','Center for a New American Security',400352,'2018-09-01','month','donation log','Global catastrophic risks','https://www.openphilanthropy.org/focus/global-catastrophic-risks/miscellaneous/center-for-a-new-american-security-richard-danzig-outreach-on-technological-risk-2018','https://www.openphilanthropy.org/focus/global-catastrophic-risks','Grant to support outreach by Richard Danzig, former Secretary of the Navy, on technological risks. This is a renewal and expansion of the August 2017 grant https://www.openphilanthropy.org/focus/global-catastrophic-risks/miscellaneous/center-for-a-new-american-security-richard-danzig-outreach-on-technological-risk#footnote1_ix4f0ts which allowed Dr. Danzig to produce Technology Roulette https://www.cnas.org/publications/reports/technology-roulette a report intended for the national security community detailing the management of risks from losing control of advanced technology. Dr. Danzig intends to use these new funds to continue sharing these ideas with U.S. government officials, as well as spreading them to national security leaders abroad.','Richard Danzig','Claire Zabel','2018-10-20','day',NULL,NULL);

