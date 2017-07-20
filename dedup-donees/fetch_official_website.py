#!/usr/bin/env python3

import requests
import logging
import re
import sys
import json
import argparse


logging.getLogger("requests").setLevel(logging.WARNING)


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--debug", help="print debug statements",
                        action="store_const", dest="loglevel",
                        const=logging.DEBUG, default=logging.WARNING)
    parser.add_argument("-v", "--verbose", help="be verbose",
                        action="store_const", dest="loglevel",
                        const=logging.INFO)
    args = parser.parse_args()
    logging.basicConfig(level=args.loglevel)

    result = {}
    for line in sys.stdin:
        orgname = line.rstrip()
        logging.info("Doing %s", orgname)
        result[orgname] = get_homepage(orgname)
    json.dump(result, sys.stdout, indent=4)


def get_homepage(orgname, lang="en"):
    """
    Use multiple heuristics to get a list of guesses for the homepage of the
    org. Input orgname is a string of the org's canonical name. The output is a
    list of guesses. Each guess is a dict of the form
    {"source": source, "url": url}, where "source" tells which heuristic was
    used, and "url" is the homepage URL.
    """
    result = []
    wikidata = wikidata_official_website(orgname)
    domains = just_a_domain(orgname)
    result.extend(wikidata)
    result.extend(domains)
    return result


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
                    candidates.append({"source": "wikidata_official_website",
                                       "url": url})
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
                candidates.append({"source": "just_a_domain",
                                   "url": m.group(0)})
    return candidates


if __name__ == "__main__":
    main()
