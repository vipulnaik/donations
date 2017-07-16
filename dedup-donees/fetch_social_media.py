#!/usr/bin/env python3

import requests
import logging
import re


def main():
    # print(get_homepage("Drugs for Neglected Diseases Initiative"))
    print(wikidata_official_website("Drugs for Neglected Diseases Initiative"))


def get_homepage(orgname, lang="en"):
    """
    Take orgname and try to return a homepage for that org.
    """
    return just_a_domain(orgname)


def wikidata_official_website(orgname, lang="en"):
    """
    Apply the heuristic of "if Wikidata has an official website listed for an
    org with this name, that is likely to be the official website".
    """
    payload = {
            "action": "wbsearchentities",
            "format": "json",
            "language": lang,
            "search": orgname,
    }
    r = requests.get('http://www.wikidata.org/w/api.php', params=payload)
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
    return candidate_org_ids


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
    r = requests.get('http://{}.wikipedia.org/w/api.php'.format(lang),
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


if __name__ == "__main__":
    main()
