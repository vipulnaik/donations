MYSQL_ARGS=
DATABASE=donations

.PHONY: reset
reset:
	mysql $(MYSQL_ARGS) -e "use $(DATABASE); drop table if exists documents;"
	mysql $(MYSQL_ARGS) -e "use $(DATABASE); drop table if exists donations;"
	mysql $(MYSQL_ARGS) -e "use $(DATABASE); drop table if exists donees;"
	mysql $(MYSQL_ARGS) -e "use $(DATABASE); drop table if exists donors;"
	mysql $(MYSQL_ARGS) -e "use $(DATABASE); drop table if exists gifts;"

.PHONY: init
init:
	mysql $(MYSQL_ARGS) -e "create database $(DATABASE);"

.PHONY: read
read:
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/documents/documents.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/documents/oxprio.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/donations.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/givewell-and-good-ventures-misc.sql
        mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/open-phil-grants.sql
        mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/arnold-foundation-grants.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/google-org.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/ea-funds.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations/gates-foundation-grants.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donees.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donors.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/gifts.sql

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
