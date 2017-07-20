#!/usr/bin/env python3

import re
import logging
import requests
import sys
import json
import argparse
from bs4 import SoupStrainer, BeautifulSoup


logging.getLogger("requests").setLevel(logging.WARNING)
HEADERS = {
        "User-Agent": "Mozilla/5.0 (X11; Linux x86_64) "
                      "AppleWebKit/537.36 (KHTML, like Gecko) "
                      "Chrome/59.0.3071.109 Safari/537.36",
        }


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
        url = line.strip()
        logging.warning("Doing %s", url)
        result[url] = get_social_media(url)
    json.dump(result, sys.stdout, indent=4)


def get_social_media(url):
    """
    Find social media accounts given a URL (most likely the homepage of the
    org). The output is a list of guesses. Each guess is of the form
    {"source": source, service: username}, where source is the heuristic used
    to obtain the username, and service is the social media service, e.g.
    "facebook".
    """
    try:
        r = requests.get(url, headers=HEADERS)
        l = link_tags(r.content)
        result = []

        # Populate the results list using various heuristics
        result.extend(addthis(l))
        result.extend(domains_match(l))
        result.extend(regex_match(r.content))

        return result

    except Exception as e:
        logging.warning(e)
        return []


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
    This heuristic looks for AddThis accounts.
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
    This heuristic looks through the list of links for URLs that look like
    social media accounts.
    """
    result = []
    for link in filter(lambda l: l.has_attr("href"), links):
        url = link["href"]
        for domain in ["facebook", "instagram", "twitter", "pinterest",
                       "medium"]:
            m = (re.match(r"(?:https?:)?//(?:www\.)?" + domain +
                          r"\.com/([A-Za-z0-9@_.-]+)", url))
            if m and not blacklisted(url):
                result.append({domain: m.group(1), "source": "domains_match"})
        for domain in ["youtube"]:
            m = (re.match(r"(?:https?:)?//(?:www\.)?" + domain +
                          r"\.com/user/([A-Za-z0-9_.-]+)/?", url))
            if m and not blacklisted(url):
                result.append({domain: m.group(1), "source": "domains_match"})
        for domain in ["tumblr"]:
            m = (re.match(r"(?:https?:)?//([A-Za-z0-9_-]+)\." + domain +
                          r"\.com", url))
            if m and not blacklisted(url):
                result.append({domain: m.group(1), "source": "domains_match"})
    return result


def regex_match(doc):
    """
    This heuristic looks through the HTML source to find text that looks like
    social media URLs (even if the URL isn't in an <a> tag, so this works if
    the URL is hidden within JavaScript).
    """
    results = []
    try:
        f = doc.decode("utf-8").split("\n")
    except UnicodeDecodeError as e:
        logging.warning(e)
        f = ""
    for line in f:
        matches = re.findall(r"""//(?:www\.)?"""
                             "(facebook|instagram|twitter|pinterest|medium)"
                             r"""\.com/([A-Za-z0-9@_.-]+)""",
                             line)
        matches += re.findall(r"""//(?:www\.)?"""
                              "(youtube)"
                              r"""\.com/user/([A-Za-z0-9_.-]+)""",
                              line)
        matches2 = re.findall(r"""//([A-Za-z0-9_-]+)\."""
                              "(tumblr)"
                              r"""\.com""",
                              line)
        for m in matches:
            if not blacklisted(m[1]):
                results.append({m[0]: m[1],
                                "source": "regex_match"})
        for m in matches2:
            if not blacklisted(m[0]):
                results.append({m[1]: m[0],
                                "source": "regex_match"})
    return results


def blacklisted(account_name):
    """
    Take a potential social media account name. If the account name is
    blacklisted, return True. Otherwise return False.
    """
    if account_name.lower() in ["search", "intent", "sharer", "pages", "i",
                                "tr", "p", "H", "hashtag", "plugins",
                                "sharer.php", "x", "home.php", "groups"]:
        return True
    bad = ["search?", "/sharer/", "/intent/", "/#!/", "/i/", "/p/"]
    for b in bad:
        if b in account_name:
            return True
    if re.match(r"^\d\d\d\d$", account_name):
        return True
    return False


if __name__ == "__main__":
    main()
