# -- This will only work if you have already got the aiwatch database on the same MySQL server, with name `aiwatch`. Get the database from https://github.com/riceissa/aiwatch
update donors set aiwatch = true where donor in (select distinct person from aiwatch.people);
