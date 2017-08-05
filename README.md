# donations

Available at https://donations.vipulnaik.com but still in beta

Note that the `passwordFile.inc` file in `access-portal/backend/globalVariables` is excluded from the Git repository, but you can see a corresponding dummy password file at [`dummyPasswordFile.inc`](https://github.com/vipulnaik/donations/blob/master/access-portal/backend/globalVariables/dummyPasswordFile.inc).

## Setting up

From the shell run (note this will create and read into a `donations` database,
so be careful if you already have a database with that name):

    make init && make read

If you need to pass in arguments to `mysql`, use the `MYSQL_ARGS` variable:

    make read MYSQL_ARGS="-u user -psecret"

After modifying the SQL instructions, use `reset` to drop the tables:

    make reset && make read

Once the database is ready, you can run the site locally:

    cp access-portal/backend/globalVariables/{dummyPasswordFile.inc,passwordFile.inc}
    vi access-portal/backend/globalVariables/passwordFile.inc # change to add database login info
    cd access-portal
    php -S localhost:8000

Now you can visit `http://localhost:8000/index.php` in your browser.

To show the similarity table, the values must be precomputed. To do that, first
run (this only needs to be run once):

    make reset_similarity

Then each time the donations data changes, run:

    make compute_similarity

For table sorting:

    make fetch_table_sorting

This will fetch the necessary files to allow tables to be sorted.
To remove these files, run `make clean_table_sorting`.
