insert into donors(donor, donor_type, country, facebook_username, website, donations_url, lesswrong_username, linkedin_username,affiliated_orgs,eaf_username, eahub_username,github_username,twitter_username, predictionbook_username, philosophy_url, grant_application_process_url, donations_data_update_regularity, donations_data_dlw_update_regularity, donations_data_update_lag, donations_data_dlw_update_lag, dlw_data_processing_script, wikipedia_page,best_overview_url,brief_history,brief_donor_focus_notes,grant_decision_logistics_notes,grant_publication_logistics_notes,grant_financing_notes,notes) values
  ('Bill and Melinda Gates Foundation','Private foundation','United States','gatesfoundation','https://www.gatesfoundation.org/','https://www.gatesfoundation.org/How-We-Work/Quick-Links/Grants-Database', NULL, 'bill-&-melinda-gates-foundation', NULL, NULL, NULL, NULL, 'gatesfoundation', NULL, 'https://www.gatesfoundation.org/What-We-Do','https://www.gatesfoundation.org/How-We-Work/General-Information/Grantseeker-FAQ','continuous updates','irregular','months','years','https://github.com/riceissa/gates-foundation-iati-processing',
  'https://en.wikipedia.org/wiki/Bill_%26_Melinda_Gates_Foundation',
  'https://en.wikipedia.org/wiki/Bill_%26_Melinda_Gates_Foundation',
  'The Gates Foundation launched in 2000, with precursors starting in the 1990s, financed by the personal wealth of co-founder Bill Gates from Microsoft. Starting 2005, it scaled up its giving significantly after a large funding commitment from Warren Buffett',
  'See https://www.gatesfoundation.org/Who-We-Are/General-Information/Foundation-Factsheet for the grantmaking areas. The four grantmaking areas are the Global Development Program, Global Health Program, Global Policy and Advocacy, and United States Program. Within the United States Program the focus is on K-12 education, the Internet, and emergency relief',
  NULL,
  'Although the Gates Foundation has a grants database on its website, as well as individual grant pages for every grant, we use the IATI data instead, because it can be processed programmatically (the data on the site does not allow for full data download or easy programmatic processing). This leads to a few problems: first, IATI data does not include grants made in the United States, since it focuses on development assistance (DA) spending. Second, IATI data is updated more infrequently. Third, it may sometimes omit some information that is present in the grants database',
  NULL,
  NULL),

  ('Google.org','Private foundation','United States',NULL,'https://www.google.org/','https://www.google.org/our-work/', NULL, NULL, NULL, NULL, NULL, NULL, 'Googleorg', NULL, NULL,NULL,'continuous updates','irregular','months','years',NULL,
  'https://en.wikipedia.org/wiki/Google.org',
  'https://en.wikipedia.org/wiki/Google.org',
  'Founded in October 2005 as the charity arm of tech giant Google',
  'Stated focus areas of education, economic opportunity, inclusion, and crisis response. See https://www.google.org/our-work/ for more details',
  NULL,
  'Most grants do not have individual grant pages, but the biggest ones do. Google.org has a JS-heavy site where they list their donations. We did not find a way to programmatically process the donations. We manually entered all their donations at some point in time, but are not incrementally updating in a scalable way right now',
  NULL,
  NULL),
  
  ('Laura and John Arnold Foundation','Private foundation','United States','Laura-and-John-Arnold-Foundation-177757582300684','http://www.arnoldfoundation.org/','http://www.arnoldfoundation.org/grants/',NULL,NULL,NULL,NULL,NULL,NULL,'lja_foundation',NULL,NULL,NULL, 'quarterly refresh', 'quarterly refresh', 'months', 'days','https://github.com/riceissa/arnold-foundation-grants',
  'https://en.wikipedia.org/wiki/Laura_and_John_Arnold_Foundation',
  'https://en.wikipedia.org/wiki/Laura_and_John_Arnold_Foundation',
  ' The foundation, started in 2008, has ramped up spending over time',
  ' The foundation is making big bets in its focus areas of criminal justice reform, education (K-12), public accountability (pension reform, United States), and research integrity',
  NULL,
  'Grants are published on the grants page, which is updated quarterly. There are no individual grant pages',
   NULL,
   NULL),
   
  ('Open Philanthropy Project','Private foundation','United States','openphilanthropy','https://www.openphilanthropy.org/','https://www.openphilanthropy.org/giving/grants',NULL,NULL,'GiveWell,Good Ventures',NULL,NULL,NULL,'open_phil','OpenPhilUnofficial','https://www.openphilanthropy.org/about/vision-and-values','https://www.openphilanthropy.org/giving/guide-for-grant-seekers','continuous updates','continuous updates', 'months', 'days', NULL,
  NULL,
  'https://causeprioritization.org/Open%20Philanthropy%20Project',
  'The Open Philanthropy Project (Open Phil for short) spun off from GiveWell, starting as GiveWell Labs in 2011, beginning to make strong progress in 2013, and formally separating from GiveWell in June 2017',
  'The Open Philanthropy Project is focused on openness in two ways: open to ideas about cause selection, and open in explaining what they are doing. It has endorsed "hits-based giving" and is working on areas of AI risk, biosecurity and pandemic preparedness, and other global catastrophic risks, criminal justice reform (United States), animal welfare, and some other areas.',
  'See https://www.openphilanthropy.org/blog/our-grantmaking-so-far-approach-and-process for the general grantmaking process. Every grant has a grant investigator that we call the influencer here on Donations List Website; for focus areas that have Program Officers, the grant investigator is usually the Program Officer. The grant investigator has been included in grants published since around July 2017. Grants usually need approval from an executive; however, some grant investigators have leeway to make "discretionary grants" where the approval process is short-circuited; see https://www.openphilanthropy.org/giving/grants/discretionary-grants for more. Note that the term "discretionary grant" means something different for them compared to government agencies, see https://www.facebook.com/vipulnaik.r/posts/10213483361534364 for more',
   'Every publicly disclosed grant has a writeup published at the time of public disclosure, but the writeups vary significantly in length. Grant writeups are usually written by somebody other than the grant investigator, but approved by the grant investigator as well as the grantee. Grants have three dates associated with them: an internal grant decision date (that is not publicly revealed but is used in some statistics on total grant amounts decided by year), a grant date (which we call donation date; this is the date of the formal grant commitment, which is the published grant date), and a grant announcement date (which we call donation announcement date; the date the grant is announced to the mailing list and the grant page made publicly visible). Lags are a few months between decision and grant, and a few months between grant and announcement, due to time spent with grant writeup approval',
  'See https://www.openphilanthropy.org/giving/guide-for-grant-seekers or https://www.openphilanthropy.org/about/who-we-are for more information. Grants generally come from the Open Philanthropy Project Fund, a donor-advised fund managed by the Silicon Valley Community Foundation, with most of its money coming from Good Ventures. Some grants are made directly by Good Ventures, and political grants may be made by the Open Philanthropy Action Fund. At least one grant https://www.openphilanthropy.org/focus/us-policy/criminal-justice-reform/working-families-party-prosecutor-reforms-new-york was made by Cari Tuna personally. The majority of grants are financed by the Open Philanthropy Project Fund; however, the source of financing of a grant is not always explicitly specified, so it cannot be confidently assumed that a grant with no explicit listed financing is financed through the Open Philanthropy Project Fund; see the comment https://www.openphilanthropy.org/blog/october-2017-open-thread?page=2#comment-462 for more information. Funding for multi-year grants is usually disbursed annually, and the amounts are often equal across years, but not always. The fact that a grant is multi-year, or the distribution of the grant amount across years, are not always explicitly stated on the grant page; see https://www.openphilanthropy.org/blog/october-2017-open-thread?page=2#comment-462 for more information. Some grants to universities are labeled "gifts" but this is a donee classification, based on different levels of bureaucratic overhead and funder control between grants and gifts; see https://www.openphilanthropy.org/blog/october-2017-open-thread?page=2#comment-462 for more information.',
  'Most GiveWell-recommended grants made by Good Ventures and listed in the Open Philanthropy Project database are not listed on Donations List Website as being under Open Philanthropy Project. Specifically, GiveWell Incubation Grants are not included (these are listed at https://donations.vipulnaik.com/donor.php?donor=GiveWell+Incubation+Grants with donor GiveWell Incubation Grants), and grants made by Good Ventures to GiveWell top and standout charities are also not included (these are listed at https://donations.vipulnaik.com/donor.php?donor=Good+Ventures%2FGiveWell+top+and+standout+charities with donor Good Ventures/GiveWell top and standout charities). Grants to support GiveWell operations are not included here; they can be found at https://donations.vipulnaik.com/donor.php?donor=Good+Ventures%2FGiveWell+support with donor "Good Ventures/GiveWell support".The investment https://www.openphilanthropy.org/focus/us-policy/farm-animal-welfare/impossible-foods in Impossible Foods is not included because it does not fit our criteria for a donation, and also because no amount was included. All other grants publicly disclosed by the Open Philanthropy Project that are not GiveWell Incubation Grants or GiveWell top and standout charity grants should be included. Grants disclosed by grantees but not yet disclosed by the Open Philanhtropy Project are not included; some of them may be listed at https://issarice.com/open-philanthropy-project-non-grant-funding'),

  ('Public Welfare Foundation','Private foundation','United States','Public-Welfare-Foundation-371167644067','http://www.publicwelfare.org/', 'http://www.publicwelfare.org/grants-process/our-grants/', NULL, '9164304', NULL, NULL, NULL, NULL, 'PublicWelfare', NULL, 'http://www.publicwelfare.org/about-us/','http://www.publicwelfare.org/grants-process/apply-for-a-grant/',NULL,'quarterly refresh','months','months',
  'https://github.com/riceissa/public-welfare-foundation',
  'https://en.wikipedia.org/wiki/Public_Welfare_Foundation',
  'http://www.publicwelfare.org/grants-process/program-guidelines/',
  'The Public Welfare Foundation was founded in 1947. It was overseen by Charles E. Marsh till 1953, then by his wife till 1974',
  'The three historical main areas were criminal justice reform, youth justice, and worker rights. In 2011 it added a special initiative for civil legal aid. All initiatives seem restricted to the United States',
  'Grant applications have to be submitted through a process described at http://www.publicwelfare.org/grants-process/apply-for-a-grant/ and http://www.publicwelfare.org/grants-process/ and have to fit within the program guidelines described at http://www.publicwelfare.org/grants-process/program-guidelines/',
  'Grants are published on the grants page http://www.publicwelfare.org/grants-process/our-grants/ where they can be filtered by category and by fiscal year. Pages on individual grants are not published',
  NULL,
  'The foundation was included because it has been mentioned by the Open Philanthropy Project as one of the important funders of criminal justice reform in the United States, see for instance https://www.openphilanthropy.org/focus/us-policy/criminal-justice-reform/criminal-justice-reform-strategy'),

  ('GiveWell Incubation Grants','Subsidiary','United States',NULL,'https://www.givewell.org/research/incubation-grants','https://www.givewell.org/research/incubation-grants',NULL,NULL,'GiveWell,Good Ventures',NULL,NULL,NULL,NULL,NULL,NULL,NULL, 'continuous updates', 'continuous updates', 'months', 'days', NULL,
  NULL,
  'https://www.givewell.org/research/incubation-grants',
  'GiveWell Incubation Grants start off as GiveWell Experimental, with the goal of supporting the growth and discovery of future GiveWell top charities',
  'The focus is on charities that have a decent chance (usually, 10% or more at the time of the grant) of becoming GiveWell top charities, and also on academic research or evaluation processes that would help better evaluate or help improve current or future GiveWell top charities',
  'Organizations may apply by contacting info@givewell.org but more details on the decision process are not publicly stated',
  'Each grant has a separate page. The grant has four associated dates: a grant date (called donation date on the Donations List Website; this is the date the grant is made), a grant announcement date (called donation announcement date; this is the date the grant page is made public and announced on the mailing list), and dates that the grant is made public in the grants databases on the websites of the Open Philanthropy Project and Good Ventures. The latter two dates do not concern us, since they essentially just link to the GiveWell Incubation Grants grant page. The grant page is reviewed by grantee staff prior to publication',
  'After GiveWell decides on a grant, the grant is recommended to the Open Philanthropy Project, which in turn recommends to Good Ventures to fund the grant. Historically, grant requests were made directly to Good Ventures, and even now, in practice, the intermediate role of the Open Philanthropy Project is mostly just a formality. For these reasons, the cross-posting of the grants to the Open Philanthropy Project and Good Ventures pages is not of substantive interest to us. Even though the grants are listed in the Open Philanthropy Project database, they are not included in Open Philanthropy Project self-reports of how much grant money they decided on',
  'List last checked for completeness and accuracy on 2017-12-24'),

  ('Good Ventures/GiveWell top and standout charities','Subsidiary','United States',NULL,NULL,NULL,NULL,NULL,'GiveWell,Good Ventures,Open Philanthropy Project',NULL,NULL,NULL,NULL,NULL,NULL,NULL, 'continuous updates', 'continuous updates', 'months', 'days', NULL,
   NULL,
   NULL,
   'Starting in 2011, when GiveWell first started working with Good Ventures, Good Ventures has been making grants to GiveWell top and standout charities. Over time, they have worked more closely together on deciding the amounts to be granted, and incorporating these into the room for more funding that is communicated to other donors. The grants are almost always announced along with the year-end recommendation refresh in late November. Starting 2016, the decision of "how much in total to allocate" was moved over to the Open Philanthropy Project, and the grants began being listed in the Open Philanthropy Project database. The decision on how to split the allocation between specific top and standout charities remains with GiveWell',
   'The focus areas are the areas that GiveWell top and standout charities operate in, which are usually global health and development. Top areas in recent years have included malaria, deworming, vitamin A supplementation, cash transfers, and seasonal intracountry migration',
   'GiveWell receives a total budget from the Open Philanthropy Project of money that can be granted to top charities. The budget was $50 million in end 2016 and $75 million in end 2017. It grants some minimum amount to all top charities ($2.5 million per charity in 2017) and a smaller minimum amoun to all standout charities ($100,000 in 2017). For the rest of its total allocated amount, it allocates the money to the highest-priority funding gaps, using a greedy algorithm. Some top charities may end up getting no money other than the $2.5 million minimum. According to https://blog.givewell.org/2017/11/27/our-top-charities-for-giving-season-2017/#comment-946042 the willingness of other donors to fund specific charities is not a factor in the decision',
   'The grants are not published separately on the GiveWell website; rather, the amounts and rationale are described in a long blog post along with the description of the refreshed top charity recommendations (see https://blog.givewell.org/2017/11/27/our-top-charities-for-giving-season-2017/ for the 2017 version). The grants later show up in the databases of the Open Philanthropy Project (that signs off on them, despite not being involved in the individual grant decisions) and Good Ventures (that provides the actual financing)',
   'The financing for the grants comes from Good Ventures, which may give the money directly or via the Open Philanthropy Project Fund held by the Silicon Valley Community Foundation. The total budget is set by the Open Philanthropy Project. The actual grants are usually made between December and February, after the announcement of the grant amounts in November.',
   'For grants already published in the Good Ventures database, we use the date there as the authoritative grant date. For grants not yet published, we use the date of the donation announcement'),
  ('Good Ventures/not recommended by GiveWell or Open Philanthropy Project','Subsidiary','United States',NULL,NULL,NULL,NULL,NULL,'Good Ventures',NULL,NULL,NULL,NULL,NULL,NULL,NULL, 'continuous updates', 'irregular', 'months', 'months',NULL,
   NULL,
   NULL,
   'Historically, Good Ventures and GiveWell worked together but were separate entities, and Good Ventures made a number of grants based on the beliefs and interets of Dustin Moskovitz and Cari Tuna; in some cases these were helped by some GiveWell research. As GiveWell Labs began taking off and morphed into the Open Philanthropy Project, the majority of Good Ventures money moved shifted to the Open Philanthropy Project, and most of the rest was to GiveWell top and standout charities. Other than that, they also support GiveWell operations. The grants listed here are basically all the grants that may be informed by GiveWell or Open Philanthropy Project research but are not directly recommended by GiveWell or the Open Philanthropy Project, and do not support GiveWell operations',
   'Focus areas here include "marriage equality", drug policy, and education. Decisions in drug policy are sometimes assisted by research of the Open Philanthropy Project but the grants themselves are not recommended by the Open Philanthropy Project. Recently, some funding for Alzheimers disease based on Open Philanthropy Project study has been funded separately by Good Ventures, see https://www.openphilanthropy.org/blog/update-investigating-neglected-goals-biological-research',
  NULL,
  'Grant pages are published on the Good Ventures website, generally within a few months after the grant is made',
  'Financing for these grants is provided by Good Ventures. The exact financing mechanism is not clear',
  'See also http://effective-altruism.com/ea/10l/june_2016_givewell_board_meeting/#relationship-with-good-ventures "51:59: Cari and Dustin aren’t tied down, they have their own thing"'),
  ('GiveWell discretionary regranting','Subsidiary','United States',NULL,NULL,NULL,NULL,NULL,'GiveWell',NULL,NULL,NULL,NULL,NULL,'https://blog.givewell.org/2016/12/19/discretionary-grant-making-and-implications-for-donor-agency/',NULL,'continuous updates','continuous updates','days','days',NULL,
  NULL,
  'https://blog.givewell.org/2016/12/19/discretionary-grant-making-and-implications-for-donor-agency/',
  'GiveWell has given donors the option to give money to Givewell to allocate to top charities. This differed from simply giving to GiveWell top charities using the recommended allocation, because GiveWell would determine the best use of marginal funds at the time of each regrant decision. GiveWell began highlighting discretionary regranting in late 2016, and announced some major discretionary regrants in 2017. For giving seasons 2017, Givewell recommended that donors give to GiveWell for discretionary regranting',
  'Same focus areas that inform GiveWell top charity recommendations. Top areas in recent years have included malaria, deworming, vitamin A supplementation, cash transfers, and seasonal intracountry migration',
  'For each discretionary regrant, which may be done about once a quarter, GiveWell looks at the most pressing of the needs of its top charities, and regrants funds based on those. Grant decisions have to be approved by the board',
  'In 2017, decisions were published in blog posts. As per https://blog.givewell.org/2017/09/12/september-open-thread/#comment-946059 and https://blog.givewell.org/2017/11/27/our-top-charities-for-giving-season-2017/#comment-946301 GiveWell plans to add a page listing all discretionary regrants',
  'Money for the grants mostly comes from funds donated by donors to "GiveWell top charities" for regranting at its discretion. In the case of regrant to the Against Malaria Foundation, the original donors show up in the Against Malaria Foundation donor list',
  NULL),
  ('Effective Altruism Funds','Subsidiary','United Kingdom',NULL,'https://app.effectivealtruism.org/','http://effective-altruism.com/ea/19d/update_on_effective_altruism_funds/',NULL,NULL,'Centre for Effective Altruism',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'irregular','irregular','months','days',NULL,
  NULL,
  NULL,
  'The funds are a program of the Centre for Effective Altruism (CEA). Thecreation of the funds was inspired by the success of the EA Giving Group donor-advised fund run by Nick Beckstead, and also by the donor lottery run in December 2016 by Paul Christiano and Carl Shulman (see http://effective-altruism.com/ea/14d/donor_lotteries_demonstration_and_faq/ for more). EA Funds were introduced on 2017-02-09 in the post http://effective-altruism.com/ea/174/introducing_the_ea_funds/ and launched on 2017-02-28 in the post http://effective-altruism.com/ea/17v/ea_funds_beta_launch/ The first round of allocations was announced on 2017-04-20 at http://effective-altruism.com/ea/19d/update_on_effective_altruism_funds/ The funds allocation information appears to have next been updated in November 2017; see https://www.facebook.com/groups/effective.altruists/permalink/1606722932717391/ for more',
  'There are four EA Funds, each with its own focus area and own fund manager: Global Health and Development (Elie Hassenfeld of GiveWell), Animal Welfare (Lewis Bollard of the Open Philanthropy Project), Long Term Future and EA Community (both managed by Nick Beckstead of the Open Philanthropy Project)',
  'Grants are decided separately within each of the four funds, by the manager of that fund. Allocation of the money may take about a month after the grant decision. Fund managers generally allocate multiple grants together with a bunch of money collected over the last few months',
  'Grant details are published on the EA Funds website, and linked to from the page on the specific Fund. Grants allocated together are generally published together on a single page',
  'Finances for each of the funds are maintained separately: individual donors can donate to a specific fund, or to all funds in a specific proportion specified by them. Only money explicitly donated to a fund can be granted out from that fund. Other money of the Centre for Effective Altruism (CEA) is not granted out through the Funds',
  NULL),

  ('Effective Altruism Grants','Subsidiary','United Kingdom',NULL,'https://www.effectivealtruism.org/grants/','https://docs.google.com/spreadsheets/d/1iBy--zMyIiTgybYRUQZIm11WKGQZcixaCmIaysRmGvk',NULL,NULL,'Centre for Effective Altruism',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'irregular','irregular','months','days','https://github.com/riceissa/ea-grants-processing',
  NULL,
  'http://effective-altruism.com/ea/1fc/effective_altruism_grants_project_update/',
  'Effective Altruism Grants (EA Grants for short) are a successor to Effective Altruism Ventures (see http://effective-altruism.com/ea/1b5/announcing_effective_altruism_grants/ for the announcement post). The first batch of EA Grants was publicly announced at the end of September 2017, totaling about £369,924 (with the remainder up to a total of £500,000 reserved for additional grants to recipients). In https://www.centreforeffectivealtruism.org/blog/cea-s-2017-review-and-2018-plans/ it was announced that EA Grants was moving to a rolling basis for urgent grants and a quarterly frequency of review for less urgent grants',
  'Focus is on filling funding gaps in grants for individuals pursuing early-stage but high-value projects',
  'For 2017, applications had to be made before a deadline. Of the 722 applications received, 413 (57%) were rejected. The second round involved taking the remaining applications and assessing applicants based on their track record, values, and plans. This assessment adhered to a rubric, weighting each category in accordance with its predictive power for project success. 63 candidates passed this round and had three 10-minute interviews, and 22 of them were selected. However, EA Grants is moving in 2018 to a rolling basis for urgent grants and a quarterly basis for other grants, according to https://www.centreforeffectivealtruism.org/blog/cea-s-2017-review-and-2018-plans/',
  'For 2017, all grants were published in a spreadsheet https://docs.google.com/spreadsheets/d/1iBy--zMyIiTgybYRUQZIm11WKGQZcixaCmIaysRmGvk but the long-term plan for sharing grants data is not clear',
  'The £500,000 budget for the first year of Effective Altruism Grants was part of the Centre for Effective Altruism budget, and the costs are covered by the Open Philanthropy Project grant https://www.openphilanthropy.org/giving/grants/centre-effective-altruism-general-support and a couple of other private donors, as described at http://effective-altruism.com/ea/1fc/effective_altruism_grants_project_update/',
  NULL);


# -- insert into donors(donor, donor_type, country, facebook_username, website, donations_url, lesswrong_username, linkedin_username,affiliated_orgs,eaf_username, eahub_username,github_username,twitter_username, predictionbook_username, philosophy_url, grant_application_process_url, donations_data_update_regularity, donations_data_dlw_update_regularity, donations_data_update_lag, donations_data_dlw_update_lag, dlw_data_processing_script, wikipedia_page,best_overview_url,brief_history,brief_donor_focus_notes,grant_decision_logistics_notes,grant_publication_logistics_notes,grant_financing_notes,notes) values
