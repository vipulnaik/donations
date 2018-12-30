MYSQL_ARGS=
DATABASE=donations

.PHONY: reset
reset:
	mysql $(MYSQL_ARGS) -e "use $(DATABASE); drop table if exists documents;"
	mysql $(MYSQL_ARGS) -e "use $(DATABASE); drop table if exists donations;"
	mysql $(MYSQL_ARGS) -e "use $(DATABASE); drop table if exists donees;"
	mysql $(MYSQL_ARGS) -e "use $(DATABASE); drop table if exists donors;"
	mysql $(MYSQL_ARGS) -e "use $(DATABASE); drop table if exists gifts;"
	mysql $(MYSQL_ARGS) -e "use $(DATABASE); drop table if exists money_moved;"
	mysql $(MYSQL_ARGS) -e "use $(DATABASE); drop table if exists disclosures;"
	rm -fr access-portal/cache
	mkdir -p access-portal/cache
	chmod a+rwx -R access-portal/cache
	touch access-portal/cache/DB_LAST_UPDATE_TRACKER

.PHONY: init
init:
	mkdir -p access-portal/images
	mysql $(MYSQL_ARGS) -e "create database $(DATABASE);"

# To update this section, paste the output of:
#     find ./sql -type f -iname '*.sql' | sort | sed 's/^\.\//\tmysql $(MYSQL_ARGS) $(DATABASE) < /'
# Then move the SQL files ending in "-schema" to the top. In Vim you can
# visually select the .sql lines:
#     '<,'>g/-schema/m'<-1
.PHONY: read
read:
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/documents/documents-schema.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/donations-schema.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donees/donees-schema.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donors/donors-schema.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/disclosures/disclosures-schema.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/disclosures/open-phil-disclosures.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/documents/80k-docs.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/documents/ace-docs.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/documents/aidgrade-docs.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/documents/ai-impacts-docs.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/documents/ai-safety-docs.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/documents/allfed-docs.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/documents/animal-equality-docs.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/documents/beri-docs.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/documents/berkeley-reach.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/documents/cea-docs.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/documents/cfar-docs.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/documents/charity-science-docs.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/documents/criminal-justice-reform-docs.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/documents/czi-docs.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/documents/dickens-docs.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/documents/documents.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/documents/donor-lottery-docs.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/documents/ea-funds-docs.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/documents/ea-grants-docs.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/documents/evidence-action-docs.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/documents/gfi-docs.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/documents/givewell-docs.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/documents/gwwc-docs.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/documents/hurford-docs.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/documents/life-extension-docs.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/documents/lw2-docs.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/documents/mfa-docs.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/documents/miri-docs.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/documents/one-for-the-world-docs.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/documents/open-phil-docs.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/documents/oxprio.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/documents/rethink-charity-docs.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/documents/thl-docs.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/documents/vegan-outreach-docs.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/documents/was-research-docs.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/documents/wmf-docs.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/donations.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/donees/ai-safety-camp.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/donees/brain-preservation-foundation-donations.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/donees/donor-lottery-2016.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/donees/donor-lottery-2017-cea.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/donees/miri-top-donations.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/donees/one-for-the-world-donations.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/private-foundations/arch-community-fund-grants.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/private-foundations/arnold-foundation-grants.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/private-foundations/barr-foundation-grants.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/private-foundations/dell-foundation-grants.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/private-foundations/ford-foundation-grants.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/private-foundations/ea-giving-group.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/private-foundations/foundational-questions-institute-grants.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/private-foundations/future-justice-fund-grants.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/private-foundations/future-of-life-institute-grants.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/private-foundations/gates-foundation-grants.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/private-foundations/google-org.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/private-foundations/hewlett-foundation-grants.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/private-foundations/kellogg-foundation-grants.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/private-foundations/knight-foundation-grants.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/private-foundations/lilly-endowment-grants.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/private-foundations/mcdowell-foundation-grants.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/private-foundations/mulago-foundation-grants.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/private-foundations/nathan-cummings-foundation-grants.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/private-foundations/open-phil-grants.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/private-foundations/pineapple-fund-grants.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/private-foundations/public-welfare-foundation-grants.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/private-foundations/sloan-foundation-grants.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/private-foundations/stone-family-foundation-grants.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/private-foundations/templeton-foundation-grants.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/private-foundations/theiss-research.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/private-foundations/unbound-philanthropy-grants.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/private-foundations/wallenberg-foundation-grants.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/private-foundations/wellcome-trust-grants.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/subsidiaries/beri-grants.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/subsidiaries/eaf-fund.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/subsidiaries/ea-funds.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/subsidiaries/ea-grants.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/subsidiaries/givewell-discretionary-regranting.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/subsidiaries/givewell-incubation-grants.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/subsidiaries/good-ventures-givewell-support.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/subsidiaries/good-ventures-grants-to-givewell-top-charities.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/subsidiaries/good-ventures-not-givewell-or-open-phil.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/individual-donors/aaron-gertler-donations.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/individual-donors/ajeya-cotra-donations.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/individual-donors/alexander-berger-donations.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/individual-donors/andrew-martin-donations.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/individual-donors/ben-hoskin-donations.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/individual-donors/ben-kuhn-donations.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/individual-donors/blake-borgeson-donations.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/individual-donors/brian-tomasik-donations.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/individual-donors/catherine-hollander-donations.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/individual-donors/chelsea-tabart-donations.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/individual-donors/ea-survey.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/individual-donors/elie-hassenfeld-donations.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/individual-donors/elizabeth-van-nostrand-donations.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/individual-donors/founders-pledge-donations.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/individual-donors/gordon-irlam-donations.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/individual-donors/gwern-donations.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/individual-donors/haseeb-qureshi-donations.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/individual-donors/helen-toner-donations.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/individual-donors/holden-karnofsky-donations.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/individual-donors/isabel-arjmand-donations.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/individual-donors/jacob-steinhardt-donations.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/individual-donors/james-snowden-donations.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/individual-donors/jason-ketola-donations.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/individual-donors/jeff-kaufman-and-julia-wise-donations.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/individual-donors/joey-savoie-donations.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/individual-donors/josh-rosenberg-donations.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/individual-donors/liftigniter-giving-initiative.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/individual-donors/loren-merritt-donations.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/individual-donors/michael-dello-iovaco-donations.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/individual-donors/michael-dickens-donations.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/individual-donors/natalie-crispin-donations.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/individual-donors/neil-sinhababu-donations.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/individual-donors/nick-beckstead-donations.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/individual-donors/old-givewell-donations.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/individual-donors/ozy-brennan-donations.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/individual-donors/pablo-stafforini-donations.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/individual-donors/patrick-brinich-langlois-donations.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/individual-donors/peter-hurford-donations.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/individual-donors/rebecca-raible-donations.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/individual-donors/robert-yaman-donations.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/individual-donors/sophie-monahan-donations.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/individual-donors/vipul-naik-donations.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/individual-donors/vitalik-buterin-donations.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/individual-donors/zvi-mowshowitz-donations.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donees/donees.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donees/social-media-mass-grab.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donees/aiwatch-update.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donors/individual-donors.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donors/private-foundations-and-subsidiaries.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donors/aiwatch-update.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/gifts.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/money_moved.sql

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

.PHONY: build_cache
build_cache:
	curl --silent 'https://donations.vipulnaik.com/' > /dev/null
	curl --silent 'https://donations.vipulnaik.com/?display=individual-scale' > /dev/null
	curl --silent 'https://donations.vipulnaik.com/donor.php?donor=Open+Philanthropy+Project' > /dev/null
	curl --silent 'https://donations.vipulnaik.com/donee.php?donee=Machine+Intelligence+Research+Institute' > /dev/null
	curl --silent 'https://donations.vipulnaik.com/?display=full' > /dev/null
