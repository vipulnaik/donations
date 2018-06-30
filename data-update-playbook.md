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

## Individual donors
