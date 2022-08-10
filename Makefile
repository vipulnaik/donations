MYSQL_ARGS=
DATABASE=donations

.PHONY: reset
reset: reset_documents reset_donations reset_donees reset_donors reset_gifts reset_money_moved reset_disclosures reset_donor_donee_relationships reset_cache

.PHONY: init
init:
	mkdir -p access-portal/images
	mysql $(MYSQL_ARGS) -e "create database if not exists $(DATABASE);"

# To update the read_* sections below, paste the output of (changing "table_name_here" to the correct table name):
#     find ./sql/table_name_here -type f -iname '*.sql' | sort | sed 's/^\.\//\tmysql $(MYSQL_ARGS) $(DATABASE) < /'
# Then move the SQL files ending in "-schema" to the top. In Vim you can
# visually select the .sql lines:
#     '<,'>g/-schema/m'<-1
.PHONY: read
read: read_documents read_donations read_donees read_donors read_gifts read_money_moved read_disclosures read_donor_donee_relationships

.PHONY: reset_documents
reset_documents:
	mysql $(MYSQL_ARGS) -e "use $(DATABASE); drop table if exists documents;"

.PHONY: reset_donations
reset_donations:
	mysql $(MYSQL_ARGS) -e "use $(DATABASE); drop table if exists donations;"

.PHONY: reset_donees
reset_donees:
	mysql $(MYSQL_ARGS) -e "use $(DATABASE); drop table if exists donees;"

.PHONY: reset_donors
reset_donors:
	mysql $(MYSQL_ARGS) -e "use $(DATABASE); drop table if exists donors;"

.PHONY: reset_gifts
reset_gifts:
	mysql $(MYSQL_ARGS) -e "use $(DATABASE); drop table if exists gifts;"

.PHONY: reset_money_moved
reset_money_moved:
	mysql $(MYSQL_ARGS) -e "use $(DATABASE); drop table if exists money_moved;"

.PHONY: reset_disclosures
reset_disclosures:
	mysql $(MYSQL_ARGS) -e "use $(DATABASE); drop table if exists disclosures;"

.PHONY: reset_donor_donee_relationships
	mysql $(MYSQL_ARGS) -e "use $(DATABASE); drop table if exists donor_donee_relationships;"

.PHONY: read_documents
read_documents:
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/documents/documents-schema.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/documents/80k-docs.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/documents/ace-docs.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/documents/aidgrade-docs.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/documents/ai-impacts-docs.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/documents/ai-safety-docs.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/documents/allfed-docs.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/documents/animal-equality-docs.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/documents/animal-ethics-docs.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/documents/animal-welfare-docs.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/documents/ben-delo-docs.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/documents/beri-docs.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/documents/berkeley-reach.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/documents/biomedical-research-docs.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/documents/biosecurity-and-pandemic-preparedness-docs.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/documents/carrick-flynn-for-congress-docs.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/documents/catf-docs.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/documents/cause-prioritization-docs.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/documents/cea-docs.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/documents/ces-docs.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/documents/cfar-docs.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/documents/charity-science-docs.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/documents/climate-change-docs.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/documents/criminal-justice-reform-docs.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/documents/czi-docs.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/documents/deworm-the-world-docs.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/documents/dickens-docs.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/documents/documents.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/documents/donation-docs.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/documents/donor-lottery-docs.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/documents/earning-to-give-docs.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/documents/ea-cbg-docs.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/documents/ea-foundation-docs.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/documents/ea-funding-landscape-docs.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/documents/ea-funds-docs.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/documents/ea-global-docs.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/documents/ea-grants-docs.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/documents/ea-hotel-docs.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/documents/education-docs.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/documents/evidence-action-docs.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/documents/fli-docs.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/documents/forethought-foundation-docs.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/documents/founders-pledge-docs.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/documents/ftx-future-fund-docs.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/documents/gcri-docs.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/documents/gfi-docs.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/documents/givedirectly-docs.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/documents/givewell-docs.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/documents/giving-pledge-docs.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/documents/good-policies-docs.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/documents/gpi-docs.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/documents/gwwc-docs.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/documents/hurford-docs.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/documents/lets-fund-docs.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/documents/life-extension-docs.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/documents/lightcone-docs.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/documents/mfa-docs.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/documents/miri-docs.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/documents/one-for-the-world-docs.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/documents/open-phil-docs.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/documents/oxprio.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/documents/peter-thiel-docs.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/documents/rethink-charity-docs.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/documents/rethink-priorities-docs.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/documents/sandler-foundation-docs.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/documents/sentience-institute-docs.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/documents/simon-knutsson-docs.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/documents/survival-and-flourishing-fund-docs.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/documents/thl-docs.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/documents/vegan-outreach-docs.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/documents/wild-animal-initiative-docs.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/documents/wild-animal-docs.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/documents/wmf-docs.sql

.PHONY: read_donations
read_donations: read_donations_schema read_foundation_and_subsidiary_grants read_other_donations

.PHONY: read_donations_schema
read_donations_schema:
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/donations-schema.sql

.PHONY: read_foundation_and_subsidiary_grants
read_foundation_and_subsidiary_grants:
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/donees/one-for-the-world-donations.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/private-foundations/andrea-and-charles-bronfman-philanthropies-grants.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/private-foundations/arch-community-fund-grants.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/private-foundations/arnold-ventures-grants.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/private-foundations/barr-foundation-grants.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/private-foundations/chan-zuckerberg-initiative-grants.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/private-foundations/dell-foundation-grants.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/private-foundations/donorstrust-grants.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/private-foundations/ea-giving-group.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/private-foundations/earhart-foundation-grants.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/private-foundations/f-m-kirby-foundation-grants.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/private-foundations/ford-foundation-grants.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/private-foundations/foundational-questions-institute-grants.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/private-foundations/future-justice-fund-grants.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/private-foundations/future-of-life-institute-grants.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/private-foundations/ftx-future-fund/ftx-future-fund-ai-safety-open-call-grants.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/private-foundations/ftx-future-fund/ftx-future-fund-biosecurity-open-call-grants.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/private-foundations/ftx-future-fund/ftx-future-fund-effective-altruism-open-call-grants.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/private-foundations/ftx-future-fund/ftx-future-fund-epistemic-institutions-open-call-grants.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/private-foundations/ftx-future-fund/ftx-future-fund-staff-led-grants.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/private-foundations/gates-foundation-grants.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/private-foundations/google-org.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/private-foundations/haas-jr-fund-grants.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/private-foundations/hewlett-foundation-grants.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/private-foundations/john-m-olin-foundation-grants.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/private-foundations/john-merck-fund-grants.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/private-foundations/kellogg-foundation-grants.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/private-foundations/knight-foundation-grants.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/private-foundations/lilly-endowment-grants.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/private-foundations/macarthur-foundation-grants.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/private-foundations/mcdowell-foundation-grants.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/private-foundations/mellon-foundation-grants.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/private-foundations/mulago-foundation-grants.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/private-foundations/nathan-cummings-foundation-grants.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/private-foundations/open-philanthropy/open-phil-ai-safety-grants.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/private-foundations/open-philanthropy/open-phil-animal-welfare-grants.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/private-foundations/open-philanthropy/open-phil-biosecurity-grants.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/private-foundations/open-philanthropy/open-phil-climate-change-grants.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/private-foundations/open-philanthropy/open-phil-criminal-justice-reform-grants.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/private-foundations/open-philanthropy/open-phil-givewell-recommended-grants.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/private-foundations/open-philanthropy/open-phil-global-health-and-development-grants.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/private-foundations/open-philanthropy/open-phil-land-use-reform-grants.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/private-foundations/open-philanthropy/open-phil-macroeconomic-stabilization-policy-grants.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/private-foundations/open-philanthropy/open-phil-migration-policy-grants.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/private-foundations/open-philanthropy/open-phil-other-gcr-and-security-grants.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/private-foundations/open-philanthropy/open-phil-other-grants.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/private-foundations/open-philanthropy/open-phil-scientific-research-grants.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/private-foundations/pineapple-fund-grants.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/private-foundations/public-welfare-foundation-grants.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/private-foundations/quixote-foundation-grants.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/private-foundations/robert-bowne-foundation-grants.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/private-foundations/sandler-foundation-grants.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/private-foundations/sloan-foundation-grants.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/private-foundations/smith-richardson-foundation-grants.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/private-foundations/stone-family-foundation-grants.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/private-foundations/surdna-foundation-grants.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/private-foundations/templeton-foundation-grants.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/private-foundations/the-lynde-and-harry-bradley-foundation-grants.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/private-foundations/theiss-research.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/private-foundations/thiel-foundation-grants.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/private-foundations/unbound-philanthropy-grants.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/private-foundations/wallenberg-foundation-grants.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/private-foundations/walton-family-foundation-grants.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/private-foundations/wellcome-trust-grants.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/private-foundations/william-e-simon-foundation-grants.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/subsidiaries/beri-grants.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/subsidiaries/eaf-fund.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/subsidiaries/ea-funds/ea-funds-animal-welfare.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/subsidiaries/ea-funds/ea-funds-global-health-and-development.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/subsidiaries/ea-funds/ea-funds-infrastructure.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/subsidiaries/ea-funds/ea-funds-long-term-future.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/subsidiaries/ea-grants.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/subsidiaries/givewell-incubation-grants.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/subsidiaries/givewell-maximum-impact-fund-grants.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/subsidiaries/good-ventures-givewell-support.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/subsidiaries/good-ventures-grants-to-givewell-top-charities.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/subsidiaries/good-ventures-not-givewell-or-open-phil.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/subsidiaries/survival-and-flourishing-fund-grants.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/subsidiaries/survival-and-flourishing-grants.sql

.PHONY: read_other_donations
read_other_donations:
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/donations.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/donees/ai-safety-camp-donations.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/donees/brain-preservation-foundation-donations.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/donees/donor-lottery-2016.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/donees/donor-lottery-2017-cea.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/donees/donor-lottery-2019-cea-100k.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/donees/donor-lottery-2019-cea-500k.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/donees/ea-hotel-donations.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/donees/miri-top-donations.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/individual-donors/aaron-gertler-donations.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/individual-donors/ajeya-cotra-donations.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/individual-donors/alexander-berger-donations.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/individual-donors/andrew-martin-donations.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/individual-donors/andrew-snyder-beattie-donations.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/individual-donors/anonymous-miri-crypto-donor-donations.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/individual-donors/ben-hoskin-donations.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/individual-donors/ben-kuhn-donations.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/individual-donors/ben-west-donations.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/individual-donors/blake-borgeson-donations.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/individual-donors/brian-tomasik-donations.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/individual-donors/catherine-hollander-donations.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/individual-donors/chelsea-tabart-donations.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/individual-donors/ea-survey.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/individual-donors/elie-hassenfeld-donations.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/individual-donors/eliezer-yudkowsky-donations.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/individual-donors/elizabeth-van-nostrand-donations.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/individual-donors/founders-pledge-donations.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/individual-donors/garrison-lovely-donations.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/individual-donors/gordon-irlam-donations.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/individual-donors/gwern-donations.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/individual-donors/haseeb-qureshi-donations.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/individual-donors/helen-toner-donations.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/individual-donors/holden-karnofsky-donations.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/individual-donors/howie-lempel-donations.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/individual-donors/isabel-arjmand-donations.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/individual-donors/jacob-steinhardt-donations.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/individual-donors/jalex-stark-donations.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/individual-donors/james-snowden-donations.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/individual-donors/jason-ketola-donations.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/individual-donors/jeff-kaufman-and-julia-wise-donations.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/individual-donors/joey-savoie-donations.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/individual-donors/josh-rosenberg-donations.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/individual-donors/liftigniter-giving-initiative.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/individual-donors/loren-merritt-donations.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/individual-donors/luke-muehlhauser-donations.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/individual-donors/michael-dello-iovaco-donations.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/individual-donors/michael-dickens-donations.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/individual-donors/morgan-davis-donations.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/individual-donors/natalie-crispin-donations.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/individual-donors/neil-sinhababu-donations.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/individual-donors/nick-beckstead-donations.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/individual-donors/old-givewell-donations.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/individual-donors/ozy-brennan-donations.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/individual-donors/pablo-stafforini-donations.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/individual-donors/patrick-brinich-langlois-donations.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/individual-donors/peter-hurford-donations.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/individual-donors/rebecca-raible-donations.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/individual-donors/rob-bensinger-donations.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/individual-donors/robert-yaman-donations.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/individual-donors/sophie-monahan-donations.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/individual-donors/vipul-naik-donations.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/individual-donors/vitalik-buterin-donations.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/individual-donors/william-ehlhardt-donations.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/individual-donors/zvi-mowshowitz-donations.sql

.PHONY: read_donees
read_donees:
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donees/donees-schema.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donees/donees.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donees/social-media-mass-grab.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donees/aiwatch-update.sql

.PHONY: read_donors
read_donors:
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donors/donors-schema.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donors/individual-donors.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donors/private-foundations-and-subsidiaries.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donors/aiwatch-update.sql

.PHONY: read_gifts
read_gifts:
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/gifts.sql

.PHONY: read_money_moved
read_money_moved:
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/money_moved/money_moved-schema.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/money_moved/double-up-drive.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/money_moved/givewell.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/money_moved/giving-tuesday-facebook-match.sql

.PHONY: read_disclosures
read_disclosures:
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/disclosures/disclosures-schema.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/disclosures/open-phil-disclosures.sql

.PHONY: read_donor_donee_relationships
read_donor_donee_relationships:
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donor_donee_relationships/donor_donee_relationships-schema.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donor_donee_relationships/donor_donee_relationships.sql

.PHONY: fetch_table_sorting
fetch_table_sorting:
	curl -Lo access-portal/jquery-3.1.1.min.js \
		'https://code.jquery.com/jquery-3.1.1.min.js'
	curl -Lo access-portal/jquery.tablesorter.js \
		'https://github.com/christianbach/tablesorter/raw/master/jquery.tablesorter.js'
	curl -Lo access-portal/style.css \
		'https://raw.githubusercontent.com/christianbach/tablesorter/master/themes/blue/style.css'
	curl -Lo access-portal/bg.gif \
		'https://github.com/christianbach/tablesorter/raw/master/themes/blue/bg.gif'
	curl -Lo access-portal/asc.gif \
		'https://github.com/christianbach/tablesorter/raw/master/themes/blue/asc.gif'
	curl -Lo access-portal/desc.gif \
		'https://github.com/christianbach/tablesorter/raw/master/themes/blue/desc.gif'

.PHONY: clean_table_sorting
clean_table_sorting:
	rm -f access-portal/jquery-3.1.1.min.js
	rm -f access-portal/jquery.tablesorter.js
	rm -f access-portal/style.css
	rm -f access-portal/bg.gif
	rm -f access-portal/asc.gif
	rm -f access-portal/desc.gif

.PHONY: fetch_anchorjs
fetch_anchorjs:
	curl -Lo access-portal/anchor.min.js \
		'https://raw.githubusercontent.com/bryanbraun/anchorjs/master/anchor.min.js'

.PHONY: clean_anchorjs
clean_anchorjs:
	rm -f access-portal/anchor.min.js

.PHONY: compute_similarity_php
compute_similarity_php:
	mysql $(MYSQL_ARGS) -e "use $(DATABASE); drop table if exists similarity;"
	mysql $(MYSQL_ARGS) $(DATABASE) < similarity/similarity-schema.sql
	php -f similarity/compute_similarity.php

.PHONY: reset_similarity
reset_similarity:
	mysql $(MYSQL_ARGS) -e "use $(DATABASE); drop table if exists similarity;"
	mysql $(MYSQL_ARGS) $(DATABASE) < similarity/similarity-schema.sql

.PHONY: compute_similarity
compute_similarity:
	mysql $(MYSQL_ARGS) $(DATABASE) < similarity/similarity-3.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < similarity/similarity-4.sql

.PHONY: reset_cache
reset_cache:
	rm -fr access-portal/cache
	mkdir -p access-portal/cache
	chmod a+rwx -R access-portal/cache
	touch access-portal/cache/DB_LAST_UPDATE_TRACKER

.PHONY: build_cache
build_cache:
	curl --silent 'https://donations.vipulnaik.com/' > /dev/null
	curl --silent 'https://donations.vipulnaik.com/?display=individual-scale' > /dev/null
	curl --silent 'https://donations.vipulnaik.com/donor.php?donor=Open+Philanthropy' > /dev/null
	curl --silent 'https://donations.vipulnaik.com/donee.php?donee=Machine+Intelligence+Research+Institute' > /dev/null
	curl --silent 'https://donations.vipulnaik.com/?display=full' > /dev/null
