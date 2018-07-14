# -- This will only work if you have already got the orgwatch/aiwatch database on the same MySQL server, with name `aiwatch`. Get the database from https://github.com/riceissa/aiwatch
update donors set orgwatch = true where donor in (select distinct person from aiwatch.people) and donor_type = 'Individual';
update donors set orgwatch = true where donor in (select distinct organization from aiwatch.organizations) and donor_type in ('Private foundation','Subsidiary');

