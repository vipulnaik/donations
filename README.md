# donations

coming soon

Note that the passwordFile.inc file in access-portal/backend/globalVariables is excluded from the Git repository, but you can see a corresponding dummy password file at [dummyPasswordFile.inc](https://github.com/vipulnaik/donations/blob/master/access-portal/backend/globalVariables/dummyPasswordFile.inc).

## Setting up

From the shell run (note this will create and read into a `donations` database,
so be careful if you already have a database with that name):

    make init && make read

If you need to pass in arguments to `mysql`, use the `MYSQL_ARGS` variable:

    make read MYSQL_ARGS="-u user -psecret"

After modifying the SQL instructions, use `reset` to drop the tables:

    make reset && make read

Once the database is ready, one can run the site locally:

    cp access-portal/backend/globalVariables/{dummyPasswordFile.inc,passwordFile.inc}
    vi access-portal/backend/globalVariables/passwordFile.inc # change to add database login info
    cd access-portal
    php -S localhost:8000

Now one can visit `http://localhost:8000/index.php` in one’s browser.

For table sorting:

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
