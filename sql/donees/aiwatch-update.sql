# -- This will only work if you have already got the orgwatch/aiwatch database on the same MySQL server, with name `aiwatch`. Get the database from https://github.com/riceissa/aiwatch
update donees set orgwatch = true where donee in (select distinct organization from aiwatch.organizations);
