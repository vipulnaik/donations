#!/usr/bin/env python3


def main():
    org_list = []
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
    print("    " + ",\n    ".join(cooked_row(orgname) for orgname in org_list) + ";")


def org_url(orgname):
    """
    """


def org_social_media(url):
    """
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


def cooked_row(orgname):
    """
    Return a string that can be used directly
    in a SQL insert statement (without trailing comma).
    """
    url = org_url(orgname)
    sm = org_social_media(url)
    # print("insert into donees(donee, former_name, country, bay_area,"
    #       "facebook_username, website, donate_page, donor_list_page,"
    #       "transparency_and_financials_page, donation_case_page,"
    #       "donation_statistics_page, twitter_username, eahub_username,"
    #       "wikipedia_page, givewell_review, open_phil_grant_review,"
    #       "ace_review, key_people, cause_area, recommenders, notes,"
    #       "youtube_username, instagram_username, tumblr_subdomain,"
    #       "medium_username, pinterest_username, launch_date,"
    #       "launch_date_precision, launch_date_url, charity_navigator_page,"
    #       "guidestar_page, timelines_wiki_page) values")
    result = "("
    result += ",".join([
        mysql_quote(t['donor']),
        mysql_quote(t['donee']),
        str(t['amount']),
        mysql_quote(t['donation_date']),
        mysql_quote(t['donation_date_precision']),
        mysql_quote(t['donation_date_basis']),
        mysql_quote(t['cause_area']),
        mysql_quote(t['url']),
        mysql_quote(t['donor_cause_area_url']),
        mysql_quote(t['notes']),
        mysql_quote(t['affected_countries']),
        mysql_quote(t['affected_regions']),
    ])
    result += ")"
    return result


if __name__ == "__main__":
    main()
