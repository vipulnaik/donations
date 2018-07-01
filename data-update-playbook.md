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

## Individual donors
