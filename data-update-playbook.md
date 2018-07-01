# Data update playbook

Issue tracking this page: https://github.com/vipulnaik/donations/issues/52

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

## Individual donors
