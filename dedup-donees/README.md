TL;DR to get the SQL run:

```bash
mysql --skip-column-names -e \
    "use donations; select donee,sum(amount) from donations group by donee order by sum(amount) desc;" \
    | cut -f1 | ./fetch_official_website.py > url.json
cat url.json | ./filter_url.py | ./fetch_social_media.py > social_media.json
./generate_sql.py url.json social_media.json > out.sql
```

## Contents

* [fetch_official_website.py](#fetch_official_websitepy)
* [fetch_social_media.py](#fetch_social_mediapy)
* [generate_sql.py](#generate_sqlpy)

Get some donees:

    mysql -e "use donations; select distinct(donee) from donations;" | sort > temp

Get biggest donees:

    mysql -e "use donations; select donee,sum(amount) from donations group by donee order by sum(amount) desc;" > temp3

## `fetch_official_website.py`

`fetch_official_website.py` takes a list of organization names and prints out
corresponding organization websites while labeling the sources.

Example input:

```bash
 echo "Machine Intelligence Research Institute" | ./fetch_official_website.py
```

Corresponding output:

```json
{
    "Machine Intelligence Research Institute": [
        {
            "url": "http://intelligence.org/",
            "source": "wikidata_official_website"
        },
        {
            "url": "http://intelligence.org",
            "source": "just_a_domain"
        },
        {
            "url": "http://intelligence.org/",
            "source": "just_a_domain"
        }
    ]
}
```

A more realistic way to use the script is (remove the `head -3` part of the
chain the consume the full list of donees):

```bash
mysql --skip-column-names -e \
    "use donations; select donee,sum(amount) from donations group by donee order by sum(amount) desc;" \
    | head -3 | cut -f1 | ./fetch_official_website.py
```

The corresponding output is:

```json
{
    "GAVI Alliance": [
        {
            "url": "http://www.gavi.org/",
            "source": "wikidata_official_website"
        }
    ],
    "PATH": [
        {
            "url": "https://www.path.com",
            "source": "wikidata_official_website"
        }
    ],
    "World Health Organization": [
        {
            "url": "http://www.who.int",
            "source": "wikidata_official_website"
        },
        {
            "url": "http://www.who.int/ihr/lyon/en/",
            "source": "wikidata_official_website"
        },
        {
            "url": "http://www.who.int/hac/network/who/co_nigeria/en/",
            "source": "wikidata_official_website"
        },
        {
            "url": "http://www.who.int/countries/pak/en/",
            "source": "wikidata_official_website"
        },
        {
            "url": "http://www.wpro.who.int/philippines/en/",
            "source": "wikidata_official_website"
        },
        {
            "url": "http://www.who.org.ph/",
            "source": "just_a_domain"
        },
        {
            "url": "http://www.healthintelligenceportal.org/",
            "source": "just_a_domain"
        },
        {
            "url": "http://www.who.int",
            "source": "just_a_domain"
        },
        {
            "url": "http://www.afro.who.int",
            "source": "just_a_domain"
        },
        {
            "url": "http://www.euro.who.int",
            "source": "just_a_domain"
        },
        {
            "url": "http://www.searo.who.int",
            "source": "just_a_domain"
        },
        {
            "url": "http://www.emro.who.int",
            "source": "just_a_domain"
        },
        {
            "url": "http://www.wpro.who.int",
            "source": "just_a_domain"
        },
        {
            "url": "http://www.paho.org",
            "source": "just_a_domain"
        }
    ]
}
```

## `fetch_social_media.py`

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

## `generate_sql.py`

This script takes the outputs of `fetch_official_website.py` and
`fetch_social_media.py` and outputs the SQL file that can be inserted into the
database. Since the previous two scripts are "inclusive" in the sense that they
include guesses from multiple sources (while marking the sources),
`generate_sql.py` is the script that implements the "intelligent" scoring to
select among the guesses.
