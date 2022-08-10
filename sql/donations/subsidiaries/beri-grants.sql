/* Grants to BERI and grants BERI has given out
Grants covered elsewhere:
- EA Funds/Giving Group grants to BERI
- Open Philanthropy grant to BERI
- Survival and Flourishing Fund grants to BERI
*/

/* Grants to Machine Intelligence Research Institute (MIRI) */
insert into donations(donor, donee, amount, donation_date, donation_date_precision, donation_date_basis, cause_area, url, donation_announcement_date, donation_announcement_date_precision, donation_announcement_url, donation_process, intended_use_of_funds_category, intended_use_of_funds, intended_funding_timeframe_in_months, donor_donee_reason, donor_amount_reason, donor_timing_reason, donor_next_donation_thoughts, donor_retrospective, notes) values
  ('Berkeley Existential Risk Initiative','Machine Intelligence Research Institute',100000,'2017-09-13','day','donation log','AI safety','http://existence.org/grants','2017-09-25','day','http://existence.org/2017/09/25/announcing-beris-first-grants-program.html',
  /* donation_process */ NULL,
  /* intended_use_of_funds_category */ 'Organizational general support',
  /* intended_use_of_funds */ NULL,
  /* intended_funding_timeframe_in_months */ NULL,
  /* donor_donee_reason */ 'The announcement page says: "Broadly, we believe these groups [Machine Intelligence Research Institute and Future of Life Institute] to have done good work in the past for reducing existential risk and wish to support their continued efforts."',
  /* donor_amount_reason */ NULL,
  /* donor_timing_reason */ 'This is one of two opening grants made by BERI to begin its grants program.',
  /* donor_next_donation_thoughts */ 'The grant page says: "Over the next few months, we may write more about our reasoning behind these and other grants." It further outlines the kinds of organizations that BERI will be granting to in the short run.',
  /* donor_retrospective */ 'BERI would make three further grants to MIRI, indicating continued confidence in the grantee. The last grant would be in March 2020 for $300,000. By that point, BERI would have transitioned these grantmaking responsibilities to the Survival and Fluorishing Fund.',
  /* notes */ NULL),
  ('Berkeley Existential Risk Initiative','Machine Intelligence Research Institute',100000,'2017-12-28','day','donation log','AI safety','http://existence.org/grants/','2018-01-11','day','http://existence.org/2018/01/11/activity-update-december-2017.html',
  /* donation_process */ NULL,
  /* intended_use_of_funds_category */ 'Organizational general support',
  /* intended_use_of_funds */ NULL,
  /* intended_funding_timeframe_in_months */ NULL,
  /* donor_donee_reason */ NULL,
  /* donor_amount_reason */ NULL,
  /* donor_timing_reason */ NULL,
  /* donoor_next_donation_thoughts */ NULL,
  /* donor_retrospective */ 'BERI would make two further grants to MIRI, indicating continued confidence in the grantee. The last grant would be in March 2020 for $300,000. By that point, BERI would have transitioned these grantmaking responsibilities to the Survival and Fluorishing Fund.',
  /* notes */ NULL),
  ('Berkeley Existential Risk Initiative','Machine Intelligence Research Institute',600000,'2019-02-26','day','donation log','AI safety','http://existence.org/grants/','2019-05-09','day','http://existence.org/2019/05/09/activity-update-march-2019.html',
  /* donation_process */ NULL,
  /* intended_use_of_funds_category */ 'Organizational general support',
  /* intended_use_of_funds */ NULL,
  /* intended_funding_timeframe_in_months */ NULL,
  /* donor_donee_reason */ NULL,
  /* donor_amount_reason */ NULL,
  /* donor_timing_reason */ NULL,
  /* donor_next_donation_thoughts */ NULL,
  /* donor_retrospective */ 'BERI would make a further to MIRI, indicating continued confidence in the grantee. The followup grant would be in March 2020 for $300,000. By that point, BERI would have transitioned these grantmaking responsibilities to the Survival and Fluorishing Fund.',
  /* notes */ 'This grant is also discussed by the Machine Intelligence Research Institute (the grant recipient) at https://intelligence.org/2017/11/08/major-grant-open-phil/ along with a grant https://www.openphilanthropy.org/focus/global-catastrophic-risks/potential-risks-advanced-artificial-intelligence/machine-intelligence-research-institute-general-support-2019 from the Open Philanthropy Project.'),
  ('Berkeley Existential Risk Initiative','Machine Intelligence Research Institute',300000,'2020-03-02','day','donation log','AI safety','http://existence.org/grants/',NULL,NULL,NULL,
  /* donation_process */ NULL,
  /* intended_use_of_funds_category */ 'Organizational general support',
  /* intended_use_of_funds */ NULL,
  /* intended_funding_timeframe_in_months */ NULL,
  /* donor_donee_reason */ NULL,
  /* donor_amount_reason */ NULL,
  /* donor_timing_reason */ NULL,
  /* donor_next_donation_thoughts */ NULL,
  /* donor_retrospective */ NULL,
  /* notes */ 'The grant is mentioned by MIRI in the blog post https://intelligence.org/2020/04/27/miris-largest-grant-to-date/ along with a large grant https://www.openphilanthropy.org/focus/global-catastrophic-risks/potential-risks-advanced-artificial-intelligence/machine-intelligence-research-institute-general-support-2020 from the Open Philanthropy Project. The post says: "at the time of our 2019 fundraiser, we expected to receive a grant from BERI in early 2020, and incorporated this into our reserves estimates. However, we predicted the grant size would be $600k; now that we know the final grant amount, that estimate should be $300k lower."');

/* The remaining grants are automatically generated with possible small modifications */

insert into donations(donor,donee,donation_earmark,amount,donation_date,donation_date_precision,donation_date_basis,cause_area,url,notes) values
    ('Berkeley Existential Risk Initiative','Future of Life Institute',NULL,100000,'2017-10-27','day','donation log','AI safety','https://web.archive.org/web/20180731180958/http://existence.org:80/grants https://web.archive.org/web/20180921215949/http://existence.org/organization-grants/',NULL)
    ,('Berkeley Existential Risk Initiative','Future of Life Institute',NULL,50000,'2017-10-27','day','donation log','AI safety','https://web.archive.org/web/20180731180958/http://existence.org:80/grants https://web.archive.org/web/20180921215949/http://existence.org/organization-grants/','For general support. See announcement at http://existence.org/2017/11/03/activity-update-october-2017.html')
    ,('Berkeley Existential Risk Initiative','Institute for Philosophical Research',NULL,25000,'2017-12-15','day','donation log','Existential risks','https://web.archive.org/web/20180731180958/http://existence.org:80/grants https://web.archive.org/web/20180921215949/http://existence.org/organization-grants/',NULL)
    ,('Berkeley Existential Risk Initiative','Association for the Advancement of Artificial Intelligence',NULL,20000,'2017-12-18','day','donation log','AI safety','https://web.archive.org/web/20180731180958/http://existence.org:80/grants https://web.archive.org/web/20180921215949/http://existence.org/organization-grants/','To support the conference on Artificial Intelligence, Ethics, and Society. See announcement at http://existence.org/2017/12/01/activity-update-november-2017.html')
    ,('Berkeley Existential Risk Initiative','Center for Applied Rationality',NULL,100000,'2017-12-27','day','donation log','AI safety','https://web.archive.org/web/20180731180958/http://existence.org:80/grants https://web.archive.org/web/20180921215949/http://existence.org/organization-grants/','See announcement at http://existence.org/2018/01/11/activity-update-december-2017.html')
    ,('Berkeley Existential Risk Initiative','Miles Brundage',NULL,32500,'2018-01-02','day','donation log','AI safety','https://web.archive.org/web/20180731180958/http://existence.org:80/grants',NULL)
    ,('Berkeley Existential Risk Initiative','Global Catastrophic Risk Institute',NULL,25000,'2018-01-24','day','donation log','Existential risks','https://web.archive.org/web/20180731180958/http://existence.org:80/grants https://web.archive.org/web/20180921215949/http://existence.org/organization-grants/','For general support; grant via Social and Environmental Entrepreneurs')
    ,('Berkeley Existential Risk Initiative','Center for Applied Rationality',NULL,800000,'2018-01-26','day','donation log','AI safety','https://web.archive.org/web/20180731180958/http://existence.org:80/grants https://web.archive.org/web/20180921215949/http://existence.org/organization-grants/','General support for the purpose of a permanent venue for CFAR workshops. See announcement at http://existence.org/2018/02/08/activity-update-january-2018.html')
    ,('Berkeley Existential Risk Initiative','Lightcone Infrastructure',NULL,100000,'2018-02-08','day','donation log','Epistemic institutions','https://web.archive.org/web/20180731180958/http://existence.org:80/grants','Grant via the Center for Applied Rationality for the support of activities to develop and improve the website LessWrong 2.0. See announcement at http://existence.org/2018/04/07/activity-update-february-and-march-2018.html')
    ,('Berkeley Existential Risk Initiative','Association for the Advancement of Artificial Intelligence',NULL,5000,'2018-03-30','day','donation log','AI safety','https://web.archive.org/web/20180731180958/http://existence.org:80/grants https://web.archive.org/web/20180921215949/http://existence.org/organization-grants/','Grant in support of the 2018 Spring Symposium on AI and Society: Ethics, Safety and Trustworthiness in Intelligent Agents. See announcement at http://existence.org/2018/04/07/activity-update-february-and-march-2018.html')
    ,('Berkeley Existential Risk Initiative','Centre for the Study of Existential Risk',NULL,200000,'2018-04-06','day','donation log','AI safety','https://web.archive.org/web/20180921215949/http://existence.org/organization-grants/','For general suppotr; grant via Cambridge in America')
    ,('Berkeley Existential Risk Initiative','Future of Life Institute',NULL,300000,'2018-04-10','day','donation log','AI safety','https://web.archive.org/web/20180905034853/http://existence.org/organization-grants/ https://web.archive.org/web/20180921215949/http://existence.org/organization-grants/','General support')
    ,('Berkeley Existential Risk Initiative','Theiss Research',NULL,50000,'2018-07-12','day','donation log','AI safety','https://web.archive.org/web/20180921215949/http://existence.org/organization-grants/','Intended to support Carrick Flynn’s research with Allan DaFoe at the Future of Humanity Institute. Announced at http://existence.org/2018/09/18/activity-update-july-and-august-2018.html')
    ,('Berkeley Existential Risk Initiative','Center for Applied Rationality',NULL,300000,'2018-07-24','day','donation log','AI safety','https://web.archive.org/web/20180921215949/http://existence.org/organization-grants/','General support. Announced at http://existence.org/2018/09/18/activity-update-july-and-august-2018.html and at http://www.rationality.org/resources/updates/2018/august-newsletter (CFAR lists $600,000 over two years as the amount)')
    ,('Berkeley Existential Risk Initiative','UC Berkeley Foundation',NULL,400000,'2018-07-24','day','donation log','AI safety','https://web.archive.org/web/20180921215949/http://existence.org/organization-grants/','Intended to support Andrew Critch’s work at the Center for Human-compatible AI. Announced at http://existence.org/2018/09/18/activity-update-july-and-august-2018.html')
    ,('Berkeley Existential Risk Initiative','Lightcone Infrastructure',NULL,150000,'2018-09-04','day','donation log','AI safety','https://web.archive.org/web/20180921215949/http://existence.org/organization-grants/','Given via the Center for Applied Rationality. To support the development of LessWrong 2.0. Announced at http://existence.org/2018/09/18/activity-update-july-and-august-2018.html')
    ,('Berkeley Existential Risk Initiative','Institute for Philosophical Research',NULL,50000,'2018-09-07','day','donation log','AI safety','https://web.archive.org/web/20180921215949/http://existence.org/organization-grants/','General support. Announced at http://existence.org/2018/09/18/activity-update-july-and-august-2018.html')
    ,('Berkeley Existential Risk Initiative','Luca Rade',NULL,20400,'2018-09-24','day','donation log','AI safety','https://web.archive.org/web/20181019174535/http://existence.org/grants-list/','“to research the implications of coarse-graining by an agent in a complex environment for AI alignment”')
    ,('Berkeley Existential Risk Initiative','Jordan Alexander',NULL,1900,'2018-09-24','day','donation log','AI safety','https://web.archive.org/web/20181019174535/http://existence.org/grants-list/','“to host several meetings at Stanford EA and the Stanford Transhumanist Association”')
    ,('Berkeley Existential Risk Initiative','Bryce Hidysmith',NULL,20500,'2018-09-24','day','donation log','AI safety','https://web.archive.org/web/20181019174535/http://existence.org/grants-list/','“to analyze global risks from technology through a geopolitical lens”')
    ,('Berkeley Existential Risk Initiative','David Manheim',NULL,25000,'2018-09-26','day','donation log','AI safety','https://web.archive.org/web/20181019174535/http://existence.org/grants-list/','“to research aspects of Goodhart’s law, focusing on multi-agent dynamics”. Probably related to https://arxiv.org/pdf/1803.04585.pdf')
    ,('Berkeley Existential Risk Initiative','Roxanne Heston',NULL,49532,'2018-10-02','day','donation log','AI safety','https://web.archive.org/web/20181019174535/http://existence.org/grants-list/','“to work on a variety of AI policy projects in Washington, D.C.”')
    ,('Berkeley Existential Risk Initiative','Baeo Maltinsky',NULL,55000,'2018-10-02','day','donation log','AI safety','https://web.archive.org/web/20181019174535/http://existence.org/grants-list/','“to further his research on AI and technology trends”')
    ,('Berkeley Existential Risk Initiative','Zoe Cremer',NULL,25200,'2018-10-02','day','donation log','AI safety','https://web.archive.org/web/20181019174535/http://existence.org/grants-list/','“to support her as a visiting fellow at CFI, where she will research disagreements about the amount and kind of structure required for AGI”')
    ,('Berkeley Existential Risk Initiative','Colleen McKenzie',NULL,51000,'2018-10-02','day','donation log','AI safety','https://web.archive.org/web/20181019174535/http://existence.org/grants-list/','“to support her research on AI timelines and the processes that produce technical and scientific progress”')
    ,('Berkeley Existential Risk Initiative','Cambridge in America',NULL,10000,'2018-10-02','day','donation log','AI safety','https://web.archive.org/web/20181019174535/http://existence.org/grants-list/','“for the support of the Leverhulme Centre for the Future of Intellgience”')
    ,('Berkeley Existential Risk Initiative','Stephanie Zolayvar',NULL,100000,'2018-10-09','day','donation log','AI safety','https://web.archive.org/web/20181019174535/http://existence.org/grants-list/','“to train herself in circling and host circles for people who are promising contributors to reducing x-risk”')
    ,('Berkeley Existential Risk Initiative','Jessica Taylor',NULL,10000,'2018-10-10','day','donation log','AI safety','https://web.archive.org/web/20181019174535/http://existence.org/grants-list/','“to work on her research in AI alignment and other areas”')
    ,('Berkeley Existential Risk Initiative','Ben Goldhaber',NULL,150000,'2018-10-10','day','donation log','AI safety','https://web.archive.org/web/20181019174535/http://existence.org/grants-list/','“to support his project (co-lead by Jacob Lagerros) to bring x-risk-relevant questions to popular prediction platforms”')
    ,('Berkeley Existential Risk Initiative','Association for the Advancement of Artificial Intelligence',NULL,20000,'2018-10-15','day','donation log','AI safety','https://web.archive.org/web/20181019174535/http://existence.org/grants-list/','“for the support of the 2019 conference on AI, Ethics, and Society”')
    ,('Berkeley Existential Risk Initiative','Effective Altruism Sweden',NULL,4000,'2018-10-18','day','donation log','Existential risks','https://web.archive.org/web/20181107040049/http://existence.org/grants-list/','“to support Markus Stoor’s project to coordinate two follow-up lunch-to-lunch meetings in Sweden for x-risk-focused individuals”')
    ,('Berkeley Existential Risk Initiative','Berkeley REACH','Sarah Spikes',24000,'2018-10-23','day','donation log','Rationality community','https://web.archive.org/web/20181107040049/http://existence.org/grants-list/','Grant “to implement improvements in support of the Rationality and Effective Altruism Community Hub (REACH)” BERI support is mentioned on the REACH Patreon page: "In October 2018, BERI (Berkeley Existential Risk Initiative) awarded a grant of $24k toward REACH operations for 2018-2019. So far, $10k of that has been dispersed as salary for the REACH Manager, Sarah “Stardust” Spikes."')
    ,('Berkeley Existential Risk Initiative','Justin Shovelain',NULL,100000,'2018-10-24','day','donation log','Existential risks','https://web.archive.org/web/20181107040049/http://existence.org/grants-list/','“to lead and develop Convergence Analysis, a new group focused on x-risk strategy research”')
    ,('Berkeley Existential Risk Initiative','Sebastian Farquhar',NULL,12000,'2018-10-31','day','donation log','AI safety','https://web.archive.org/web/20181107040049/http://existence.org/grants-list/','“to attend conferences and purchase compute for experiments related to his PhD research on uncertainty modeling in neural networks”')
    ,('Berkeley Existential Risk Initiative','Lucius Caviola',NULL,44353,'2018-12-27','day','donation log','Existential risk','http://web.archive.org/web/20190623203105/http://existence.org/grants/','Research on the psychology of existential risk')
    ,('Berkeley Existential Risk Initiative','Leverage Research',NULL,25000,'2019-01-22','day','donation log','Existential risk','http://web.archive.org/web/20190623203105/http://existence.org/grants/','The grant follows a solicitation of feedback on Leverage ond related orgs http://existence.org/testimonials-ipr-leverage-paradigm/')
    ,('Berkeley Existential Risk Initiative','Stefan Schubert',NULL,86580,'2019-01-24','day','donation log','Existential risk','http://web.archive.org/web/20190623203105/http://existence.org/grants/','Research on the psychology of existential risk')
    ,('Berkeley Existential Risk Initiative','Alliance to Feed the Earth in Disasters',NULL,25000,'2019-03-12','day','donation log','Existential risk','http://web.archive.org/web/20190623203105/http://existence.org/grants/',NULL)
    ,('Berkeley Existential Risk Initiative','Americans for Oxford','Yarin Gal',25000,'2019-04-08','day','donation log','Existential risk','http://web.archive.org/web/20190623203105/http://existence.org/grants/',NULL)
    ,('Berkeley Existential Risk Initiative','Leverage Research',NULL,50000,'2019-04-09','day','donation log','Existential risk','http://web.archive.org/web/20190623203105/http://existence.org/grants/',NULL)
    ,('Berkeley Existential Risk Initiative','80,000 Hours',NULL,350000,'2019-04-22','day','donation log','Career planning','http://web.archive.org/web/20190623203105/http://existence.org/grants/','The grant is mentioned by the recipient, 80,000 Hours, in a blog post https://80000hours.org/2019/05/annual-review-dec-2018/ along with grants from the Open Philanthropy Project and the Effective Altruism Funds Meta Fund')
    ,('Berkeley Existential Risk Initiative','Future of Life Institute',NULL,50000,'2019-04-22','day','donation log','AI safety','http://web.archive.org/web/20190623203105/http://existence.org/grants/',NULL)
    /* Handoff to Survival and Flourishing Fund */
    ,('Berkeley Existential Risk Initiative','Survival and Flourishing Fund',NULL,200000,'2019-09-07','day','date of donation announcement',NULL,'http://existence.org/tallinn-grants-future/','Handoff of funds donated by Jaan Tallinn, so that grantmaking for these funds can be handled by the Survival and Flourishing Fund. This is because BERI no longer wants to manage grantmaking for these funds')
    ,('Jaan Tallinn','Berkeley Existential Risk Initiative',NULL,2000000,'2017-01-01','year','donee contributor list','AI safety','http://existence.org/grants',NULL)
    ,('Jaan Tallinn','Berkeley Existential Risk Initiative',NULL,5000000,'2017-12-01','month','donee contributor list','AI safety','http://existence.org/2018/01/11/activity-update-december-2017.html','Donation amount approximate')
    ,('Anonymous','Berkeley Existential Risk Initiative',NULL,100000,'2017-12-01','month','donee contributor list','AI safety','http://existence.org/2018/01/11/activity-update-december-2017.html',NULL)
    ,('Casey and Family Foundation','Berkeley Existential Risk Initiative',NULL,100000,'2017-12-01','month','donee contributor list','AI safety','http://existence.org/2018/01/11/activity-update-december-2017.html',NULL)
;
