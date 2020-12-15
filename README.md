# Donations list website (DLW)

Available at https://donations.vipulnaik.com but still in beta!

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

For [AnchorJS](https://github.com/bryanbraun/anchorjs):

    make fetch_anchorjs

To remove AnchorJS, run `make clean_anchorjs`.

## Tutorial

This section is a tutorial of the main features of Donations List Website
(DLW), with a focus on the parts that are probably non-obvious to casual users.

### Main page

The [main page](https://donations.vipulnaik.com) of DLW shows information
aggregated from all donations tracked by the site.
The main page has the path starting with `/` or `/index.php`.

The main page of DLW has an optional parameter called `display` that changes
the kind and number of donations listed.
Currently, the possible values are:

* [`individual-scale`](https://donations.vipulnaik.com/?display=individual-scale),
  which displays donations made by individuals (in other words, excluding
  donations made by private foundations and other group entities)
* [`full`](https://donations.vipulnaik.com/?display=full),
  which displays all donations tracked by DLW
* [empty value](https://donations.vipulnaik.com/) (the default), which restricts
  donations to the top 30 donors, donees, and cause areas

### Donor page

Each donor tracked by DLW has a donor page.
Donor pages have a path starting with `/donor.php`.
An example is the [donor page for the Open Philanthropy
Project](https://donations.vipulnaik.com/donor.php?donor=Open+Philanthropy+Project).

For the Open Philanthropy Project in particular, there is a [table of disclosures](https://donations.vipulnaik.com/donor.php?donor=Open+Philanthropy+Project#donorDonationAmountsByDisclosuresAndYear) (from before it stopped announcing disclosures).
Currently no other donor has disclosures data.

### Donee page

Each donee tracked by DLW has a donee page.
Donee pages have a path starting with `/donee.php`.
An example is the [donee page for
LessWrong 2.0](https://donations.vipulnaik.com/donee.php?donee=LessWrong+2.0).

Some entities are both a donor and a donee, in which case there will be separate pages
for each role. An example is the Berkeley Existential Risk Initiative (BERI):

* [BERI as a donor](https://donations.vipulnaik.com/donor.php?donor=Berkeley+Existential+Risk+Initiative)
* [BERI as a donee](https://donations.vipulnaik.com/donee.php?donee=Berkeley+Existential+Risk+Initiative)

### Donor–donee page

It is sometimes interesting to look at a specific donor–donee pair and see all the donations made by the donor to the donee, their relationship, a list of documents that mention both of them, and so on.
For this, DLW has a donor–donee page for each such pair.
Donor–donee pages have a path starting with `/donorDonee.php`.
An example of this is the page for
[Open Philanthropy Project donations made to the Machine Intelligence Research Institute](https://donations.vipulnaik.com/donorDonee.php?donor=Open+Philanthropy+Project&donee=Machine+Intelligence+Research+Institute).

### Influencer page

The influencer page looks at the amount of money influenced
(a.k.a. the "[money moved](https://www.givewell.org/about/impact#MoneyMovedDefinition)") by an entity.
This is tracked separately from donations, so it is possible to compare the
amount of money moved that is *claimed* (gathered from the entity claiming money moved, e.g. GiveWell)
with the amount of money moved that is
*actually accounted for* (gathered from the entities making or receiving the donations, e.g. Against Malaria
Foundation or individual donors).
Influencer pages have a path starting with `/influencer.php`.

The only entity for which we currently track money moved information is GiveWell.
You can see the amount of influence claimed vs amount of money accounted for in the
[money moved table](https://donations.vipulnaik.com/influencer.php?influencer=GiveWell#influencerMoneyMovedList).

Even for non-GiveWell entities, influencer pages exist. An example is
[Chloe Cockburn](https://donations.vipulnaik.com/influencer.php?influencer=Chloe+Cockburn).
In these cases, there is no comparison between the "money moved claimed" and
"money moved accounted for", because we have not entered any data for the "money moved claimed".
However, it is still possible to see a list of all donations that were influenced.

### Cause area filter

Most pages on DLW accept an optional cause area parameter called `cause_area_filter`.
Using this parameter filters the donations to show only those with a matching
cause area.

To give some examples:

* [Open Philanthropy Project's AI safety donations](https://donations.vipulnaik.com/donor.php?donor=Open+Philanthropy+Project&cause_area_filter=AI+safety) (note the `cause_area_filter=AI+safety` in the URL)
* [AI safety donations in general](https://donations.vipulnaik.com/?cause_area_filter=AI+safety)
  (note the `cause_area_filter=AI+safety` in the URL)
* Since the cause areas used on DLW track sub-cause areas as well, it is possible to use it a little
  like a search feature. For example, using [`cause_area_filter=chicken` on Open Philanthropy Project
  donations](https://donations.vipulnaik.com/donor.php?donor=Open+Philanthropy+Project&cause_area_filter=chicken)
  shows all donations that have the string "chicken" somewhere in the cause area.
* [Chloe Cockburn donations influenced with sub-cause area matching
  "bail reform"](https://donations.vipulnaik.com/influencer.php?influencer=Chloe+Cockburn&cause_area_filter=bail+reform)
  (for influencer pages, currently the filtering only works on some of the tables)
* The cause area filter supports [regular expressions](https://en.wikipedia.org/wiki/Regular_expression),
  so for example you can search for [all Open Philanthropy Project donations with cause area containing "AI safety" or "chicken"](https://donations.vipulnaik.com/donor.php?donor=Open+Philanthropy+Project&cause_area_filter=AI+safety|chicken).
  (This example is a bit silly and I'm not aware of a better example.)

Donee pages don't have this option, because most donees only work within a single cause area.

### About page

The [about page](https://donations.vipulnaik.com/about/) discusses how DLW is built and
reliability concerns for the data.
