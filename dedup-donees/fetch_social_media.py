#!/usr/bin/env python3

import re
import logging
import requests
import sys
import json
from bs4 import SoupStrainer, BeautifulSoup


# logging.basicConfig(level=logging.DEBUG)
HEADERS = {
        "User-Agent": "Mozilla/5.0 (X11; Linux x86_64) "
                      "AppleWebKit/537.36 (KHTML, like Gecko) "
                      "Chrome/59.0.3071.109 Safari/537.36",
        }


def main():
    result = {}
    for line in sys.stdin:
        url = line.strip()
        result[url] = get_social_media(url)
    with open("social_media.json", "w") as f:
        json.dump(result, f, indent=4)


def get_social_media(url):
    """
    Find social media accounts given a URL (most likely the homepage of the
    org).
    """
    r = requests.get(url, headers=HEADERS)
    l = link_tags(r.content)
    result = []

    # Populate the results list using various heuristics
    result.extend(addthis(l))
    result.extend(domains_match(l))
    result.extend(regex_match(r.content))

    return result


def link_tags(doc, parse_full=False):
    """
    Given an HTML document, parse it to find all link tags. Return a list of
    <a> tags. If parse_full is true, parse the whole document; otherwise use
    SoupStrainer to parse only <a> tags.
    """
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
    result = []
    for link in links:
        if link.get("class") is not None:
            if any("addthis_button_twitter_follow" in c
                    for c in link.get("class")):
                result.append({"twitter": link.get("addthis:userid"),
                               "source": "addthis"})
            if any("addthis_button_instagram_follow" in c
                    for c in link.get("class")):
                result.append({"instagram": link.get("addthis:userid"),
                               "source": "addthis"})
            if any("addthis_button_facebook_follow" in c
                    for c in link.get("class")):
                result.append({"facebook": link.get("addthis:userid"),
                               "source": "addthis"})
    return result


def domains_match(links):
    """
    """
    result = []
    for link in links:
        if link.has_attr("href"):
            url = link["href"]
            for domain in ["facebook", "instagram", "twitter", "pinterest"]:
                m = (re.search(r"(?:https?:)?//(?:www\.)?" + domain +
                            r"\.com/([A-Za-z0-9-]+)/?", url))
                if m:
                    username = m.group(1)
                    if domain + ".com" in url and not blacklisted(url):
                        result.append({domain: username, "source": "domains_match"})
                        if "/" in username:
                            logging.warning("%s | %s", url, username)
    return result


def regex_match(doc):
    """
    """
    results = []
    for line in doc.decode("utf-8").split("\n"):
        m = re.search(r"""//(?:www\.)?(facebook|instagram|twitter)\.com/([A-Za-z0-9]+)""",
                     line)
        if m:
            results.append({m.group(1): m.group(2),
                            "source": "regex_match"})
    return results


def blacklisted(account_name):
    if "search?" in account_name:
        return True
    if account_name.lower() in ["search", "intent", "sharer", "pages"]:
        return True
    if "/sharer/" in account_name:
        return True
    if "/intent/" in account_name:
        return True
    if "/#!/" in account_name:
        return True
    return False

if __name__ == "__main__":
    main()
