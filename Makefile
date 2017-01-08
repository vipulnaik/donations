MYSQL_ARGS=

.PHONY: reset
reset:
	mysql $(MYSQL_ARGS) -e "use donations; drop table if exists donations;"
	mysql $(MYSQL_ARGS) -e "use donations; drop table if exists donors;"

.PHONY: init
init:
	mysql $(MYSQL_ARGS) -e "create database donations; use donations;"

.PHONY: read
read:
	mysql $(MYSQL_ARGS) donations < sql/donations.sql
	mysql $(MYSQL_ARGS) donations < sql/donors.sql
