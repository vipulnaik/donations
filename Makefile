MYSQL_ARGS=
DATABASE=donations

.PHONY: reset
reset:
	mysql $(MYSQL_ARGS) -e "use $(DATABASE); drop table if exists donations;"
	mysql $(MYSQL_ARGS) -e "use $(DATABASE); drop table if exists donors;"

.PHONY: init
init:
	mysql $(MYSQL_ARGS) -e "create database $(DATABASE);"

.PHONY: read
read:
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donations.sql
	mysql $(MYSQL_ARGS) $(DATABASE) < sql/donors.sql
