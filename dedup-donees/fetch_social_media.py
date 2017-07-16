#!/usr/bin/env python3

import requests
import logging
import re
from bs4 import SoupStrainer, BeautifulSoup


# logging.basicConfig(level=logging.DEBUG)
HEADERS = {
        "User-Agent": "Mozilla/5.0 (X11; Linux x86_64) "
                      "AppleWebKit/537.36 (KHTML, like Gecko) "
                      "Chrome/59.0.3071.109 Safari/537.36",
        }


def main():
    with open("temp3") as f:
        for line in f:
            orgname = line.split("\t")[0].strip()
            print("{}\t{}".format(orgname, get_homepage(orgname)))


def get_homepage(orgname, lang="en"):
    """
    Take orgname and try to return a homepage for that org.
    """
    wikidata = wikidata_official_website(orgname)
    if wikidata:
        return wikidata[0]
    else:
        domains = just_a_domain(orgname)
        if domains:
            return domains[0]
    return ""


def wikidata_official_website(orgname, lang="en"):
    """
    Apply the heuristic of "if Wikidata has an official website listed for an
    org with this name, that is likely to be the official website".
    """
    # First get some candidate entities by searching wikidata
    payload = {
            "action": "wbsearchentities",
            "format": "json",
            "language": lang,
            "search": orgname,
    }
    r = requests.get('https://www.wikidata.org/w/api.php', params=payload)
    result = r.json()
    if 'error' in result:
        logging.warning("FAILED %s %s", r.url, result['error'])
    if 'warnings' in result:
        logging.warning(result['warnings'])
    candidate_org_ids = []
    if "search" in result:
        for d in result["search"]:
            if "id" in d:
                candidate_org_ids.append(d["id"])

    logging.debug("CANDIDATE IDs: %s", candidate_org_ids)

    # Now that we have some candidate entities, query to find official websites
    candidates = []
    for entity in candidate_org_ids:
        payload = {
                "action": "wbgetclaims",
                "format": "json",
                # "language": lang,
                "entity": entity,
                "property": "P856",
        }
        r = requests.get('https://www.wikidata.org/w/api.php', params=payload)
        result = r.json()
        if 'error' in result:
            logging.warning("FAILED %s %s", r.url, result['error'])
        if 'warnings' in result:
            logging.warning(result['warnings'])
        if "claims" in result and "P856" in result["claims"]:
            for i in result["claims"]["P856"]:
                try:
                    url = i["mainsnak"]["datavalue"]["value"]
                    candidates.append(url)
                except KeyError as e:
                    logging.warning("Could not find P856: %s", e)

    return candidates


def just_a_domain(orgname, lang="en"):
    """
    Apply the heuristic of "any external link on the Wikipedia page that is
    just a domain (i.e. not a deep link) is likely to be the official website
    of the org".
    """
    payload = {
            'action': 'parse',
            'format': 'json',
            'prop': 'externallinks',
            'page': orgname,
    }
    r = requests.get('https://{}.wikipedia.org/w/api.php'.format(lang),
                     params=payload)
    result = r.json()
    candidates = []
    if 'error' in result:
        logging.warning("FAILED %s %s", r.url, result['error'])
    if 'warnings' in result:
        logging.warning(result['warnings'])
    if 'parse' in result:
        links = result["parse"]["externallinks"]
        for link in links:
            m = re.match(r"(https?:)?//[A-Za-z0-9.]+/?$", link)
            if m:
                candidates.append(m.group(0))
    return candidates


def get_social_media(url):
    """
    Find social media accounts given a URL (most likely the homepage of the
    org).
    """
    r = requests.get(url, headers=HEADERS)
    for url in urls_on_page(r.content):
        if "facebook.com" in url:
            print(url)
        if "instagram.com" in url:
            print(url)
        if "twitter.com" in url:
            print(url)
        if "pinterest.com" in url:
            print(url)
        if "en.wikipedia.org" in url:
            print(url)


def links(doc, parse_full=False):
    if parse_full:
        soup = BeautifulSoup(doc, "html.parser")
        links = soup.find_all("a")
    else:
        only_a_tags = SoupStrainer("a")
        links = BeautifulSoup(doc, "html.parser", parse_only=only_a_tags)
    return links


def addthis(links):
    """
    Get AddThis accounts.
    """
    for link in links:
        if link.get("class") is not None:
            if any("addthis_button_twitter_follow" in c
                    for c in link.get("class")):
                print("https://twitter.com/" + link.get("addthis:userid"))
            if any("addthis_button_instagram_follow" in c
                    for c in link.get("class")):
                print("https://instagram.com/" + link.get("addthis:userid"))
            if any("addthis_button_facebook_follow" in c
                    for c in link.get("class")):
                print("https://facebook.com/" + link.get("addthis:userid"))


def urls_on_page(doc):
    """
    """
    result = []
    for link in links(doc):
        if link.has_attr("href"):
            result.append(link["href"])
    return result


if __name__ == "__main__":
    main()
