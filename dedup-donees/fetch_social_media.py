#!/usr/bin/env python3

import requests
import logging
import re


def main():
    print(get_homepage("Imperial College London"))


def get_homepage(orgname, lang="en"):
    """
    Take orgname and try to return a homepage for that org.
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
