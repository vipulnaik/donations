#!/usr/bin/env python3

import requests
from bs4 import SoupStrainer, BeautifulSoup


# logging.basicConfig(level=logging.DEBUG)
HEADERS = {
        "User-Agent": "Mozilla/5.0 (X11; Linux x86_64) "
                      "AppleWebKit/537.36 (KHTML, like Gecko) "
                      "Chrome/59.0.3071.109 Safari/537.36",
        }


def main():
    pass


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
