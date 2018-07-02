# Data update playbook

Issue tracking this page: https://github.com/vipulnaik/donations/issues/52

General caution: Websites and data formats change all the time. If a script fails to run, be prepared to fix it or find someone to fix it.

## Table of contents

- [Foundations](#foundations)
  - [Arnold Foundation](#arnold-foundation)
  - [Barr Foundation](#barr-foundation)
  - [Dell Foundation](#dell-foundation)
  - [EA Giving Group](#ea-giving-group)
  - [Ford Foundation](#ford-foundation)
  - [Foundational Questions Institute (FQXi)](#foundational-questions-institute-fqxi)
  - [Future Justice Fund](#future-justice-fund)
  - [Future of Life Institute](#future-of-life-institute)
  - [Gates Foundation](#gates-foundation)
  - [Google.org](#googleorg)
  - [Hewlett Foundation](#hewlette-foundation)
  - [Knight Foundation](#knight-foundation)
  - [MacArthur Foundation](#macarthur-foundation)
  - [Barbara McDowell and Gerald S. Hartman Foundation](#barbara-mcdowell-and-gerald-s-hartman-foundation)
  - [Mulago](#mulago)
  - [Nathan Cummings Foundation](#nathan-cummings-foundation)
  - [Open Philanthropy Project](#open-philanthropy-project)
  - [Pineapple Fund](#pineapple-fund)
  - [Public Welfare Foundation](#public-welfare-foundation)
  - [Sloan Foundation](#sloan-foundation)
  - [Stone Family Foundation](#stone-family-foundation)
  - [Templeton Foundation](#templeton-foundation)
  - [Theiss Research](#theiss-research)
  - [Unbound Philanthropy](#unbound-philanthropy)
  - [Wellcome Trust](#wellcome-trust)
- [Individual donors](#individual-donors)

## Foundations

### Arnold Foundation

From the [Arnold Foundation repo](https://github.com/riceissa/arnold-foundation-grants) directory:

```bash
curl http://www.arnoldfoundation.org/grants/ > index.html
./loop.py > out.sql
```

Then copy `out.sql` to https://github.com/vipulnaik/donations/blob/master/sql/donations/private-foundations/arnold-foundation-grants.sql

### Barr Foundation

From the [Barr Foundation repo](https://github.com/riceissa/barr-foundation) directory:

```bash
./scrape.py  # saves in data.csv
./proc.py > out.sql
```

Then copy `out.sql` to https://github.com/vipulnaik/donations/blob/master/sql/donations/private-foundations/barr-foundation-grants.sql

### Dell Foundation

Navigate to the [Dell Foundation repo](https://github.com/riceissa/dell-foundation) directory on your local machine.

Go to https://www.msdf.org/funding/ and click on "show more" until no more grants can be shown. Then use Chrome's "copy element" from the DOM inspection tool (Ctrl+Shift+I) to get the DOM source. Save this as `data.html`.

Then run:

```bash
./proc.py > out.sql
```

Then _append_ (don't override) some subset of `out.sql` to <https://github.com/vipulnaik/donations/blob/master/sql/donations/private-foundations/dell-foundation-grants.sql>. This one is a little tricky because I think Dell Foundation keeps tossing out older grants, so we have to check which grants are new. There isn't a script that does this yet.

### EA Giving Group

There is no official central location for updates to this, so just keep an eye out for mentions of it, I guess.

### Ford Foundation

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

Navigate to the [FLI grants repo](https://github.com/riceissa/fli-grants) directory.

Check if a new round of grants have been awarded. It's not clear if the 2015 grants script will work.

### Gates Foundation

I think this is just for IATI data and we decided not to do the whole foundation (due to limited data access through their website).

### Google.org

This was all manual, and automation work began but has stalled. See https://github.com/vipulnaik/donations/issues/47

### Hewlett Foundation

Navigate to the [Hewlett Foundation repo](https://github.com/riceissa/hewlett-foundation) directory.

Run the following:

```bash
./scrape.py  # overwrites data.csv
./proc.py > out.sql
```

Then copy `out.sql` to https://github.com/vipulnaik/donations/blob/master/sql/donations/private-foundations/hewlett-foundation-grants.sql

### Knight Foundation

Navigate to the [Knight Foundation grants repo](https://github.com/riceissa/knight-foundation) directory.

Run the following:

```bash
./scrape.py  # overwrites data.csv
./proc.py > out.sql
```

Then copy `out.sql` to https://github.com/vipulnaik/donations/blob/master/sql/donations/private-foundations/knight-foundation-grants.sql

### MacArthur Foundation

Navigate to the [MacArthur Foundation repo](https://github.com/riceissa/macarthur-foundation) directory.

Run the following:

```bash
./scrape.py  # overwrites data.csv
./proc.py > out.sql
```

Then copy `out.sql` to https://github.com/vipulnaik/donations/blob/master/sql/donations/private-foundations/macarthur-foundation-grants.sql

### Barbara McDowell and Gerald S. Hartman Foundation

Navigate to the [Barbara McDowell and Gerald S. Hartman Foundation grants data repo](https://github.com/riceissa/mcdowell-foundation) directory.

Run the following:

```bash
./scrape.py  # overwrites data.csv
./proc.py > out.sql
```

Then copy `out.sql` to https://github.com/vipulnaik/donations/blob/master/sql/donations/private-foundations/mcdowell-foundation-grants.sql

### Mulago

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

Get new data and store in `data.html`; the steps are described at https://github.com/riceissa/public-welfare-foundation#getting-datahtml

Then run:

```bash
./proc.py > out.sql
```

Then copy `out.sql` to https://github.com/vipulnaik/donations/blob/master/sql/donations/private-foundations/public-welfare-foundation-grants.sql

### Sloan Foundation

Navigate to the [Sloan Foundation Grants repo](https://github.com/riceissa/sloan-foundation) directory.

Get new data and save it to `data.html`. The data is _probably_ at https://sloan.org/grants-database?dynamic=0&order_by=approved_at&order_by_direction=desc&limit=2000&page=1 assuming the website hasn't changed. See the [repo readme](https://github.com/riceissa/sloan-foundation/blob/master/README.md) for more info.

Then run:

```bash
./proc.py > out.sql
```

Then copy `out.sql` to https://github.com/vipulnaik/donations/blob/master/sql/donations/private-foundations/sloan-foundation-grants.sql

### Stone Family Foundation

Navigate to the [Stone Family Foundation repo](https://github.com/riceissa/stone-family-foundation) directory.

There is no central listing of grants, so check the website, especially the pages listed in [this comment](https://github.com/vipulnaik/donations/issues/55#issue-326765897). Manually edit `data.txt` to add any new grants.

Then run:

```bash
./proc.py > out.sql
```

Then copy `out.sql` to https://github.com/vipulnaik/donations/blob/master/sql/donations/private-foundations/stone-family-foundation-grants.sql

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

### 
