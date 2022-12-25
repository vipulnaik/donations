create table donations (
    donation_id int not null auto_increment primary key,
    donor varchar(100), /* max length 70 */
    donee varchar(200), /* max length 176 */
    amount decimal(14,2),
    amount_original_currency decimal(24,2),
    original_currency enum('AUD','BRL','BTC','CAD','CHF','CZK','DKK','ETH','EUR','GBP','INR','NOK','NZD','SEK','SGD','USD','XRP','ZAR','SHIB','AKITA','ELON','MKR','KRW') DEFAULT 'USD',
    currency_conversion_date date,
    currency_conversion_basis enum('donor calculation','donee calculation','Peter Hurford','Bloomberg','Fixer.io','Coindesk','Etherscan.io'),
    fraction decimal(5, 4),
    donation_date date,
    donation_date_precision enum('day','month','quarter','year','multi-year'),
    donation_date_basis enum('transaction','donation log','date of donation announced in announcement','date of donation announcement','donee contributor list', 'IATI','Effective Altruism Survey','private communication by donee','private communication by donor'),
    cause_area varchar(100), /* max length 100 */
    url varchar(400), /* max length 228 */
    donor_cause_area_url varchar(200), /* max length 117 */
    notes varchar(2000) DEFAULT NULL, /* max length 1923 */
    donation_process varchar(2500) DEFAULT NULL, /* max length 2161 */
    intended_use_of_funds_category varchar(200) DEFAULT NULL, /* max length 63 */
    intended_use_of_funds varchar(1000) DEFAULT NULL, /* max length 1007 */
    intended_funding_timeframe_in_months int DEFAULT NULL,
    donor_donee_reason varchar(1000) DEFAULT NULL, /* max length 999 */
    donor_amount_reason varchar(1000) DEFAULT NULL, /* max length 990 */
    donor_timing_reason varchar(1000) DEFAULT NULL, /* max length 999 */
    donor_next_donation_thoughts varchar(1000) DEFAULT NULL, /* max length 984 */
    donor_retrospective varchar(1000) DEFAULT NULL, /* max length 997 */
    payment_modality varchar(100), /* max length 38 */
    match_eligible boolean,
    goal_amount decimal(14,2),
    influencer varchar(1000), /* max length 91 */
    employer_match decimal(14,2),
    matching_employer varchar(100),
    special_donation_reason enum('Giving Game','Compensation to charity for effort','Committed periodic donation','Fundraiser/Gift','Hat tip','One-off opportunity', 'Offset','Prize to charity of choice'),
    donation_earmark varchar(2000), /* max length 124 */
    affected_countries varchar(2000), /* max length 844 */
    affected_states varchar(300), /* max length 249 */
    affected_cities varchar(300), /* max length 123 */
    affected_regions varchar(2000), /* max length 799 */
    donation_announcement_date date,
    donation_announcement_date_precision enum('day','month','year','multi-year'),
    donation_announcement_url varchar(200), /* max length 165 */
    predictions varchar(2000), /* max length 324 */
    is_contractwork tinyint(1) default 0
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
