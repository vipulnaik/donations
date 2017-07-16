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

.PHONY: init
init:
	mkdir -p access-portal/images
	mysql $(MYSQL_ARGS) -e "create database $(DATABASE);"

# To update this section, paste the output of:
#     find . -type f -iname '*.sql' | sort | sed 's/^\.\//\tmysql $(MYSQL_ARGS) $(DATABASE) < /'
# Then move the SQL files ending in "-schema" to the top.
.PHONY: read
read:
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/documents/documents-schema.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/donations-schema.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/documents/80k-docs.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/documents/ace-docs.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/documents/cfar-docs.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/documents/dickens-docs.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/documents/documents.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/documents/ea-funds-docs.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/documents/givewell-docs.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/documents/gwwc-docs.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/documents/miri-docs.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/documents/open-phil-docs.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/documents/oxprio.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/documents/rethink-charity-docs.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/aaron-gertler-donations.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/alexander-berger-donations.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/arnold-foundation-grants.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/ben-kuhn-donations.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/brian-tomasik-donations.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/donations.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/donor-lottery.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/ea-funds.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/elie-hassenfeld-donations.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/elizabeth-van-nostrand-donations.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/gates-foundation-grants.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/givewell-and-good-ventures.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/google-org.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/haseeb-qureshi-donations.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/holden-karnofsky-donations.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/jacob-steinhardt-donations.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/jeff-kaufman-and-julia-wise-donations.sql
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
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/vipul-naik-donations.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donees.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donors.sql
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
