#!/usr/bin/env python3

import argparse
import json


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("url_file", type=argparse.FileType("r"))
    parser.add_argument("social_media_file", type=argparse.FileType("r"))
    args = parser.parse_args()

    org_list = []
    url_map = {}

    for line in args.url_file:
        orgname, url = line.rstrip().split("\t")
        org_list.append(orgname)
        url_map[orgname] = url

    social_media_map = json.load(args.social_media_file)

    print("insert into donees(donee, former_name, country, bay_area,"
          "facebook_username, website, donate_page, donor_list_page,"
          "transparency_and_financials_page, donation_case_page,"
          "donation_statistics_page, twitter_username, eahub_username,"
          "wikipedia_page, givewell_review, open_phil_grant_review,"
          "ace_review, key_people, cause_area, recommenders, notes,"
          "youtube_username, instagram_username, tumblr_subdomain,"
          "medium_username, pinterest_username, launch_date,"
          "launch_date_precision, launch_date_url, charity_navigator_page,"
          "guidestar_page, timelines_wiki_page) values")
    print("    " + ",\n    ".join(cooked_row(orgname, url_map, social_media_map)
          for orgname in org_list) + ";")


def org_url(orgname, url_map):
    """
    """
    return url_map.get(orgname, "")


def org_social_media(url, social_media_map):
    """
    Given the "messy" social media map containing potential accounts, score
    them to produce a map containing just the best guesses.
    """


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
        mysql_quote(orgname), # donee
        "NULL", # former_name
        "NULL", # country
        "NULL", # bay_area
        mysql_quote(sm.get("facebook", "")), # facebook_username
        mysql_quote(url) , # website
        "NULL", # donate_page
        "NULL", # donor_list_page
        "NULL", # transparency_and_financials_page
        "NULL", # donation_case_page
        "NULL", # donation_statistics_page
        mysql_quote(sm.get("twitter", "")), # twitter_username
        "NULL", # eahub_username
        "NULL", # wikipedia_page
        "NULL", # givewell_review
        "NULL", # open_phil_grant_review
        "NULL", # ace_review
        "NULL", # key_people
        "NULL", # cause_area
        "NULL", # recommenders
        "NULL", # notes
        mysql_quote(sm.get("youtube", "")), # youtube_username
        mysql_quote(sm.get("instagram", "")), # instagram_username
        mysql_quote(sm.get("tumblr", "")), # tumblr_subdomain
        mysql_quote(sm.get("medium", "")), # medium_username
        mysql_quote(sm.get("pinterest", "")), # pinterest_username
        "NULL", # launch_date
        "NULL", # launch_date_precision
        "NULL", # launch_date_url
        "NULL", # charity_navigator_page
        "NULL", # guidestar_page
        "NULL", # timelines_wiki_page
    ])
    result += ")"
    return result


if __name__ == "__main__":
    main()
