/* Grants to Effective Thesis */
insert into donations(donor, donee, amount, donation_date, donation_date_precision, donation_date_basis, cause_area, url, donation_earmark, influencer, donation_announcement_date, donation_announcement_date_precision, donation_announcement_url, goal_amount, fraction, donation_process, intended_use_of_funds_category, intended_use_of_funds, intended_funding_timeframe_in_months, donor_donee_reason, donor_amount_reason, donor_timing_reason, donor_next_donation_thoughts, donor_retrospective, notes) values
  ('Survival and Flourishing','Effective Thesis',43333,'2020-11-01','month','donation log','Effective altruism/research guidance','https://survivalandflourishing.org/saf-2020-q4','David Janků',NULL,NULL,NULL,NULL,NULL,NULL, /* Fill in goal amount once we know all grants are announced */
  /* donation_process */ 'The grant page says: "In 2020 Q4, SAF hosted a competition for individuals seeking a fixed amount of funding for projects benefitting SAF’s mission. We expected this competition to allocate between $300k and $350k in funding. [...] Winning applicants will be selected by a Selection Committee comprising at least three people appointed by SAF’s Governance Committee. The Selection Committee will rank-order projects and award funding and project contracts to the top-ranked projects falling within our budget for this round. We may adjust our total budget for the round based on the quality of applications."',
  /* intended_use_of_funds_category */ 'Direct project expenses',
  /* intended_use_of_funds */ 'Continuing the development of https://effectivethesis.org/',
  /* intended_funding_timeframe_in_months */ 11,
  /* donor_donee_reason */ NULL,
  /* donor_amount_reason */ 'While reasons for the amount for individual grants are not given, SAF provides guidance on the ranges it allows for amounts. Amounts must be between $5,000 and $200,000, for a time frame of up to 2 years. The amount is also capped at {$300,000} times {the applicant’s percentage time commitment to the project} times {the duration of the project in years}.',
  /* donor_timing_reason */ 'Timing determined by the timing of the 2020 Q4 grant round',
  /* donor_next_donation_thoughts */ 'While no thoughts are included on followup donations for individual grants, SAF says on the grant page that it usually does not fund ongoing work, making followup grants unlikely. However, Effective Thesis itself is ongoing work, so it is an exception, and therefore may be able to get further SAF grants.',
  /* donor_retrospective */ NULL,
  /* notes */ NULL);

