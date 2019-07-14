# Data update playbook

Issue tracking this page: https://github.com/vipulnaik/donations/issues/52

General caution: Websites and data formats change all the time. If a script fails to run, be prepared to fix it or find someone to fix it.

## Table of contents

* [Foundations](#foundations)
   * [Andrea &amp; Charles Bronfman Philanthropies](#andrea--charles-bronfman-philanthropies)
   * [Arnold Foundation](#arnold-foundation)
   * [Barr Foundation](#barr-foundation)
   * [Bradley Foundation](#bradley-foundation)
   * [Dell Foundation](#dell-foundation)
   * [Donors Trust](#donors-trust)
   * [EA Giving Group](#ea-giving-group)
   * [Earhart Foundation](#earhart-foundation)
   * [F. M. Kirby Foundation](#f-m-kirby-foundation)
   * [Ford Foundation](#ford-foundation)
   * [Foundational Questions Institute (FQXi)](#foundational-questions-institute-fqxi)
   * [Future Justice Fund](#future-justice-fund)
   * [Future of Life Institute](#future-of-life-institute)
   * [Gates Foundation](#gates-foundation)
   * [Google.org](#googleorg)
   * [Haas, Jr. Fund](#haas-jr-fund)
   * [Hewlett Foundation](#hewlett-foundation)
   * [Kellogg Foundation](#kellogg-foundation)
   * [Knight Foundation](#knight-foundation)
   * [Lilly Endowment](#lilly-endowment)
   * [MacArthur Foundation](#macarthur-foundation)
   * [Barbara McDowell and Gerald S. Hartman Foundation](#barbara-mcdowell-and-gerald-s-hartman-foundation)
   * [Andrew W. Mellon Foundation](#andrew-w-mellon-foundation)
   * [Mulago](#mulago)
   * [Nathan Cummings Foundation](#nathan-cummings-foundation)
   * [John Merck Fund](#john-merck-fund)
   * [John M. Olin Foundation](#john-m-olin-foundation)
   * [Open Philanthropy Project](#open-philanthropy-project)
   * [Pineapple Fund](#pineapple-fund)
   * [Public Welfare Foundation](#public-welfare-foundation)
   * [Quixote Foundation](#quixote-foundation)
   * [Robert Bowne Foundation](#robert-bowne-foundation)
   * [Sloan Foundation](#sloan-foundation)
   * [Smith Richardson Foundation](#smith-richardson-foundation)
   * [Stone Family Foundation](#stone-family-foundation)
   * [Surdna Foundation](#surdna-foundation)
   * [Templeton Foundation](#templeton-foundation)
   * [Theiss Research](#theiss-research)
   * [Unbound Philanthropy](#unbound-philanthropy)
   * [Knut and Alice Wallenberg Foundation](#knut-and-alice-wallenberg-foundation)
   * [Walton Family Foundation](#walton-family-foundation)
   * [Wellcome Trust](#wellcome-trust)
   * [William E. Simon Foundation](#william-e-simon-foundation)
* [Individual donors](#individual-donors)
   * [Aaron Gertler](#aaron-gertler)
   * [Ajeya Cotra](#ajeya-cotra)
   * [Alexander Berger](#alexander-berger)
   * [Andrew Martin](#andrew-martin)
   * [Ben Hoskin](#ben-hoskin)
   * [Ben Kuhn](#ben-kuhn)
   * [Blake Borgeson](#blake-borgeson)
   * [Brian Tomasik](#brian-tomasik)
   * [Catherine Hollander](#catherine-hollander)
   * [Chelsea Tabart](#chelsea-tabart)
   * [EA Survey](#ea-survey)
   * [Elie Hassenfeld](#elie-hassenfeld)
   * [Elizabeth Van Nostrand](#elizabeth-van-nostrand)
   * [Founders Pledge](#founders-pledge)
   * [Gordon Irlam](#gordon-irlam)
   * [Haseeb Qureshi](#haseeb-qureshi)
   * [Helen Toner](#helen-toner)
   * [Holden Karnofsky](#holden-karnofsky)
   * [Isabel Arjmand](#isabel-arjmand)
   * [Jacob Steinhardt](#jacob-steinhardt)
   * [James Snowden](#james-snowden)
   * [Jason Ketola](#jason-ketola)
   * [Jeff Kaufman and Julia Wise](#jeff-kaufman-and-julia-wise)
   * [Joey Savoie](#joey-savoie)
* [Donees](#donees)
   * [AI Safety Camp](#ai-safety-camp)
   * [Brain Preservation Foundation](#brain-preservation-foundation)
   * [Donor lottery](#donor-lottery)
   * [MIRI top donors](#miri-top-donors)
* [Subsidiaries](#subsidiaries)
   * [Berkeley Existential Risk Initiative](#berkeley-existential-risk-initiative)
   * [EA Funds](#ea-funds)
   * [EA Grants](#ea-grants)
   * [GiveWell discretionary regranting](#givewell-discretionary-regranting)
   * [GiveWell Incubation Grants](#givewell-incubation-grants)
   * [Good Ventures/GiveWell support](#good-venturesgivewell-support)
   * [Good Ventures/GiveWell top and standout charities](#good-venturesgivewell-top-and-standout-charities)
   * [Good Ventures/not recommended by GiveWell or Open Philanthropy Project](#good-venturesnot-recommended-by-givewell-or-open-philanthropy-project)

## Foundations

### Andrea & Charles Bronfman Philanthropies

Navigate to the directory for https://github.com/riceissa/andrea-and-charles-bronfman-philanthropies

Follow the instructions at https://github.com/riceissa/andrea-and-charles-bronfman-philanthropies#instructions-for-running-the-scripts

Copy the resulting SQL file to DLW repo at https://github.com/vipulnaik/donations/blob/master/sql/donations/private-foundations/andrea-and-charles-bronfman-philanthropies-grants.sql

### Arnold Foundation

Last attempted and successful update: 2019-04-13

Follow the instructions at https://github.com/riceissa/arnold-foundation-grants/blob/master/README.md#new-instructions

Then copy `out.sql` to https://github.com/vipulnaik/donations/blob/master/sql/donations/private-foundations/arnold-ventures-grants.sql

### Barr Foundation

Last attempted and successful update: 2018-11-23

From the [Barr Foundation repo](https://github.com/riceissa/barr-foundation) directory:

```bash
./scrape.py  # saves in data.csv
./proc.py > out.sql
```

Then copy `out.sql` to https://github.com/vipulnaik/donations/blob/master/sql/donations/private-foundations/barr-foundation-grants.sql

### Bradley Foundation

Navigate to the [conservativetransparency.org processing
repo](https://github.com/riceissa/conservativetransparency) directory.

Go to http://conservativetransparency.org/donor/the-lynde-and-harry-bradley-foundation/ and
download new CSV data by clicking on "Export CSV". Save this in the `data/`
directory.

Then run the processing script by following instructions at
https://github.com/riceissa/conservativetransparency#instructions-for-doing-a-run

### Dell Foundation

Navigate to the [Dell Foundation repo](https://github.com/riceissa/dell-foundation) directory on your local machine.

Go to https://www.msdf.org/funding/ and click on "show more" until no more grants can be shown. Then use Chrome's "copy element" from the DOM inspection tool (Ctrl+Shift+I) to get the DOM source. Save this as `data.html`.

Then run:

```bash
./proc.py > out.sql
```

Then _append_ (don't override) some subset of `out.sql` to <https://github.com/vipulnaik/donations/blob/master/sql/donations/private-foundations/dell-foundation-grants.sql>. This one is a little tricky because I think Dell Foundation keeps tossing out older grants, so we have to check which grants are new. There isn't a script that does this yet.

### Donors Trust

Navigate to the [conservativetransparency.org processing
repo](https://github.com/riceissa/conservativetransparency) directory.

Go to http://conservativetransparency.org/donor/donorstrust/ and
download new CSV data by clicking on "Export CSV". Save this in the `data/`
directory.

Then run the processing script by following instructions at
https://github.com/riceissa/conservativetransparency#instructions-for-doing-a-run

### EA Giving Group

There is no official central location for updates to this, so just keep an eye out for mentions of it, I guess.

### Earhart Foundation

Navigate to the [conservativetransparency.org processing
repo](https://github.com/riceissa/conservativetransparency) directory.

Go to http://conservativetransparency.org/donor/earhart-foundation/ and
download new CSV data by clicking on "Export CSV". Save this in the `data/`
directory.

Then run the processing script by following instructions at
https://github.com/riceissa/conservativetransparency#instructions-for-doing-a-run

### F. M. Kirby Foundation

Navigate to the [conservativetransparency.org processing
repo](https://github.com/riceissa/conservativetransparency) directory.

Go to http://conservativetransparency.org/donor/f-m-kirby-foundation/ and
download new CSV data by clicking on "Export CSV". Save this in the `data/`
directory.

Then run the processing script by following instructions at
https://github.com/riceissa/conservativetransparency#instructions-for-doing-a-run

### Ford Foundation

Last attempted and successful update: 2018-11-23

Navigate to the [Ford Foundation repo](https://github.com/riceissa/ford-foundation) directory.

Go to https://www.fordfoundation.org/work/our-grants/grants-database/grants-all

Change the years in the "Year" column to the whole range (2006 to the present year).

Then click "download CSV" and save as `grants2.csv`.

Now run:

```bash
./proc.py > out.sql
```

Then copy `out.sql` to https://github.com/vipulnaik/donations/blob/master/sql/donations/private-foundations/ford-foundation-grants.sql

### Foundational Questions Institute (FQXi)

Last attempted and successful update: 2018-11-23

Navigate to the [FQXi repo](https://github.com/riceissa/fqxi-grants) directory.

Go to https://fqxi.org/grants and see if there is a grants page for a new year of grants. If there isn't, there is nothing to do. If there is, download the page source and place it in the `data` directory.

Edit `proc.py` to add this new file to the `DATA` list. (Um, this should probably be done automatically by searching the file system...)

Then run:

```bash
./proc.py > out.sql
```

Then copy `out.sql` to https://github.com/vipulnaik/donations/blob/master/sql/donations/private-foundations/foundational-questions-institute-grants.sql

### Future Justice Fund

Navigate to the [Future Justice Fund repo](https://github.com/riceissa/future-justice-fund) directory.

Look on the FJF website for new grants. The two focus areas that were present at the time of first data collection are listed at https://github.com/vipulnaik/donations/issues/59#issue-326887796 but there might be more focus areas by now.

Manually edit `data.txt` to add the new grants. You'll have to manually diff this, sorry!

Then run:

```bash
./proc.py > out.sql
```

Then copy `out.sql` to https://github.com/vipulnaik/donations/blob/master/sql/donations/private-foundations/future-justice-fund-grants.sql

### Future of Life Institute

Last attempted and successful update: 2018-11-23 (url transition HTTP
-> HTTPS on 2018-11-24)

Navigate to the [FLI grants repo](https://github.com/riceissa/fli-grants) directory.

Check if grants have been awarded for a new year (as of now, there are existing scripts for 2015 and 2018).

If there are grants for a new year, save the raw data for that year
(HTML file) in the file YYYY-grants.html, then copy proc_2018.py to a
script proc_YYYY.py for the new year and edit the dates and script structure as needed.

Now run:

./proc_YYYY.py >> out.sql

Note the use of >> instead of > to append.

Once you have out.sql you should copy it over to
https://github.com/vipulnaik/donations/blob/master/sql/donations/private-foundations/future-of-life-institute-grants.sql
and then do a careful git diff to make sure it works as expected.

There is one subtlety: a few grants may have been manually massaged
due to multiple data sources referencing that grant. It may therefore
be more prudent to just copy over the grants for the new year, or to
carefully check the relevant git diffs.

### Gates Foundation

Last attempted and successful update: 2019-03-24

Follow the instructions in the [gates-foundation-iati-processing README](https://github.com/riceissa/gates-foundation-iati-processing/) and then copy the output file (out.sql) to https://github.com/vipulnaik/donations/blob/master/sql/donations/private-foundations/gates-foundation-grants.sql

### Google.org

This was all manual, and automation work began but has stalled. See https://github.com/vipulnaik/donations/issues/47

### Haas, Jr. Fund

Navigate to the [Haas, Jr. Fund grants data repo](https://github.com/riceissa/haasjr-fund) directory.

Follow instructions [here](https://github.com/riceissa/haasjr-fund#instructions-for-doing-a-run).

Then copy the SQL file to https://github.com/vipulnaik/donations/blob/master/sql/donations/private-foundations/haas-jr-fund-grants.sql

### Hewlett Foundation

Last attempted and successful update: 2019-03-28

Navigate to the [Hewlett Foundation repo](https://github.com/riceissa/hewlett-foundation) directory.

Run the following:

```bash
# Get today's date
today=$(date -Idate)

# Get new data; this takes maybe 30 minutes
./scrape.py data-$today.csv

# Convert CSV to SQL
./proc.py data-$today.csv > out-$today.sql
```

Then copy `out-YYYY-MM-DD.sql` to https://github.com/vipulnaik/donations/blob/master/sql/donations/private-foundations/hewlett-foundation-grants.sql

### Kellogg Foundation

Navigate to the [Kellogg Foundation repo](https://github.com/riceissa/kellogg-foundation)
directory.

Run the commands listed at:
https://github.com/riceissa/kellogg-foundation#getting-data-and-generating-sql-file

### Knight Foundation

Last attempted and successful update: 2019-03-24

Navigate to the [Knight Foundation grants repo](https://github.com/riceissa/knight-foundation) directory.

Run the following:

```bash
./scrape.py  # overwrites data.csv
./proc.py > out.sql
```

Then copy `out.sql` to https://github.com/vipulnaik/donations/blob/master/sql/donations/private-foundations/knight-foundation-grants.sql

### Lilly Endowment

Navigate to the [Lilly Endowment grants repo](https://github.com/riceissa/lilly-endowment)
directory.

Run the commands listed at
https://github.com/riceissa/lilly-endowment#how-to-get-new-data-and-generate-the-sql-statements

### MacArthur Foundation

Last attempted and successful update: 2018-11-28 (data), 2018-12-30 (actual insertion)

Navigate to the [MacArthur Foundation repo](https://github.com/riceissa/macarthur-foundation) directory.

Follow the instructions at https://github.com/riceissa/macarthur-foundation#instructions-for-doing-a-run

Then copy `out.sql` to https://github.com/vipulnaik/donations/blob/master/sql/donations/private-foundations/macarthur-foundation-grants.sql

### Barbara McDowell and Gerald S. Hartman Foundation

Last attempted and successful update: 2018-11-23 (verified on 2019-03-24 that no further updates)

Navigate to the [Barbara McDowell and Gerald S. Hartman Foundation grants data repo](https://github.com/riceissa/mcdowell-foundation) directory.

Run the following:

```bash
./scrape.py  # overwrites data.csv
./proc.py > out.sql
```

Then copy `out.sql` to https://github.com/vipulnaik/donations/blob/master/sql/donations/private-foundations/mcdowell-foundation-grants.sql

### Andrew W. Mellon Foundation

Navigate to the [Andrew W. Mellon Foundation grants data repo](https://github.com/riceissa/mellon-foundation) directory.

Follow instructions [here](https://github.com/riceissa/mellon-foundation#instructions-for-doing-a-run).

Then copy the SQL file to https://github.com/vipulnaik/donations/blob/master/sql/donations/private-foundations/mellon-foundation-grants.sql

### Mulago

Last attempted and successful update: 2018-11-29 (actual insertion done 2018-12-30)

Navigate to the [Mulago grants repo](https://github.com/riceissa/mulago) directory.

Go to http://mulagofoundation.org/portfolio and save it as `who-we-fund.html`. Note: this might be in a different format since the last time the script ran, because the location of the "who we fund" page has changed. See [this comment](https://github.com/vipulnaik/donations/issues/46#issuecomment-401624626) for more.

Then run the following:

```bash
./scrape.py  # uses who-we-fund.html and overwrites data.csv
./proc.py > out.sql
```

Then copy `out.sql` to https://github.com/vipulnaik/donations/blob/master/sql/donations/private-foundations/mulago-foundation-grants.sql

### Nathan Cummings Foundation

Navigate to the [Nathan Cummings Foundation repo](https://github.com/riceissa/nathan-cummings-foundation) directory.

This one is pretty complicated. It will probably involve uploading a PDF to Google Docs and converting to a plain text data file, manually cleaning that file, and running the appropriate processing script on that file. See https://github.com/riceissa/nathan-cummings-foundation for more information.

### John Merck Fund

Navigate to the directory for https://github.com/riceissa/john-merck-fund

Follow the instructions at https://github.com/riceissa/john-merck-fund#instructions-for-running-the-scripts
to generate the SQL file.

Copy the resulting SQL file to the DLW repo at https://github.com/vipulnaik/donations/blob/master/sql/donations/private-foundations/john-merck-fund-grants.sql

### John M. Olin Foundation

Navigate to the [conservativetransparency.org processing
repo](https://github.com/riceissa/conservativetransparency) directory.

Go to http://conservativetransparency.org/donor/john-m-olin-foundation/ and
download new CSV data by clicking on "Export CSV". Save this in the `data/`
directory.

Then run the processing script by following instructions at
https://github.com/riceissa/conservativetransparency#instructions-for-doing-a-run

### Open Philanthropy Project

Vipul takes care of this.

### Pineapple Fund

This was a one-off fund that has finished giving out all its money, so there shouldn't be anything to do.

But, just in case, check:

- https://pineapplefund.org/
- https://www.google.com/search?q=pineapple%20fund
- https://en.wikipedia.org/wiki/Pineapple_Fund

For reference, the processing script is at https://github.com/riceissa/pineapple-fund

### Public Welfare Foundation

Navigate to the [Public Welfare Foundation repo](https://github.com/riceissa/public-welfare-foundation) directory.

Follow the directions at https://github.com/riceissa/public-welfare-foundation#instructions-new

Then copy `out.sql` to https://github.com/vipulnaik/donations/blob/master/sql/donations/private-foundations/public-welfare-foundation-grants.sql

### Quixote Foundation

Navigate to the [Quixote Foundation repo](https://github.com/riceissa/quixote-foundation) directory.

Follow the instructions at https://github.com/riceissa/quixote-foundation#instructions-for-getting-sql-file

Then copy the output SQL file to https://github.com/vipulnaik/donations/blob/master/sql/donations/private-foundations/public-welfare-foundation-grants.sql

### Robert Bowne Foundation

Navigate to the [Robert Bowne Foundation repo](https://github.com/riceissa/robert-bowne-foundation) directory.

Follow the instructions at https://github.com/riceissa/robert-bowne-foundation#instructions-for-running-the-scripts

Then copy the output SQL file to https://github.com/vipulnaik/donations/blob/master/sql/donations/private-foundations/robert-bowne-foundation-grants.sql

### Sloan Foundation

Last attempted and successful update: 2018-11-23

Navigate to the [Sloan Foundation Grants repo](https://github.com/riceissa/sloan-foundation) directory.

Get new data and save it to `data.html`. The data is _probably_ at https://sloan.org/grants-database?dynamic=0&order_by=approved_at&order_by_direction=desc&limit=2000&page=1 assuming the website hasn't changed. See the [repo readme](https://github.com/riceissa/sloan-foundation/blob/master/README.md) for more info.

Then run:

```bash
./proc.py > out.sql
```

Then copy `out.sql` to https://github.com/vipulnaik/donations/blob/master/sql/donations/private-foundations/sloan-foundation-grants.sql

### Smith Richardson Foundation

Navigate to the [conservativetransparency.org processing
repo](https://github.com/riceissa/conservativetransparency) directory.

Go to http://conservativetransparency.org/donor/smith-richardson-foundation/ and
download new CSV data by clicking on "Export CSV". Save this in the `data/`
directory.

Then run the processing script by following instructions at
https://github.com/riceissa/conservativetransparency#instructions-for-doing-a-run

### Stone Family Foundation

Navigate to the [Stone Family Foundation repo](https://github.com/riceissa/stone-family-foundation) directory.

There is no central listing of grants, so check the website, especially the pages listed in [this comment](https://github.com/vipulnaik/donations/issues/55#issue-326765897). Manually edit `data.txt` to add any new grants.

Then run:

```bash
./proc.py > out.sql
```

Then copy `out.sql` to https://github.com/vipulnaik/donations/blob/master/sql/donations/private-foundations/stone-family-foundation-grants.sql

### Surdna Foundation

Navigate to the [Surdna Foundation repo](https://github.com/riceissa/surdna-foundation) directory.

Follow instructions [here](https://github.com/riceissa/surdna-foundation#instructions-for-doing-a-run).

Then copy the SQL file to https://github.com/vipulnaik/donations/blob/master/sql/donations/private-foundations/surdna-foundation-grants.sql

### Templeton Foundation

Navigate to the [Templeton Foundation repo](https://github.com/riceissa/templeton-foundation) directory.

Get new data using the steps at https://github.com/riceissa/templeton-foundation#steps-to-get-the-data

Then run:

```bash
./proc.py > out.sql
```

(The repo historically named the SQL files `out-YYYY-MM-DD.sql` to make diffing across time easier, so you might want to follow that convention.)

Then copy `out.sql` to https://github.com/vipulnaik/donations/blob/master/sql/donations/private-foundations/templeton-foundation-grants.sql

### Theiss Research

I think this was entered manually, with no separate repository. The data comes from a single Internet Archive snapshot, so updates are unlikely.

See https://github.com/vipulnaik/donations/issues/38 for the original issue.

The data is at https://github.com/vipulnaik/donations/blob/master/sql/donations/private-foundations/theiss-research.sql

You might want to look around in case there is some new location with new data.

### Unbound Philanthropy

Navigate to the [Unbound Philanthropy repo](https://github.com/riceissa/unbound-philanthropy) directory.

Get the new spreadsheet. It is probably listed at the bottom of https://www.unboundphilanthropy.org/who-we-fund

Open the spreadsheet in LibreOffice and save as `data.csv`. More details at https://github.com/riceissa/unbound-philanthropy

**NOTE: the processing script for this uses the old Fixer.io API, which has been deprecated. You'll have to update the script to use the new API before you run it.**

Then run:

```bash
./proc.py > out.sql
```

Now copy `out.sql` to https://github.com/vipulnaik/donations/blob/master/sql/donations/private-foundations/unbound-philanthropy-grants.sql

### Knut and Alice Wallenberg Foundation

Navigate to the [Knut and Alice Wallenberg Foundation repo](https://github.com/riceissa/kaw-wallenberg-foundation)
directory.

Do the steps listed at
https://github.com/riceissa/kaw-wallenberg-foundation#how-to-get-data-and-generate-the-sql-file

### Walton Family Foundation

Navigate to the [conservativetransparency.org processing
repo](https://github.com/riceissa/conservativetransparency) directory.

Go to http://conservativetransparency.org/donor/walton-family-foundation/ and
download new CSV data by clicking on "Export CSV". Save this in the `data/`
directory.

Then run the processing script by following instructions at
https://github.com/riceissa/conservativetransparency#instructions-for-doing-a-run

### Wellcome Trust

Navigate to the [Wellcome Trust repo](https://github.com/riceissa/wellcome-trust) directory.

Find the latest spreadsheet at https://wellcome.ac.uk/funding/grants-awarded

Export to CSV using instructions at https://github.com/riceissa/wellcome-trust

**NOTE: the processing script for this uses the old Fixer.io API, which has been deprecated. You'll have to update the script to use the new API before you run it.**

Then run:

```bash
./proc.py > out.sql
```

Then copy `out.sql` to https://github.com/vipulnaik/donations/blob/master/sql/donations/private-foundations/wellcome-trust-grants.sql

### William E. Simon Foundation

Navigate to the [conservativetransparency.org processing
repo](https://github.com/riceissa/conservativetransparency) directory.

Go to http://conservativetransparency.org/donor/william-e-simon-foundation/ and
download new CSV data by clicking on "Export CSV". Save this in the `data/`
directory.

Then run the processing script by following instructions at
https://github.com/riceissa/conservativetransparency#instructions-for-doing-a-run

## Individual donors

For individual donors, a helpful MySQL query to run is the following:

```mysql
select distinct(url) from donations where donor='NAME';
```

This will reveal where the current donations data are coming from.

### Aaron Gertler

Check https://aarongertler.net/donations-all-years/ and update https://github.com/vipulnaik/donations/blob/master/sql/donations/individual-donors/aaron-gertler-donations.sql

### Ajeya Cotra

Donations are scattered. Current sources are:

- EA Hub
- GiveWell staff donations post
- Donor lottery

### Alexander Berger

Current donations are all from GiveWell and Open Phil staff donations posts.

### Andrew Martin

Current donations are all from GiveWell and Open Phil staff donations posts.

### Ben Hoskin

Current donations are all from MIRI's top contributors page, but see EA Forum for potentially new AI risk literature reviews.

### Ben Kuhn

Check https://www.benkuhn.net/ea/ and update https://github.com/vipulnaik/donations/blob/master/sql/donations/individual-donors/ben-kuhn-donations.sql

### Blake Borgeson

Current donations are mostly from MIRI's top contributors page.

### Brian Tomasik

Check http://reducing-suffering.org/my-donations-past-and-present/ and update https://github.com/vipulnaik/donations/blob/master/sql/donations/individual-donors/brian-tomasik-donations.sql

### Catherine Hollander

Current donations are all from GiveWell and Open Phil staff donations posts.

### Chelsea Tabart

Current donations are all from GiveWell and Open Phil staff donations posts.

### EA Survey

This requires getting new survey data, probably from Peter Hurford.

### Elie Hassenfeld

Current donations are all from GiveWell and Open Phil staff donations posts.

### Elizabeth Van Nostrand

Check https://acesounderglass.com/ for new donations posts.

### Founders Pledge

???

### Gordon Irlam

Check http://www.gricf.org/annual-report.html for new annual reports and add to https://github.com/vipulnaik/donations/blob/master/sql/donations/individual-donors/gordon-irlam-donations.sql

### Haseeb Qureshi

Donations collected from various sources.

There will probably be a donations post at http://haseebq.com/ at the beginning/end of a year.

### Helen Toner

Current sources are Open Phil staff donations and a donor lottery.

### Holden Karnofsky

Current donations are all from GiveWell and Open Phil staff donations posts.

### Isabel Arjmand

Current donations are all from GiveWell and Open Phil staff donations posts.

### Jacob Steinhardt

Current donations are from various sources.

Run the following query for hints:

```mysql
select distinct(url) from donations where donor='Jacob Steinhardt';
```

### James Snowden

Current donations are all from GiveWell and Open Phil staff donations posts.

### Jason Ketola

Current donations are from various sources.

Run the following query for hints:

```mysql
select distinct(url) from donations where donor='Jason Ketola';
```

### Jeff Kaufman and Julia Wise

Check https://www.jefftk.com/donations and update https://github.com/vipulnaik/donations/blob/master/sql/donations/individual-donors/jeff-kaufman-and-julia-wise-donations.sql

### Joey Savoie

Current data are from https://eahub.org/user/joey-savoie

## Donees

### AI Safety Camp

The initial round of donations was found on a LessWrong post, and it's
not clear where to find later donations.

### Brain Preservation Foundation

Check http://www.brainpreservation.org/donors/ and update
https://github.com/vipulnaik/donations/blob/master/sql/donations/donees/brain-preservation-foundation-donations.sql

### Donor lottery

It depends on who is hosting the donor lottery for the year, but it is
probably Centre for Effective Altruism, so check
https://app.effectivealtruism.org/lotteries/

### MIRI top donors

Navigate to the [MIRI top contributors
repository](https://github.com/riceissa/miri-top-contributors)
directory.

The next step depends on when the update was last done:

- If the previous update to the MIRI top donors SQL file was recent
  (maybe up to four months ago), then the incremental scraper
  (`scrape.py`) can be used.

  Before running the script, navigate to
  https://web.archive.org/save/https://intelligence.org/topcontributors/
  so that the state of the page as of the time of update is saved on
  the Internet Archive. Once saved, add the resulting snapshot URL to
  the `SNAPSHOTS` list in `scrape2.py` (not `scrape.py`). (We won't be
  running `scrape2.py`, but this way we have a record of which
  snapshots we've used.)

  Now run `make reset && make read` or similar to load in all the
  donations data into MySQL. We need this step because the script will
  be comparing the state of the top donors page against the database.

  Now run:

  ```bash
  ./scrape.py > out.sql
  ```

  Now _append_ the contents of `out.sql` to
  [`miri-top-donations.sql`](https://github.com/vipulnaik/donations/blob/master/sql/donations/donees/miri-top-donations.sql).

- If the previous update was a longer time ago, the historical scraper
  (`scrape2.py`) should be used, with all the intervening snapshots
  (at ~3 month increments) added to the list `SNAPSHOTS` defined in
  that script. You should also navigate to
  https://web.archive.org/save/https://intelligence.org/topcontributors/
  to save the current version of the page.

  Now run:

  ```bash
  ./scrape2.py > out.sql
  ```

  Then look through `out.sql` to find where the new donations begin
  (everything from the time when the last update was done _should_ be
  new, but you may want to do a manual diff just in case). Copy the
  contents of `out.sql` starting from this point into
  [`miri-top-donations.sql`](https://github.com/vipulnaik/donations/blob/master/sql/donations/donees/miri-top-donations.sql).

## Subsidiaries

### Berkeley Existential Risk Initiative

Check http://existence.org/grants as well as the [BERI
blog](http://existence.org/blog). Then update
https://github.com/vipulnaik/donations/blob/master/sql/donations/subsidiaries/beri-grants.sql

Some of the donations should be recorded elsewhere; see the comment at
the top of the file.

### EA Funds

Check https://app.effectivealtruism.org/funds/ and update
https://github.com/vipulnaik/donations/blob/master/sql/donations/subsidiaries/ea-funds.sql

Vipul does this so I'm not sure how exactly it works.

### EA Grants

For the initial round, the grants were given in a Google Doc. It's not
clear when newer grants will be announced or what format they will
come in.  Just keep an eye on the EA Forum, I guess.

### GiveWell discretionary regranting

Check https://www.givewell.org/about/FAQ/discretionary-grantmaking and
update
https://github.com/vipulnaik/donations/blob/master/sql/donations/subsidiaries/givewell-discretionary-regranting.sql

### GiveWell Incubation Grants

Check https://www.givewell.org/research/incubation-grants and update
https://github.com/vipulnaik/donations/blob/master/sql/donations/subsidiaries/givewell-incubation-grants.sql

### Good Ventures/GiveWell support

Check http://www.goodventures.org/our-portfolio/grants-database
(probably the CSV is easiest), then update
https://github.com/vipulnaik/donations/blob/master/sql/donations/subsidiaries/good-ventures-givewell-support.sql

### Good Ventures/GiveWell top and standout charities

Vipul does this and I'm not sure how. Maybe by checking the GV grants
database?

### Good Ventures/not recommended by GiveWell or Open Philanthropy Project

Vipul does this and I'm not sure how. Maybe by checking the GV grants
database?


