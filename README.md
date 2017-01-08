# donations

coming soon

## Setting up

From the shell run (note this will create and read into a `donations` database,
so be careful if you already have a database with that name):

    make init && make read

If you need to pass in arguments to `mysql`, use the `MYSQL_ARGS` variable:

    make read MYSQL_ARGS="-u user -psecret"
