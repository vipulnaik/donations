.PHONY: reset
reset:
	mysql -e "use donations; drop table donations; drop table donors;"
