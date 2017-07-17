Get some donees:

    mysql -e "use donations; select distinct(donee) from donations;" | sort > temp

Get biggest donees:

    mysql -e "use donations; select donee,sum(amount) from donations group by donee order by sum(amount) desc;" > temp3

`fetch_official_website.py` takes a list of organization names and prints out
corresponding organization websites. For instance with:

```bash
mysql --skip-column-names -e \
    "use donations; select donee,sum(amount) from donations group by donee order by sum(amount) desc;" \
    | head -10 | cut -f1 | ./fetch_official_website.py
```

one should obtain an output like:

```
GAVI Alliance   http://www.gavi.org/
World Health Organization       http://www.who.int
PATH    https://www.path.com
The Global Fund to Fight AIDS, Tuberculosis and Malaria http://www.theglobalfund.org/
The Rotary Foundation of Rotary International
International Bank for Reconstruction and Development   https://www.worldbank.org/en/about/what-we-do/brief/ibrd
PATH Vaccine Solutions
United States Fund for UNICEF
Johns Hopkins University        http://www.jhu.edu
```

`fetch_social_media.py` gets social media accounts. Currently, it is supposed to for:

- Facebook
- Twitter
- Instagram
- YouTube
- Tumblr
- Medium
- Pinterest

This script takes lines of URLs and writes a JSON file containing social media
info.
