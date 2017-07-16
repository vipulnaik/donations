#!/usr/bin/env python3

import requests
import logging
import re


def main():
    print(get_homepage("Drugs for Neglected Diseases Initiative"))


def get_homepage(orgname, lang="en"):
    """
    Take orgname and try to return a homepage for that org.
    """
    return just_a_domain(orgname)


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
