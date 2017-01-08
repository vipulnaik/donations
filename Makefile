.PHONY: reset
reset:
	mysql -e "use donations; drop table if exists donations;"
	mysql -e "use donations; drop table if exists donors;"
