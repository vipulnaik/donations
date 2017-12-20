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
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/documents/cea-docs.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/documents/cfar-docs.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/documents/charity-science-docs.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/documents/dickens-docs.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/documents/documents.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/documents/donor-lottery-docs.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/documents/ea-funds-docs.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/documents/givewell-docs.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/documents/gwwc-docs.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/documents/hurford-docs.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/documents/miri-docs.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/documents/open-phil-docs.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/documents/oxprio.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/documents/rethink-charity-docs.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/aaron-gertler-donations.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/ajeya-cotra-donations.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/alexander-berger-donations.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/arnold-foundation-grants.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/ben-kuhn-donations.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/blake-borgeson-donations.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/brian-tomasik-donations.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/donations.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/donor-lottery.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/ea-funds.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/ea-grants.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/ea-survey.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/elie-hassenfeld-donations.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/elizabeth-van-nostrand-donations.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/gates-foundation-grants.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/givewell-discretionary-regranting.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/givewell-incubation-grants.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/good-ventures-givewell-support.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/good-ventures-grants-to-givewell-top-charities.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/good-ventures-not-givewell-or-open-phil.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/google-org.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/haseeb-qureshi-donations.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/holden-karnofsky-donations.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/jacob-steinhardt-donations.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/jeff-kaufman-and-julia-wise-donations.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/joey-savoie.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/josh-rosenberg-donations.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/michael-dickens-donations.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/miri-top-donations.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/neil-sinhababu-donations.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/old-givewell-donations.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/open-phil-grants.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/ozy-brennan-donations.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/pablo-stafforini-donations.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/patrick-brinich-langlois-donations.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/peter-hurford-donations.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/sophie-monahan-donations.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/vipul-naik-donations.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donees/donees.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donees/social-media-mass-grab.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donors/individual-donors.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donors/private-foundations.sql
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
	mysql $(MYSQL_ARGS) $(DATABASE) < similarity/similarity-2.sql
