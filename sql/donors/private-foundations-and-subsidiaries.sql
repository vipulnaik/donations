insert into donors(donor, donor_type, other_names, country, facebook_username, website, donations_url, lesswrong_username, linkedin_username, affiliated_orgs, eaf_username, eahub_username, github_username, twitter_username, predictionbook_username, philosophy_url, grant_application_process_url, donations_data_update_regularity, donations_data_dlw_update_regularity, donations_data_update_lag, donations_data_dlw_update_lag, dlw_data_processing_script, wikipedia_page, best_overview_url, brief_history, brief_donor_focus_notes, grant_decision_logistics_notes, grant_publication_logistics_notes, grant_financing_notes, notes) values
  ('Bill and Melinda Gates Foundation','Private foundation',NULL,'United States','gatesfoundation','https://www.gatesfoundation.org/','https://www.gatesfoundation.org/How-We-Work/Quick-Links/Grants-Database', NULL, 'bill-&-melinda-gates-foundation', NULL, NULL, NULL, NULL, 'gatesfoundation', NULL, 'https://www.gatesfoundation.org/What-We-Do','https://www.gatesfoundation.org/How-We-Work/General-Information/Grantseeker-FAQ','continuous updates','irregular','months','years','https://github.com/riceissa/gates-foundation-iati-processing',
  'https://en.wikipedia.org/wiki/Bill_%26_Melinda_Gates_Foundation',
  'https://en.wikipedia.org/wiki/Bill_%26_Melinda_Gates_Foundation',
  'The Gates Foundation launched in 2000, with precursors starting in the 1990s, financed by the personal wealth of co-founder Bill Gates from Microsoft. Starting 2005, it scaled up its giving significantly after a large funding commitment from Warren Buffett',
  'See https://www.gatesfoundation.org/Who-We-Are/General-Information/Foundation-Factsheet for the grantmaking areas. The four grantmaking areas are the Global Development Program, Global Health Program, Global Policy and Advocacy, and United States Program. Within the United States Program the focus is on K-12 education, the Internet, and emergency relief',
  NULL,
  'Although the Gates Foundation has a grants database on its website, as well as individual grant pages for every grant, we use the IATI data instead, because it can be processed programmatically (the data on the site does not allow for full data download or easy programmatic processing). This leads to a few problems: first, IATI data does not include grants made in the United States, since it focuses on development assistance (DA) spending. Second, IATI data is updated more infrequently. Third, it may sometimes omit some information that is present in the grants database',
  NULL,
  NULL),

  ('Google.org','Private foundation',NULL,'United States',NULL,'https://www.google.org/','https://www.google.org/our-work/', NULL, NULL, NULL, NULL, NULL, NULL, 'Googleorg', NULL, NULL,NULL,'continuous updates','irregular','months','years',NULL,
  'https://en.wikipedia.org/wiki/Google.org',
  'https://en.wikipedia.org/wiki/Google.org',
  'Founded in October 2005 as the charity arm of tech giant Google',
  'Stated focus areas of education, economic opportunity, inclusion, and crisis response. See https://www.google.org/our-work/ for more details',
  NULL,
  'Most grants do not have individual grant pages, but the biggest ones do. Google.org has a JS-heavy site where they list their donations. We did not find a way to programmatically process the donations. We manually entered all their donations at some point in time, but are not incrementally updating in a scalable way right now',
  NULL,
  NULL),
  
  ('Arnold Ventures','Private foundation',NULL,'United States','ArnoldVentures','https://www.arnoldventures.org/','https://www.arnoldventures.org/grants/',NULL,NULL,NULL,NULL,NULL,NULL,'lja_foundation',NULL,NULL,NULL, 'quarterly refresh', 'quarterly refresh', 'months', 'days','https://github.com/riceissa/arnold-foundation-grants',
  'https://en.wikipedia.org/wiki/Arnold_Ventures_LLC',
  'https://en.wikipedia.org/wiki/Arnold_Ventures_LLC',
  ' The foundation, started in 2008, has ramped up spending over time',
  ' The foundation is making big bets in its focus areas of criminal justice reform, education (K-12), public accountability (pension reform, United States), and research integrity',
  NULL,
  'Grants are published on the grants page, which is updated quarterly. There are no individual grant pages',
   NULL,
   'This was formerly the Laura and John Arnold Foundation (LJAF)'),
   
  ('Open Philanthropy','Private foundation','Open Philanthropy Project|Open Phil','United States','openphilanthropy','https://www.openphilanthropy.org/','https://www.openphilanthropy.org/giving/grants',NULL,NULL,'GiveWell|Good Ventures',NULL,NULL,NULL,'open_phil','OpenPhilUnofficial','https://www.openphilanthropy.org/about/vision-and-values','https://www.openphilanthropy.org/giving/guide-for-grant-seekers','continuous updates','continuous updates', 'months', 'days', NULL,
  NULL,
  'https://causeprioritization.org/Open%20Philanthropy%20Project',
  'The Open Philanthropy Project (Open Phil for short) spun off from GiveWell, starting as GiveWell Labs in 2011, beginning to make strong progress in 2013, and formally separating from GiveWell in June 2017',
  'The Open Philanthropy Project is focused on openness in two ways: open to ideas about cause selection, and open in explaining what they are doing. It has endorsed "hits-based giving" and is working on areas of AI risk, biosecurity and pandemic preparedness, and other global catastrophic risks, criminal justice reform (United States), animal welfare, and some other areas.',
  'See https://www.openphilanthropy.org/blog/our-grantmaking-so-far-approach-and-process for the general grantmaking process and https://www.openphilanthropy.org/blog/questions-we-ask-ourselves-making-grant for more questions that grant investigators are encouraged to consider. Every grant has a grant investigator that we call the influencer here on Donations List Website; for focus areas that have Program Officers, the grant investigator is usually the Program Officer. The grant investigator has been included in grants published since around July 2017. Grants usually need approval from an executive; however, some grant investigators have leeway to make "discretionary grants" where the approval process is short-circuited; see https://www.openphilanthropy.org/giving/grants/discretionary-grants for more. Note that the term "discretionary grant" means something different for them compared to government agencies, see https://www.facebook.com/vipulnaik.r/posts/10213483361534364 for more.',
   'Every publicly disclosed grant has a writeup published at the time of public disclosure, but the writeups vary significantly in length. Grant writeups are usually written by somebody other than the grant investigator, but approved by the grant investigator as well as the grantee. Grants have three dates associated with them: an internal grant decision date (that is not publicly revealed but is used in some statistics on total grant amounts decided by year), a grant date (which we call donation date; this is the date of the formal grant commitment, which is the published grant date), and a grant announcement date (which we call donation announcement date; the date the grant is announced to the mailing list and the grant page made publicly visible). Lags are a few months between decision and grant, and a few months between grant and announcement, due to time spent with grant writeup approval.',
  'See https://www.openphilanthropy.org/giving/guide-for-grant-seekers or https://www.openphilanthropy.org/about/who-we-are for more information. Grants generally come from the Open Philanthropy Project Fund, a donor-advised fund managed by the Silicon Valley Community Foundation, with most of its money coming from Good Ventures. Some grants are made directly by Good Ventures, and political grants may be made by the Open Philanthropy Action Fund. At least one grant https://www.openphilanthropy.org/focus/us-policy/criminal-justice-reform/working-families-party-prosecutor-reforms-new-york was made by Cari Tuna personally. The majority of grants are financed by the Open Philanthropy Project Fund; however, the source of financing of a grant is not always explicitly specified, so it cannot be confidently assumed that a grant with no explicit listed financing is financed through the Open Philanthropy Project Fund; see the comment https://www.openphilanthropy.org/blog/october-2017-open-thread?page=2#comment-462 for more information. Funding for multi-year grants is usually disbursed annually, and the amounts are often equal across years, but not always. The fact that a grant is multi-year, or the distribution of the grant amount across years, are not always explicitly stated on the grant page; see https://www.openphilanthropy.org/blog/october-2017-open-thread?page=2#comment-462 for more information. Some grants to universities are labeled "gifts" but this is a donee classification, based on different levels of bureaucratic overhead and funder control between grants and gifts; see https://www.openphilanthropy.org/blog/october-2017-open-thread?page=2#comment-462 for more information.',
  'Most GiveWell-recommended grants made by Good Ventures and listed in the Open Philanthropy Project database are not listed on Donations List Website as being under Open Philanthropy Project. Specifically, GiveWell Incubation Grants are not included (these are listed at https://donations.vipulnaik.com/donor.php?donor=GiveWell+Incubation+Grants with donor GiveWell Incubation Grants), and grants made by Good Ventures to GiveWell top and standout charities are also not included (these are listed at https://donations.vipulnaik.com/donor.php?donor=Good+Ventures%2FGiveWell+top+and+standout+charities with donor Good Ventures/GiveWell top and standout charities). Grants to support GiveWell operations are not included here; they can be found at https://donations.vipulnaik.com/donor.php?donor=Good+Ventures%2FGiveWell+support with donor "Good Ventures/GiveWell support".The investment https://www.openphilanthropy.org/focus/us-policy/farm-animal-welfare/impossible-foods in Impossible Foods is not included because it does not fit our criteria for a donation, and also because no amount was included. All other grants publicly disclosed by the Open Philanthropy Project that are not GiveWell Incubation Grants or GiveWell top and standout charity grants should be included. Grants disclosed by grantees but not yet disclosed by the Open Philanthropy Project are not included; some of them may be listed at https://issarice.com/open-philanthropy-project-non-grant-funding'),

  ('Public Welfare Foundation','Private foundation',NULL,'United States','Public-Welfare-Foundation-371167644067','http://www.publicwelfare.org/', 'http://www.publicwelfare.org/grants-process/our-grants/', NULL, '9164304', NULL, NULL, NULL, NULL, 'PublicWelfare', NULL, 'http://www.publicwelfare.org/about-us/','http://www.publicwelfare.org/grants-process/apply-for-a-grant/',NULL,'quarterly refresh','months','months',
  'https://github.com/riceissa/public-welfare-foundation',
  'https://en.wikipedia.org/wiki/Public_Welfare_Foundation',
  'http://www.publicwelfare.org/grants-process/program-guidelines/',
  'The Public Welfare Foundation was founded in 1947. It was overseen by Charles E. Marsh till 1953, then by his wife till 1974',
  'The three historical main areas were criminal justice reform, youth justice, and worker rights. In 2011 it added a special initiative for civil legal aid. All initiatives seem restricted to the United States',
  'Grant applications have to be submitted through a process described at http://www.publicwelfare.org/grants-process/apply-for-a-grant/ and http://www.publicwelfare.org/grants-process/ and have to fit within the program guidelines described at http://www.publicwelfare.org/grants-process/program-guidelines/',
  'Grants are published on the grants page http://www.publicwelfare.org/grants-process/our-grants/ where they can be filtered by category and by fiscal year. Pages on individual grants are not published',
  NULL,
  'The foundation was included because it has been mentioned by the Open Philanthropy Project as one of the important funders of criminal justice reform in the United States, see for instance https://www.openphilanthropy.org/focus/us-policy/criminal-justice-reform/criminal-justice-reform-strategy'),

  ('GiveWell Incubation Grants','Subsidiary',NULL,'United States',NULL,'https://www.givewell.org/research/incubation-grants','https://www.givewell.org/research/incubation-grants',NULL,NULL,'GiveWell|Good Ventures',NULL,NULL,NULL,NULL,NULL,NULL,NULL, 'continuous updates', 'continuous updates', 'months', 'days', NULL,
  NULL,
  'https://www.givewell.org/research/incubation-grants',
  'GiveWell Incubation Grants start off as GiveWell Experimental, with the goal of supporting the growth and discovery of future GiveWell top charities',
  'The focus is on charities that have a decent chance (usually, 10% or more at the time of the grant) of becoming GiveWell top charities, and also on academic research or evaluation processes that would help better evaluate or help improve current or future GiveWell top charities',
  'Organizations may apply by contacting info@givewell.org but more details on the decision process are not publicly stated',
  'Each grant has a separate page. The grant has four associated dates: a grant date (called donation date on the Donations List Website; this is the date the grant is made), a grant announcement date (called donation announcement date; this is the date the grant page is made public and announced on the mailing list), and dates that the grant is made public in the grants databases on the websites of the Open Philanthropy Project and Good Ventures. The latter two dates do not concern us, since they essentially just link to the GiveWell Incubation Grants grant page. The grant page is reviewed by grantee staff prior to publication',
  'After GiveWell decides on a grant, the grant is recommended to the Open Philanthropy Project, which in turn recommends to Good Ventures to fund the grant. Historically, grant requests were made directly to Good Ventures, and even now, in practice, the intermediate role of the Open Philanthropy Project is mostly just a formality. For these reasons, the cross-posting of the grants to the Open Philanthropy Project and Good Ventures pages is not of substantive interest to us. Even though the grants are listed in the Open Philanthropy Project database, they are not included in Open Philanthropy Project self-reports of how much grant money they decided on. Occasionally, however, grants listed under GiveWell Incubation Grants are financed via Effective Altruism Funds (specifically, the Global Health and Development Fund). We list these grants only under Effective Altruism Funds and not under GiveWell Incubation Grants',
  'List last checked for completeness and accuracy on 2017-12-24'),

  ('Good Ventures/GiveWell top and standout charities','Subsidiary',NULL,'United States',NULL,NULL,NULL,NULL,NULL,'GiveWell|Good Ventures|Open Philanthropy Project',NULL,NULL,NULL,NULL,NULL,NULL,NULL, 'continuous updates', 'continuous updates', 'months', 'days', NULL,
   NULL,
   NULL,
   'Starting in 2011, when GiveWell first started working with Good Ventures, Good Ventures has been making grants to GiveWell top and standout charities. Over time, they have worked more closely together on deciding the amounts to be granted, and incorporating these into the room for more funding that is communicated to other donors. The grants are almost always announced along with the year-end recommendation refresh in late November. Starting 2016, the decision of "how much in total to allocate" was moved over to the Open Philanthropy Project, and the grants began being listed in the Open Philanthropy Project database. The decision on how to split the allocation between specific top and standout charities remains with GiveWell',
   'The focus areas are the areas that GiveWell top and standout charities operate in, which are usually global health and development. Top areas in recent years have included malaria, deworming, vitamin A supplementation, cash transfers, and seasonal intracountry migration',
   'GiveWell receives a total budget from the Open Philanthropy Project of money that can be granted to top charities. The budget was $50 million in end 2016 and $75 million in end 2017. It grants some minimum amount to all top charities ($2.5 million per charity in 2017) and a smaller minimum amoun to all standout charities ($100,000 in 2017). For the rest of its total allocated amount, it allocates the money to the highest-priority funding gaps, using a greedy algorithm. Some top charities may end up getting no money other than the $2.5 million minimum. According to https://blog.givewell.org/2017/11/27/our-top-charities-for-giving-season-2017/#comment-946042 the willingness of other donors to fund specific charities is not a factor in the decision',
   'The grants are not published separately on the GiveWell website; rather, the amounts and rationale are described in a long blog post along with the description of the refreshed top charity recommendations (see https://blog.givewell.org/2017/11/27/our-top-charities-for-giving-season-2017/ for the 2017 version). The grants later show up in the databases of the Open Philanthropy Project (that signs off on them, despite not being involved in the individual grant decisions) and Good Ventures (that provides the actual financing)',
   'The financing for the grants comes from Good Ventures, which may give the money directly or via the Open Philanthropy Project Fund held by the Silicon Valley Community Foundation. The total budget is set by the Open Philanthropy Project. The actual grants are usually made between December and February, after the announcement of the grant amounts in November.',
   'For grants already published in the Good Ventures database, we use the date there as the authoritative grant date. For grants not yet published, we use the date of the donation announcement'),
  ('Good Ventures/not recommended by GiveWell or Open Philanthropy Project','Subsidiary',NULL,'United States',NULL,NULL,NULL,NULL,NULL,'Good Ventures',NULL,NULL,NULL,NULL,NULL,NULL,NULL, 'continuous updates', 'irregular', 'months', 'months',NULL,
   NULL,
   NULL,
   'Historically, Good Ventures and GiveWell worked together but were separate entities, and Good Ventures made a number of grants based on the beliefs and interets of Dustin Moskovitz and Cari Tuna; in some cases these were helped by some GiveWell research. As GiveWell Labs began taking off and morphed into the Open Philanthropy Project, the majority of Good Ventures money moved shifted to the Open Philanthropy Project, and most of the rest was to GiveWell top and standout charities. Other than that, they also support GiveWell operations. The grants listed here are basically all the grants that may be informed by GiveWell or Open Philanthropy Project research but are not directly recommended by GiveWell or the Open Philanthropy Project, and do not support GiveWell operations',
   'Focus areas here include "marriage equality", drug policy, and education. Decisions in drug policy are sometimes assisted by research of the Open Philanthropy Project but the grants themselves are not recommended by the Open Philanthropy Project. Recently, some funding for Alzheimers disease based on Open Philanthropy Project study has been funded separately by Good Ventures, see https://www.openphilanthropy.org/blog/update-investigating-neglected-goals-biological-research',
  NULL,
  'Grant pages are published on the Good Ventures website, generally within a few months after the grant is made',
  'Financing for these grants is provided by Good Ventures. The exact financing mechanism is not clear',
  'See also http://effective-altruism.com/ea/10l/june_2016_givewell_board_meeting/#relationship-with-good-ventures "51:59: Cari and Dustin aren’t tied down, they have their own thing"'),
  
  ('GiveWell discretionary regranting','Subsidiary',NULL,'United States',NULL,'https://www.givewell.org/about/FAQ/discretionary-grantmaking','https://www.givewell.org/about/FAQ/discretionary-grantmaking',NULL,NULL,'GiveWell',NULL,NULL,NULL,NULL,NULL,'https://blog.givewell.org/2016/12/19/discretionary-grant-making-and-implications-for-donor-agency/',NULL,'continuous updates','continuous updates','days','days',NULL,
  NULL,
  'https://blog.givewell.org/2016/12/19/discretionary-grant-making-and-implications-for-donor-agency/',
  'GiveWell has given donors the option to give money to Givewell to allocate to top charities. This differed from simply giving to GiveWell top charities using the recommended allocation, because GiveWell would determine the best use of marginal funds at the time of each regrant decision. GiveWell began highlighting discretionary regranting in late 2016, and announced some major discretionary regrants in 2017. For giving seasons 2017, Givewell recommended that donors give to GiveWell for discretionary regranting',
  'Same focus areas that inform GiveWell top charity recommendations. Top areas in recent years have included malaria, deworming, vitamin A supplementation, cash transfers, and seasonal intracountry migration',
  'For each discretionary regrant, which may be done about once a quarter, GiveWell looks at the most pressing of the needs of its top charities, and regrants funds based on those. Grant decisions have to be approved by the board',
  'In 2017, decisions were published in blog posts. As per https://blog.givewell.org/2017/09/12/september-open-thread/#comment-946059 and https://blog.givewell.org/2017/11/27/our-top-charities-for-giving-season-2017/#comment-946301 GiveWell plans to add a page listing all discretionary regrants',
  'Money for the grants mostly comes from funds donated by donors to "GiveWell top charities" for regranting at its discretion. In the case of regrant to the Against Malaria Foundation, the original donors show up in the Against Malaria Foundation donor list',
  NULL),

  ('Effective Altruism Funds: Global Health and Development Fund','Subsidiary',NULL,'United Kingdom',NULL,'https://app.effectivealtruism.org/funds/global-development','https://app.effectivealtruism.org/',NULL,NULL,'Centre for Effective Altruism',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'irregular','irregular','months','days',NULL,
  NULL,
  NULL,
  /* brief_history */ 'This is one of four Effective Altruism Funds that are a program of the Centre for Effective Altruism (CEA). The creation of the funds was inspired by the success of the EA Giving Group donor-advised fund run by Nick Beckstead, and also by the donor lottery run in December 2016 by Paul Christiano and Carl Shulman (see https://forum.effectivealtruism.org/posts/WvPEitTCM8ueYPeeH/donor-lotteries-demonstration-and-faq for more). EA Funds were introduced on 2017-02-09 in the post https://forum.effectivealtruism.org/posts/a8eng4PbME85vdoep/introducing-the-ea-funds and launched on 2017-02-28 in the post http://effective-ahttps://forum.effectivealtruism.org/posts/iYoSAXhodpxJFwdQz/ea-funds-beta-launch The first round of allocations was announced on 2017-04-20 at https://forum.effectivealtruism.org/posts/MsaS8JKrR8nnxyPkK/update-on-effective-altruism-funds The funds allocation information appears to have next been updated in November 2017; see https://www.facebook.com/groups/effective.altruists/permalink/1606722932717391/ for more',
  /* brief_donor_focus_notes */ 'Since its inception, the fund has had Elie Hassenfeld of GiveWell as its fund manager. The fund has made grants in global health and development to GiveWell-aligned organizations. It has mostly been used to make grants under GiveWell Incubation Grants as well as provide further funding to GiveWell top and standout charities',
  /* grant_decision_logistics_notes */ 'Money from the fund is supposed to be granted about thrice a year, with the target months being December, March and July. Actual grant months may differ from the target months. The amount of money granted with each decision cycle depends on the amount of money available in the Fund as well as on the available donation opportunities',
  /* grant_publication_logistics_notes */ 'Grant details are published on the EA Funds website, and linked to from the Fund page. Grants are usually of two types: (1) Grants that are also GiveWell Incubation Grants, so they will be cross-posted to the GiveWell Incubation Grants page on GiveWell''s site (but are listed only with donor Effective Altruism Funds on the donations list website), (2) Grants that are decided along with and similarly to GiveWell discretionary regranting',
  /* grant_financing_notes */ 'Money in the Global Health and Development Fund only includes funds explicitly donated for that Fund. In each grant round, the amount of money that can be allocated is limited by the balance available in the fund at that time',
  /* notes */ NULL),

  ('Effective Altruism Funds: Animal Welfare Fund','Subsidiary',NULL,'United Kingdom',NULL,'https://app.effectivealtruism.org/funds/animal-welfare','https://app.effectivealtruism.org/',NULL,NULL,'Centre for Effective Altruism',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'irregular','irregular','months','days',NULL,
  NULL,
  NULL,
  /* brief_history */ 'This is one of four Effective Altruism Funds that are a program of the Centre for Effective Altruism (CEA). The creation of the funds was inspired by the success of the EA Giving Group donor-advised fund run by Nick Beckstead, and also by the donor lottery run in December 2016 by Paul Christiano and Carl Shulman (see https://forum.effectivealtruism.org/posts/WvPEitTCM8ueYPeeH/donor-lotteries-demonstration-and-faq for more). EA Funds were introduced on 2017-02-09 in the post https://forum.effectivealtruism.org/posts/a8eng4PbME85vdoep/introducing-the-ea-funds and launched on 2017-02-28 in the post http://effective-ahttps://forum.effectivealtruism.org/posts/iYoSAXhodpxJFwdQz/ea-funds-beta-launch The first round of allocations was announced on 2017-04-20 at https://forum.effectivealtruism.org/posts/MsaS8JKrR8nnxyPkK/update-on-effective-altruism-funds The funds allocation information appears to have next been updated in November 2017; see https://www.facebook.com/groups/effective.altruists/permalink/1606722932717391/ for more',
  /* brief_donor_focus_notes */ 'As the name suggests, the Fund''s focus area is animal welfare, but it includes both factory farming and wild animal welfare, and it has also funded opportunities for priorities research. At inception, the Fund had Lewis Bollard (Program Officer for Farm Animal Welfare at Open Philanthropy Project) as its sole manager. In October 2018, https://forum.effectivealtruism.org/posts/yYHKRgLk9ufjJZn23/announcing-new-ea-funds-management-teams announces a new management team for the Fund, with Bollard staying on as chair of the management team, but with three new members Jamie Spurgeon, Natalie Cargill, and Toni Adleberg',
  /* grant_decision_logistics_notes */ 'Money from the fund is supposed to be granted about thrice a year, with the target months being November, February, and June. Actual grant months may differ from the target months. The amount of money granted with each decision cycle depends on the amount of money available in the Fund as well as on the available donation opportunities',
  /* grant_publication_logistics_notes */ 'Grant details are published on the EA Funds website, and linked to from the Fund page. Each grant is accompanied by a brief description of the grantee''s work (and hence, the intended use of funds) as well as reasons the grantee was considered impressive',
  /* grant_financing_notes */ 'Money in the Animal Welfare Fund only includes funds explicitly donated for that Fund. In each grant round, the amount of money that can be allocated is limited by the balance available in the fund at that time',
  /* notes */ NULL),

  ('Effective Altruism Funds: Meta Fund','Subsidiary',NULL,'United Kingdom',NULL,'https://app.effectivealtruism.org/funds/ea-community','https://app.effectivealtruism.org/',NULL,NULL,'Centre for Effective Altruism',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'irregular','irregular','months','days',NULL,
  NULL,
  NULL,
  /* brief_history */ 'This is one of four Effective Altruism Funds that are a program of the Centre for Effective Altruism (CEA). The creation of the funds was inspired by the success of the EA Giving Group donor-advised fund run by Nick Beckstead, and also by the donor lottery run in December 2016 by Paul Christiano and Carl Shulman (see https://forum.effectivealtruism.org/posts/WvPEitTCM8ueYPeeH/donor-lotteries-demonstration-and-faq for more). EA Funds were introduced on 2017-02-09 in the post https://forum.effectivealtruism.org/posts/a8eng4PbME85vdoep/introducing-the-ea-funds and launched on 2017-02-28 in the post http://effective-ahttps://forum.effectivealtruism.org/posts/iYoSAXhodpxJFwdQz/ea-funds-beta-launch The first round of allocations was announced on 2017-04-20 at https://forum.effectivealtruism.org/posts/MsaS8JKrR8nnxyPkK/update-on-effective-altruism-funds The funds allocation information appears to have next been updated in November 2017; see https://www.facebook.com/groups/effective.altruists/permalink/1606722932717391/ for more. This particular fund was previously called the Community Fund; in October 2018, the blog post https://forum.effectivealtruism.org/posts/yYHKRgLk9ufjJZn23/announcing-new-ea-funds-management-teams announced that it was renamed to the Meta Fund to more accurately reflect its use for funding activities (such as cause prioritization) that are "meta" but not necessarily tied to community-building',
  /* brief_donor_focus_notes */ 'As the name suggests, the Fund''s focus area is "meta" activities related to effective altruism. This includes some activities that directly and explicitly relate to effective altruism, as well as other activities that are related more broadly to promoting a culture of more and smarter philanthropy. It also covers cause prioritization and foundational research work. At inception, the Fund had Nick Beckstead of the Open Philanthropy Project its sole manager. Beckstead stepped down in August 2018, and October 2018, https://forum.effectivealtruism.org/posts/yYHKRgLk9ufjJZn23/announcing-new-ea-funds-management-teams announces a new management team for the Fund, comprising Luke Ding (chair), Denise Melchin, Matt Wage, Alex Foster, and Tara MacAulay as members, and Nick Beckstead as advisor',
  /* grant_decision_logistics_notes */ 'Money from the fund is supposed to be granted about thrice a year, with the target months being November, February, and June. Actual grant months may differ from the target months. The amount of money granted with each decision cycle depends on the amount of money available in the Fund as well as on the available donation opportunities. Grant applications can be submitted any time; any submitted applications will be considered prior to the next grant round (each grant round has a deadline by which applications must be submitted to be considered)',
  /* grant_publication_logistics_notes */ 'Grant details are published on the EA Funds website, and linked to from the Fund page. Each grant is accompanied by a brief description of the grantee''s work (and hence, the intended use of funds) as well as reasons the grantee was considered impressive',
  /* grant_financing_notes */ 'Money in the Meta Fund only includes funds explicitly donated for that Fund. In each grant round, the amount of money that can be allocated is limited by the balance available in the fund at that time',
  /* notes */ NULL),

  ('Effective Altruism Funds: Long Term Future Fund','Subsidiary',NULL,'United Kingdom',NULL,'https://app.effectivealtruism.org/funds/far-future','https://app.effectivealtruism.org/',NULL,NULL,'Centre for Effective Altruism',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'irregular','irregular','months','days',NULL,
  NULL,
  NULL,
  /* brief_history */ 'This is one of four Effective Altruism Funds that are a program of the Centre for Effective Altruism (CEA). The creation of the funds was inspired by the success of the EA Giving Group donor-advised fund run by Nick Beckstead, and also by the donor lottery run in December 2016 by Paul Christiano and Carl Shulman (see https://forum.effectivealtruism.org/posts/WvPEitTCM8ueYPeeH/donor-lotteries-demonstration-and-faq for more). EA Funds were introduced on 2017-02-09 in the post https://forum.effectivealtruism.org/posts/a8eng4PbME85vdoep/introducing-the-ea-funds and launched on 2017-02-28 in the post http://effective-ahttps://forum.effectivealtruism.org/posts/iYoSAXhodpxJFwdQz/ea-funds-beta-launch The first round of allocations was announced on 2017-04-20 at https://forum.effectivealtruism.org/posts/MsaS8JKrR8nnxyPkK/update-on-effective-altruism-funds The funds allocation information appears to have next been updated in November 2017; see https://www.facebook.com/groups/effective.altruists/permalink/1606722932717391/ for more. This particular fund was previously called the Far Future Fund; it was renamed to the Long Term Future Fund to more accurately reflect the meaning',
  /* brief_donor_focus_notes */ 'As the name suggests, the Fund''s focus area is activities that could significantly affect the long term future. Historically, the fund has focused on areas such as AI safety and rationality improvement, though it has also made grants related to biosecurity and other global catastrophic risks. At inception, the Fund had Nick Beckstead of the Open Philanthropy Project its sole manager. Beckstead stepped down in August 2018, and October 2018, https://forum.effectivealtruism.org/posts/yYHKRgLk9ufjJZn23/announcing-new-ea-funds-management-teams announces a new management team for the Fund, comprising chair Matt Fallshaw, and team Helen Toner, Oliver Habryka, Matt Wage, and Alex Zhu, with advisors Nick Beckstead and Jonas Vollmer',
  /* grant_decision_logistics_notes */ 'Money from the fund is supposed to be granted about thrice a year, with the target months being November, February, and June. Actual grant months may differ from the target months. The amount of money granted with each decision cycle depends on the amount of money available in the Fund as well as on the available donation opportunities. Grant applications can be submitted any time; any submitted applications will be considered prior to the next grant round (each grant round has a deadline by which applications must be submitted to be considered)',
  /* grant_publication_logistics_notes */ 'Grant details are published on the EA Funds website, and linked to from the Fund page. Each grant is accompanied by a brief description of the grantee''s work (and hence, the intended use of funds) as well as reasons the grantee was considered impressive. In April 2019, the write-up for each grant at https://app.effectivealtruism.org/funds/far-future/payouts/6vDsjtUyDdvBa3sNeoNVvl had just one author (rather than group authorship), likely the management team member who did the most work on that particular grant. Grant write-ups vary greatly in length; in April 2019, the write-ups by Oliver Habryka were the most thorough',
  /* grant_financing_notes */ 'Money in the Long Term Future Fund only includes funds explicitly donated for that Fund. In each grant round, the amount of money that can be allocated is limited by the balance available in the fund at that time',
  /* notes */ NULL),

  ('Effective Altruism Grants','Subsidiary',NULL,'United Kingdom',NULL,'https://www.effectivealtruism.org/grants/','https://docs.google.com/spreadsheets/d/1iBy--zMyIiTgybYRUQZIm11WKGQZcixaCmIaysRmGvk',NULL,NULL,'Centre for Effective Altruism',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'irregular','irregular','months','days','https://github.com/riceissa/ea-grants-processing',
  NULL,
  'http://effective-altruism.com/ea/1fc/effective_altruism_grants_project_update/',
  'Effective Altruism Grants (EA Grants for short) are a successor to Effective Altruism Ventures (see http://effective-altruism.com/ea/1b5/announcing_effective_altruism_grants/ for the announcement post). The first batch of EA Grants was publicly announced at the end of September 2017, totaling about £369,924 (with the remainder up to a total of £500,000 reserved for additional grants to recipients). In https://www.centreforeffectivealtruism.org/blog/cea-s-2017-review-and-2018-plans/ it was announced that EA Grants was moving to a rolling basis for urgent grants and a quarterly frequency of review for less urgent grants',
  'Focus is on filling funding gaps in grants for individuals pursuing early-stage but high-value projects',
  'For 2017, applications had to be made before a deadline. Of the 722 applications received, 413 (57%) were rejected. The second round involved taking the remaining applications and assessing applicants based on their track record, values, and plans. This assessment adhered to a rubric, weighting each category in accordance with its predictive power for project success. 63 candidates passed this round and had three 10-minute interviews, and 22 of them were selected. However, EA Grants is moving in 2018 to a rolling basis for urgent grants and a quarterly basis for other grants, according to https://www.centreforeffectivealtruism.org/blog/cea-s-2017-review-and-2018-plans/',
  'For 2017, all grants were published in a spreadsheet https://docs.google.com/spreadsheets/d/1iBy--zMyIiTgybYRUQZIm11WKGQZcixaCmIaysRmGvk but the long-term plan for sharing grants data is not clear',
  'The £500,000 budget for the first year of Effective Altruism Grants was part of the Centre for Effective Altruism budget, and the costs are covered by the Open Philanthropy Project grant https://www.openphilanthropy.org/giving/grants/centre-effective-altruism-general-support and a couple of other private donors, as described at http://effective-altruism.com/ea/1fc/effective_altruism_grants_project_update/',
  NULL),

  ('MacArthur Foundation','Private foundation',NULL,'United States','macarthurfdn','https://www.macfound.org/','https://www.macfound.org/grants/',NULL,NULL,NULL,NULL,NULL,NULL,'macfound',NULL,'https://www.macfound.org/about/how-we-work/','https://www.macfound.org/info-grantseekers/',NULL,NULL,NULL,NULL,'https://github.com/riceissa/macarthur-foundation','https://en.wikipedia.org/wiki/John_D._and_Catherine_T._MacArthur_Foundation',NULL,'https://www.macfound.org/about/our-history/',NULL,NULL,NULL,NULL,NULL),

  ('Hewlett Foundation','Private foundation',NULL,'United States','HewlettFoundation','https://www.hewlett.org/','https://www.hewlett.org/grants/',NULL,'the-william-and-flora-hewlett-foundation',NULL,NULL,NULL,NULL,'hewlett_found',NULL,'https://www.hewlett.org/about-us/values-and-policies/','https://www.hewlett.org/grantmaking-faq/',NULL,NULL,NULL,NULL,'https://github.com/riceissa/hewlett-foundation','https://en.wikipedia.org/wiki/Hewlett_Foundation',NULL,'https://www.hewlett.org/about-us/hewlett-family-and-history/',NULL,NULL,NULL,NULL,NULL),

  ('Ford Foundation','Private foundation',NULL,'United States','FordFoundation','https://www.fordfoundation.org','https://www.fordfoundation.org/work/our-grants/',NULL,'ford-foundation',NULL,NULL,NULL,NULL,'FordFoundation',NULL,'https://www.fordfoundation.org/about-us/mission/','https://www.fordfoundation.org/work/our-grants/idea-submission/',NULL,NULL,NULL,NULL,'https://github.com/riceissa/ford-foundation','https://en.wikipedia.org/wiki/Ford_Foundation',NULL,NULL,NULL,NULL,NULL,NULL,NULL),

  ('Wellcome Trust','Private foundation',NULL,'United Kingdom','wellcometrust','https://wellcome.ac.uk/','https://wellcome.ac.uk/funding/managing-grant/grants-awarded',NULL,'wellcome-trust',NULL,NULL,NULL,NULL,'wellcometrust',NULL,'https://wellcome.ac.uk/about-us/our-strategy','https://wellcome.ac.uk/funding#im-looking-for-funding',NULL,NULL,NULL,NULL,'https://github.com/riceissa/wellcome-trust','https://en.wikipedia.org/wiki/Wellcome_Trust',NULL,NULL,NULL,NULL,NULL,NULL,NULL),

  ('Bauman Foundation','Private foundation',NULL,'United States',NULL,'https://www.baumanfoundation.org/','https://www.baumanfoundation.org/grants/search',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'https://www.baumanfoundation.org/node/55',NULL,NULL,NULL,NULL,NULL,'https://github.com/riceissa/bauman-foundation',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),

  ('Unbound Philanthropy','Private foundation',NULL,'United States',NULL,'https://www.unboundphilanthropy.org','https://www.unboundphilanthropy.org/who-we-fund',NULL,'unbound-philanthropy',NULL,NULL,NULL,NULL,NULL,NULL,'https://www.unboundphilanthropy.org/our-mission-and-vision','https://www.unboundphilanthropy.org/selection-process',NULL,NULL,NULL,NULL,'https://github.com/riceissa/unbound-philanthropy',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),

  ('John Templeton Foundation','Private foundation',NULL,'United States','TempletonFoundation','https://www.templeton.org/','https://www.templeton.org/grants',NULL,NULL,NULL,NULL,NULL,NULL,'templeton_fdn',NULL,'https://www.templeton.org/about/vision-mission-impact','https://www.templeton.org/grants/apply-for-grant',NULL,NULL,NULL,NULL,'https://github.com/riceissa/templeton-foundation','https://en.wikipedia.org/wiki/John_Templeton_Foundation',NULL,NULL,NULL,NULL,NULL,NULL,NULL),

  ('McDowell Foundation','Private foundation',NULL,'United States','themcdowellfoundation','http://www.mcdowellfoundation.org/','http://www.mcdowellfoundation.org/our-grants',NULL,NULL,NULL,NULL,NULL,NULL,'mcdowell_fdn',NULL,'http://www.mcdowellfoundation.org/about','http://www.mcdowellfoundation.org/applying-for-grants',NULL,NULL,NULL,NULL,'https://github.com/riceissa/mcdowell-foundation',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),

  ('Nathan Cummings Foundation','Private foundation',NULL,'United States','NathanCummingsFoundation','http://www.nathancummings.org/','http://www.nathancummings.org/what-we-fund/grants',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'http://www.nathancummings.org/about-the-foundation/mission-statement','http://www.nathancummings.org/how-apply',NULL,NULL,NULL,NULL,'https://github.com/riceissa/nathan-cummings-foundation','https://en.wikipedia.org/wiki/Nathan_Cummings_Foundation',NULL,NULL,NULL,NULL,NULL,NULL,NULL),

  ('Theiss Research','Private foundation',NULL,'United States',NULL,'http://www.theissresearch.org/','https://web.archive.org/web/20160630004923/http://theissresearch.org/organization/grants.php',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),

  ('Sloan Foundation','Private foundation',NULL,'United States','sloanfoundation','https://sloan.org/','https://sloan.org/grants-database',NULL,NULL,NULL,NULL,NULL,NULL,'SloanFoundation',NULL,'https://sloan.org/about#mission','https://sloan.org/grants/apply',NULL,NULL,NULL,NULL,'https://github.com/riceissa/sloan-foundation','https://en.wikipedia.org/wiki/Alfred_P._Sloan_Foundation',NULL,NULL,NULL,NULL,NULL,NULL,NULL),

  ('Atlantic Philanthropies','Private foundation',NULL,'United States','TheAtlanticPhilanthropies','https://www.atlanticphilanthropies.org/','http://www.atlanticphilanthropies.org/grants',NULL,NULL,NULL,NULL,NULL,NULL,'atlantic',NULL,'https://www.atlanticphilanthropies.org/insights/atlantic-insights',NULL,NULL,NULL,NULL,NULL,NULL,'https://en.wikipedia.org/wiki/Atlantic_Philanthropies',NULL,NULL,NULL,NULL,NULL,NULL,NULL),

  ('Berkeley Existential Risk Initiative','Subsidiary',NULL,'United States','Berkeley-Existential-Risk-Initiative-1875638366085846','http://existence.org/',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),

  ('Foundational Questions Institute',NULL,NULL,'United States',NULL,'https://fqxi.org/','https://fqxi.org/grants',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'https://fqxi.org/about',NULL,NULL,NULL,NULL,NULL,'https://github.com/riceissa/fqxi-grants','https://en.wikipedia.org/wiki/Foundational_Questions_Institute',NULL,NULL,NULL,NULL,NULL,NULL,NULL),

  ('Mulago Foundation','Private foundation',NULL,'United States',NULL,'http://mulagofoundation.org/','http://mulagofoundation.org/who-we-fund',NULL,'mulago-foundation',NULL,NULL,NULL,NULL,NULL,NULL,'http://mulagofoundation.org/how-we-fund',NULL,NULL,NULL,NULL,NULL,'https://github.com/riceissa/mulago','https://en.wikipedia.org/wiki/Mulago_Foundation',NULL,NULL,NULL,NULL,NULL,NULL,NULL),

  ('Knight Foundation','Private foundation',NULL,'United States','knightfdn','https://knightfoundation.org/','https://knightfoundation.org/grants',NULL,NULL,NULL,NULL,NULL,NULL,'knightfdn',NULL,'https://knightfoundation.org/about','https://knightfoundation.org/apply/',NULL,NULL,NULL,NULL,'https://github.com/riceissa/knight-foundation','https://en.wikipedia.org/wiki/John_S._and_James_L._Knight_Foundation',NULL,NULL,NULL,NULL,NULL,NULL,NULL),

  ('Skoll Foundation','Private foundation',NULL,'United States',NULL,'http://skoll.org/','http://skoll.org/community/awardees/',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'http://skoll.org/about/about-skoll/',NULL,NULL,NULL,NULL,NULL,NULL,'https://en.wikipedia.org/wiki/Skoll_Foundation',NULL,NULL,NULL,NULL,NULL,'See http://skoll.org/about/financials/',NULL),

  ('Children''s Investment Fund Foundation','Private foundation',NULL,'United Kingdom',NULL,'https://ciff.org/','https://ciff.org/grant-portfolio/',NULL,'children''s-investment-fund-foundation-ciff-',NULL,NULL,NULL,NULL,'ciffchild',NULL,'https://ciff.org/about-us/our-approach-and-values/',NULL,NULL,NULL,NULL,NULL,NULL,'https://en.wikipedia.org/wiki/The_Children%27s_Investment_Fund_Foundation',NULL,NULL,NULL,NULL,NULL,'See https://ciff.org/about-us/finances/ and https://ciff.org/about-us/endowment/',NULL),

  ('Stone Family Foundation','Private foundation',NULL,'United Kingdom',NULL,'http://www.thesff.com/','https://github.com/vipulnaik/donations/issues/55#issue-326765897',NULL,NULL,NULL,NULL,NULL,NULL,'StoneFamilyFdn',NULL,'http://www.thesff.com/about/',NULL,NULL,NULL,NULL,NULL,'https://github.com/riceissa/stone-family-foundation','https://en.wikipedia.org/wiki/Stone_Family_Foundation',NULL,NULL,NULL,NULL,NULL,NULL,NULL),

  ('Douglas B. Marshall Jr. Family Foundation','Private foundation',NULL,'United States',NULL,'http://www.dbmjr.org/','http://www.dbmjr.org/recent_grants.htm',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'http://www.dbmjr.org/mission_statement.htm','http://www.dbmjr.org/grant_guidelines.htm',NULL,NULL,NULL,NULL,'https://github.com/riceissa/dbmjr',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),

  ('Barr Foundation','Private foundation',NULL,'United States','BarrFdn','https://www.barrfoundation.org/','https://www.barrfoundation.org/grantmaking/grants',NULL,NULL,NULL,NULL,NULL,NULL,'BarrFdn',NULL,'https://www.barrfoundation.org/how-we-work',NULL,NULL,NULL,NULL,NULL,'https://github.com/riceissa/barr-foundation',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),

  ('Michael and Susan Dell Foundation','Private foundation',NULL,'United States','dellfamilyfoundation','https://www.msdf.org/','https://www.msdf.org/funding/',NULL,NULL,NULL,NULL,NULL,NULL,'msdf_foundation',NULL,'https://www.msdf.org/about/how-we-work/',NULL,NULL,NULL,NULL,NULL,'https://github.com/riceissa/dell-foundation','https://en.wikipedia.org/wiki/Michael_%26_Susan_Dell_Foundation',NULL,NULL,NULL,NULL,NULL,NULL,NULL),

  ('Chan Zuckerberg Initiative','Private foundation',NULL,'United States','chanzuckerberginitiative','https://www.chanzuckerberg.com/',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'https://www.chanzuckerberg.com/about',NULL,NULL,NULL,NULL,NULL,NULL,'https://en.wikipedia.org/wiki/Chan_Zuckerberg_Initiative',NULL,NULL,NULL,NULL,NULL,NULL,NULL),

  ('Andrew W. Mellon Foundation', 'Private foundation', NULL, 'United States', 'MellonFoundation', 'https://mellon.org/', 'https://mellon.org/grants/grants-database/', NULL, 'the-andrew-w--mellon-foundation', NULL, NULL, NULL, NULL, 'mellonfdn', NULL, 'https://mellon.org/about/mission/', 'https://mellon.org/grants/grantmaking-policies-and-guidelines/', NULL, NULL, NULL, NULL, 'https://github.com/riceissa/mellon-foundation', 'https://en.wikipedia.org/wiki/Andrew_W._Mellon_Foundation', NULL, 'https://mellon.org/about/history/', 'https://mellon.org/programs/', NULL, NULL, NULL, NULL),

  ('Evelyn and Walter Haas, Jr. Fund', 'Private foundation', NULL, 'United States', 'haasjrfund', 'https://www.haasjr.org/', 'https://www.haasjr.org/grants', NULL, NULL, NULL, NULL, NULL, NULL, 'HaasJrFund', NULL, 'https://www.haasjr.org/about/mission-statement', 'https://www.haasjr.org/grants/for-grant-seekers', NULL, NULL, NULL, NULL, 'https://github.com/riceissa/haasjr-fund', 'https://en.wikipedia.org/wiki/Evelyn_and_Walter_Haas_Jr._Fund', NULL,NULL,NULL,NULL,NULL,NULL,NULL),

  ('Surdna Foundation', 'Private foundation', NULL, 'United States', NULL, 'https://surdna.org/', 'https://surdna.org/grants-database/', NULL, 'surdna-foundation', NULL, NULL, NULL, NULL, 'Surdna_Fndn', NULL, 'https://surdna.org/our-organization/vision-mission-values/', 'https://surdna.org/prospective-grantees/', NULL, NULL, NULL, NULL, 'https://github.com/riceissa/surdna-foundation', 'https://en.wikipedia.org/wiki/Surdna_Foundation', NULL, 'https://surdna.org/our-organization/our-history/', NULL, NULL, NULL, NULL, NULL),

  ('John M. Olin Foundation', 'Private foundation', NULL, 'United States', NULL, 'http://jmof.org/', 'http://conservativetransparency.org/donor/john-m-olin-foundation/', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'http://jmof.org/history-purposes', 'http://jmof.org/application-procedure', NULL, NULL, NULL, NULL, 'https://github.com/riceissa/conservativetransparency', 'https://en.wikipedia.org/wiki/John_M._Olin_Foundation', NULL, NULL, NULL, 'http://jmof.org/grant-making-policies', NULL, NULL, NULL),

  ('Lynde and Harry Bradley Foundation', 'Private foundation', NULL, 'United States', NULL, 'http://bradleyfdn.org/', 'http://conservativetransparency.org/donor/the-lynde-and-harry-bradley-foundation/', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'http://bradleyfdn.org/What-We-Do/Vision-Mission-and-Principles', 'http://bradleyfdn.org/How-We-Work-GrantMaking-Policies-Application-Procedure', NULL, NULL, NULL, NULL, 'https://github.com/riceissa/conservativetransparency', 'https://en.wikipedia.org/wiki/Bradley_Foundation', NULL, NULL, NULL, NULL, NULL, NULL, NULL),

  ('Walton Family Foundation', 'Private foundation', NULL, 'United States', 'waltonfamilyfoundation', 'https://www.waltonfamilyfoundation.org/', 'http://conservativetransparency.org/donor/walton-family-foundation/', NULL, NULL, NULL, NULL, NULL, NULL, 'WaltonFamilyFdn', NULL, 'https://www.waltonfamilyfoundation.org/about-us', NULL /* "The foundation does not accept unsolicited requests for proposals." https://www.waltonfamilyfoundation.org/frequently-asked-questions */, NULL, NULL, NULL, NULL, 'https://github.com/riceissa/conservativetransparency', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),

  ('Earhart Foundation', 'Private foundation', NULL, 'United States', NULL, NULL, 'http://conservativetransparency.org/donor/earhart-foundation/', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'https://github.com/riceissa/conservativetransparency', 'https://en.wikipedia.org/wiki/Earhart_Foundation', NULL, NULL, NULL, NULL, NULL, NULL, NULL),

  ('Smith Richardson Foundation', 'Private foundation', NULL, 'United States', NULL, 'https://www.srf.org/', 'https://www.srf.org/past-grants/', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'https://www.srf.org/our-mission-history/', 'https://www.srf.org/contact-us/', NULL, NULL, NULL, NULL, 'https://github.com/riceissa/conservativetransparency', 'https://en.wikipedia.org/wiki/Smith_Richardson_Foundation', NULL, NULL, NULL, NULL, NULL, NULL, NULL),

  ('William E. Simon Foundation', 'Private foundation', NULL, 'United States', NULL, 'http://www.wesimonfoundation.org/', 'http://conservativetransparency.org/donor/william-e-simon-foundation/', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'http://www.wesimonfoundation.org/index.php?option=com_content&view=article&id=2&Itemid=118', 'http://www.wesimonfoundation.org/index.php?option=com_content&view=article&id=13&Itemid=110', NULL, NULL, NULL, NULL, 'https://github.com/riceissa/conservativetransparency', NULL, NULL, 'http://www.wesimonfoundation.org/index.php?option=com_content&view=article&id=8&Itemid=143', NULL, NULL, NULL, NULL, NULL),

  ('F. M. Kirby Foundation', 'Private foundation', NULL, 'United States', NULL, 'http://fmkirbyfoundation.org/', 'http://fmkirbyfoundation.org/grants/', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'http://fmkirbyfoundation.org/about/', 'http://fmkirbyfoundation.org/apply/', NULL, NULL, NULL, NULL, 'https://github.com/riceissa/conservativetransparency', NULL, NULL, 'http://fmkirbyfoundation.org/about/', NULL, NULL, NULL, NULL, NULL),

  ('Donors Trust', 'Donor-advised fund', NULL, 'United States', 'donorstrust', 'https://www.donorstrust.org/', 'http://conservativetransparency.org/donor/donorstrust/', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'https://www.donorstrust.org/who-we-are/mission-principles/', NULL, NULL, NULL, NULL, NULL, 'https://github.com/riceissa/conservativetransparency', 'https://en.wikipedia.org/wiki/Donors_Trust', NULL, NULL, NULL, NULL, NULL, NULL, NULL),

  (
    'Robert Bowne Foundation', /* donor */
    'Private foundation', /* donor_type */
    NULL, /* other_names */
    'United States', /* country */
    NULL, /* facebook_username */
    'https://www.robertbownefoundation.org/', /* website */
    'https://www.robertbownefoundation.org/grants.php', /* donations_url */
    NULL, /* lesswrong_username */
    NULL, /* linkedin_username */
    NULL, /* affiliated_orgs */
    NULL, /* eaf_username */
    NULL, /* eahub_username */
    NULL, /* github_username */
    NULL, /* twitter_username */
    NULL, /* predictionbook_username */
    'https://www.robertbownefoundation.org/about.php', /* philosophy_url */
    NULL, /* grant_application_process_url */
    NULL, /* donations_data_update_regularity */
    NULL, /* donations_data_dlw_update_regularity */
    NULL, /* donations_data_update_lag */
    NULL, /* donations_data_dlw_update_lag */
    'https://github.com/riceissa/robert-bowne-foundation', /* dlw_data_processing_script */
    NULL, /* wikipedia_page */
    NULL, /* best_overview_url */
    NULL, /* brief_history */
    NULL, /* brief_donor_focus_notes */
    NULL, /* grant_decision_logistics_notes */
    NULL, /* grant_publication_logistics_notes */
    NULL, /* grant_financing_notes */
    NULL /* notes */
  ),

  (
    'Quixote Foundation', /* donor */
    'Private foundation', /* donor_type */
    NULL, /* other_names */
    'United States', /* country */
    'QuixoteFoundation', /* facebook_username */
    'http://quixotefoundation.org', /* website */
    'http://quixotefoundation.org/grants/', /* donations_url */
    NULL, /* lesswrong_username */
    NULL, /* linkedin_username */
    NULL, /* affiliated_orgs */
    NULL, /* eaf_username */
    NULL, /* eahub_username */
    NULL, /* github_username */
    'QuixoteTilts', /* twitter_username */
    NULL, /* predictionbook_username */
    NULL, /* philosophy_url */
    NULL, /* grant_application_process_url */
    NULL, /* donations_data_update_regularity */
    NULL, /* donations_data_dlw_update_regularity */
    NULL, /* donations_data_update_lag */
    NULL, /* donations_data_dlw_update_lag */
    'https://github.com/riceissa/quixote-foundation', /* dlw_data_processing_script */
    NULL, /* wikipedia_page */
    NULL, /* best_overview_url */
    NULL, /* brief_history */
    NULL, /* brief_donor_focus_notes */
    NULL, /* grant_decision_logistics_notes */
    NULL, /* grant_publication_logistics_notes */
    NULL, /* grant_financing_notes */
    NULL /* notes */
  ),

  (
    'John Merck Fund', /* donor */
    'Private foundation', /* donor_type */
    NULL, /* other_names */
    'United States', /* country */
    NULL, /* facebook_username */
    'https://www.jmfund.org/', /* website */
    'https://www.jmfund.org/program-grants/', /* donations_url */
    NULL, /* lesswrong_username */
    NULL, /* linkedin_username */
    NULL, /* affiliated_orgs */
    NULL, /* eaf_username */
    NULL, /* eahub_username */
    NULL, /* github_username */
    NULL, /* twitter_username */
    NULL, /* predictionbook_username */
    'https://www.jmfund.org/about-us/', /* philosophy_url */
    'https://www.jmfund.org/for-grantseekers/', /* grant_application_process_url */
    NULL, /* donations_data_update_regularity */
    NULL, /* donations_data_dlw_update_regularity */
    NULL, /* donations_data_update_lag */
    NULL, /* donations_data_dlw_update_lag */
    'https://github.com/riceissa/john-merck-fund', /* dlw_data_processing_script */
    NULL, /* wikipedia_page */
    NULL, /* best_overview_url */
    NULL, /* brief_history */
    NULL, /* brief_donor_focus_notes */
    NULL, /* grant_decision_logistics_notes */
    NULL, /* grant_publication_logistics_notes */
    NULL, /* grant_financing_notes */
    NULL /* notes */
  ),

  (
    'Andrea & Charles Bronfman Philanthropies', /* donor */
    'Private foundation', /* donor_type */
    NULL, /* other_names */
    'United States', /* country */
    NULL, /* facebook_username */
    'http://www.acbp.net/', /* website */
    'http://www.acbp.net/grant-directory.php', /* donations_url */
    NULL, /* lesswrong_username */
    NULL, /* linkedin_username */
    NULL, /* affiliated_orgs */
    NULL, /* eaf_username */
    NULL, /* eahub_username */
    NULL, /* github_username */
    NULL, /* twitter_username */
    NULL, /* predictionbook_username */
    'http://www.acbp.net/strategic-philanthropy.php', /* philosophy_url */
    NULL, /* grant_application_process_url */
    NULL, /* donations_data_update_regularity */
    NULL, /* donations_data_dlw_update_regularity */
    NULL, /* donations_data_update_lag */
    NULL, /* donations_data_dlw_update_lag */
    'https://github.com/riceissa/andrea-and-charles-bronfman-philanthropies', /* dlw_data_processing_script */
    'https://en.wikipedia.org/wiki/Charles_Bronfman#Philanthropy', /* wikipedia_page */
    NULL, /* best_overview_url */
    'http://www.acbp.net/history.php', /* brief_history */
    NULL, /* brief_donor_focus_notes */
    NULL, /* grant_decision_logistics_notes */
    NULL, /* grant_publication_logistics_notes */
    NULL, /* grant_financing_notes */
    NULL /* notes */
  ),

  ('Pineapple Fund',NULL,NULL,'United States',NULL,'https://pineapplefund.org/','https://pineapplefund.org/',NULL,NULL,NULL,NULL,NULL,'PineappleFund',NULL,NULL,NULL,NULL,'irregular',NULL,'days','months','https://github.com/riceissa/pineapple-fund','https://en.wikipedia.org/wiki/Pineapple_Fund',NULL,
  'The Pineapple Fund was announced in December 2017 by an anonymous individual.',
  NULL, NULL, NULL, NULL, NULL);


# -- insert into donors(donor, donor_type, country, facebook_username, website, donations_url, lesswrong_username, linkedin_username,affiliated_orgs,eaf_username, eahub_username,github_username,twitter_username, predictionbook_username, philosophy_url, grant_application_process_url, donations_data_update_regularity, donations_data_dlw_update_regularity, donations_data_update_lag, donations_data_dlw_update_lag, dlw_data_processing_script, wikipedia_page,best_overview_url,brief_history,brief_donor_focus_notes,grant_decision_logistics_notes,grant_publication_logistics_notes,grant_financing_notes,notes) values

