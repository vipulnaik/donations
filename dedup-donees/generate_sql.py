#!/usr/bin/env python3

import argparse
import json
import logging


logging.getLogger("requests").setLevel(logging.WARNING)


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("url_file", type=argparse.FileType("r"))
    parser.add_argument("social_media_file", type=argparse.FileType("r"))
    parser.add_argument("--org_list", dest="org_list",
                        type=argparse.FileType("r"))
    parser.add_argument("--debug", help="print debug statements",
                        action="store_const", dest="loglevel",
                        const=logging.DEBUG, default=logging.WARNING)
    parser.add_argument("-v", "--verbose", help="be verbose",
                        action="store_const", dest="loglevel",
                        const=logging.INFO)
    args = parser.parse_args()
    logging.basicConfig(level=args.loglevel)

    url_map = json.load(args.url_file)
    social_media_map = json.load(args.social_media_file)
    if args.org_list:
        logging.info("Found org_list, using specified list.")
        org_list = [line.rstrip() for line in args.org_list]
    else:
        logging.info("No org_list found, using generated list from {}"
                     .format(args.url_file.name))
        org_list = list(url_map.keys())

    print("insert into donees(donee, former_name, country, bay_area, "
          "facebook_username, website, donate_page, donor_list_page, "
          "transparency_and_financials_page, donation_case_page,"
          "donation_statistics_page, twitter_username, eahub_username, "
          "wikipedia_page, givewell_review, open_phil_grant_review, "
          "ace_review, key_people, cause_area, recommenders, notes, "
          "youtube_username, instagram_username, tumblr_subdomain, "
          "medium_username, pinterest_username, launch_date, "
          "launch_date_precision, launch_date_url, charity_navigator_page, "
          "guidestar_page, timelines_wiki_page) values")
    print("    " + ",\n    ".join(
          cooked_row(orgname, url_map, social_media_map)
          for orgname in org_list) + ";")


def org_url(orgname, url_map):
    """
    """
    lst = url_map.get(orgname, [])
    for d in lst:
        if d["source"] == "wikidata_official_website":
            return d["url"]
    return ""


def org_social_media(url, social_media_map):
    """
    Given the "messy" social media map containing potential accounts, score
    them to produce a map containing just the best guesses.
    """
    result = {}
    lst = social_media_map.get(url, [])
    services = ["facebook", "twitter", "instagram", "tumblr", "pinterest",
                "youtube", "medium"]
    for service in services:
        candidates = {}
        for d in lst:
            if service in d:
                username = d[service]
                if username in candidates:
                    candidates[username]["sources"].add(d["source"])
                else:
                    candidates[username] = {"sources": {d["source"]},
                                            "score": 0}
        # Score the candidate usernames
        for c in candidates:
            d = candidates[c]
            # AddThis takes precedence
            if "addthis" in d["sources"]:
                d["score"] = max(d["score"], 3)
            d["score"] = max(d["score"], len(d["sources"]))
            if "domain_match" in d["sources"]:
                d["score"] = max(d["score"], 1)
        best = ("", 0)
        for c in candidates:
            d = candidates[c]
            if d["score"] > best[1]:
                best = (c, d["score"])
        result[service] = best[0]
        logging.debug("%s candidates: %s", service, candidates)
    return result


def mysql_quote(x):
    '''
    Quote the string x using MySQL quoting rules. If x is the empty string,
    return "NULL". Probably not safe against maliciously formed strings.
    '''
    if not x:
        return "NULL"
    x = x.replace("\\", "\\\\")
    x = x.replace("'", "''")
    return "'{}'".format(x)


def cooked_row(orgname, url_map, social_media_map):
    """
    Return a string that can be used directly
    in a SQL insert statement (without trailing comma).
    """
    url = org_url(orgname, url_map)
    sm = org_social_media(url, social_media_map)
    result = "("
    result += ",".join([
        mysql_quote(orgname),  # donee
        "NULL",  # former_name
        "NULL",  # country
        "NULL",  # bay_area
        mysql_quote(sm.get("facebook", "")),  # facebook_username
        mysql_quote(url),  # website
        "NULL",  # donate_page
        "NULL",  # donor_list_page
        "NULL",  # transparency_and_financials_page
        "NULL",  # donation_case_page
        "NULL",  # donation_statistics_page
        mysql_quote(sm.get("twitter", "")),  # twitter_username
        "NULL",  # eahub_username
        "NULL",  # wikipedia_page
        "NULL",  # givewell_review
        "NULL",  # open_phil_grant_review
        "NULL",  # ace_review
        "NULL",  # key_people
        "NULL",  # cause_area
        "NULL",  # recommenders
        "NULL",  # notes
        mysql_quote(sm.get("youtube", "")),  # youtube_username
        mysql_quote(sm.get("instagram", "")),  # instagram_username
        mysql_quote(sm.get("tumblr", "")),  # tumblr_subdomain
        mysql_quote(sm.get("medium", "")),  # medium_username
        mysql_quote(sm.get("pinterest", "")),  # pinterest_username
        "NULL",  # launch_date
        "NULL",  # launch_date_precision
        "NULL",  # launch_date_url
        "NULL",  # charity_navigator_page
        "NULL",  # guidestar_page
        "NULL",  # timelines_wiki_page
    ])
    result += ")"
    return result


if __name__ == "__main__":
    main()
