#!/usr/bin/env python3

import sys
import datetime
import argparse
import base64
import mysql.connector
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt

try:
    import login
except ModuleNotFoundError:
    print("Please create a login.py file with the following information so Python can access MySQL:")
    print()
    print('USER = "your_user_name"')
    print('DATABASE = "donations"')
    print('PASSWORD = "secret"')
    sys.exit()


cnx = mysql.connector.connect(user=login.USER, database=login.DATABASE,
                              password=login.PASSWORD)
cursor = cnx.cursor()


def single_donor_single_donee(output, donor, donee):
    cursor.execute("""select intended_funding_timeframe_in_months,donation_date from donations where donor = %s and donee = %s""", (donor, donee))
    y = 1
    for intended_funding_timeframe_in_months, donation_date in cursor:
        funding_timeframe_in_days = 30*intended_funding_timeframe_in_months if intended_funding_timeframe_in_months else 10
        xstart = donation_date
        xstop = xstart + datetime.timedelta(days=funding_timeframe_in_days)
        plt.hlines(y, xstart, xstop, 'b', lw=4)
        y += 1

    plt.yticks(range(1,y))
    plt.xticks(rotation=45)
    plt.xlabel("Date")
    plt.ylabel("Grant number")
    plt.margins(y=0.1)
    plt.savefig(output, bbox_inches="tight")


def single_donor_multiple_donees(output, donor, cause_area=None):
    if cause_area:
        # We want to limit the donations to those given to the top 10 donees.
        # So we use a subquery to find the top 10 donees, but MySQL doesn't
        # support a limit clause inside a subquery, so we have to create dummy
        # table name (called t here). See
        # https://stackoverflow.com/a/51877655/3422337
        cursor.execute("""select
                            donee,
                            intended_funding_timeframe_in_months,
                            donation_date
                          from
                            donations
                          where
                            donor = %s and
                            substring_index(cause_area,'/',1)=%s and
                            donee in (
                              select * from (
                                select donee
                                from donations
                                where
                                  donor = %s and
                                  substring_index(cause_area,'/',1)=%s
                                group by donee
                                order by sum(amount) desc
                                limit 10
                              ) as t
                            )
                            order by donation_date""", (donor, cause_area, donor, cause_area))
    else:
        cursor.execute("""select
                            donee,
                            intended_funding_timeframe_in_months,
                            donation_date
                          from
                            donations
                          where
                            donor = %s and
                            donee in (
                              select * from (
                                select donee
                                from donations
                                where donor = %s
                                group by donee
                                order by sum(amount) desc
                                limit 10
                              ) as t
                            )
                          order by donation_date""", (donor, donor))

    plt.figure(figsize=(12,5))
    y = 1
    donees_seen = {}
    for donee, intended_funding_timeframe_in_months, donation_date in cursor:
        if donee not in donees_seen:
            donees_seen[donee] = y  # claim this y position, then increment y
            y += 1
        funding_timeframe_in_days = 30*intended_funding_timeframe_in_months if intended_funding_timeframe_in_months else 10
        xstart = donation_date
        xstop = xstart + datetime.timedelta(days=funding_timeframe_in_days)
        plt.hlines(donees_seen[donee], xstart, xstop, 'b', lw=4)
    # yticks needs ticks (y positions) and the labels in separate lists, so we
    # "unzip" the dictionary into two lists
    plt.yticks(*zip(*[(donees_seen[k], k) for k in donees_seen]))
    plt.xticks(rotation=45)
    plt.xlabel("Date")
    plt.ylabel("Donee")
    plt.tight_layout()
    plt.margins(y=0.1)
    plt.savefig(output, bbox_inches="tight")


def single_donee_multiple_donors(output, donee):
    # See comment in single_donor_multiple_donees for explanation of the
    # subquery.
    cursor.execute("""select
                        donor,
                        intended_funding_timeframe_in_months,
                        donation_date
                      from
                        donations
                      where
                        donee = %s and
                        donor in (
                          select * from (
                            select donor
                            from donations
                            where donee = %s
                            group by donor
                            order by sum(amount) desc
                            limit 10
                          ) as t
                        )
                      order by donation_date""", (donee, donee))
    plt.figure(figsize=(12,5))
    y = 1
    donor_ypos = {}
    for donor, intended_funding_timeframe_in_months, donation_date in cursor:
        if donor not in donor_ypos:
            donor_ypos[donor] = y  # claim this y position, then increment y
            y += 1
        funding_timeframe_in_days = 30*intended_funding_timeframe_in_months if intended_funding_timeframe_in_months else 10
        xstart = donation_date
        xstop = xstart + datetime.timedelta(days=funding_timeframe_in_days)
        plt.hlines(donor_ypos[donor], xstart, xstop, 'b', lw=4)
    # yticks needs ticks (y positions) and the labels in separate lists, so we
    # "unzip" the dictionary into two lists
    plt.yticks(*zip(*[(donor_ypos[k], k) for k in donor_ypos]))
    plt.xticks(rotation=45)
    plt.xlabel("Date")
    plt.ylabel("Donor")
    plt.tight_layout()
    plt.margins(y=0.1)
    plt.savefig(output, bbox_inches="tight")


def base64_to_string(x):
    if x:
        return base64.b64decode(x).decode('utf8')
    else:
        return x


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description='plot donations and timeframes')
    parser.add_argument('--donor')
    parser.add_argument('--donee')
    parser.add_argument('--output')
    parser.add_argument('--cause_area')
    parser.add_argument('--base64', action='store_true')
    args = parser.parse_args()

    # If --base64 flag is given, interpret all arguments as base64-encoded strings
    if args.base64:
        donor = base64_to_string(args.donor)
        donee = base64_to_string(args.donee)
        output = base64_to_string(args.output)
        cause_area = base64_to_string(args.cause_area)
    else:
        donor = args.donor
        donee = args.donee
        output = args.output
        cause_area = args.cause_area

    if args.donor and args.donee:
        single_donor_single_donee(output, donor, donee)
    elif args.donor:
        single_donor_multiple_donees(output, donor, cause_area=cause_area)
    elif args.donee:
        single_donee_multiple_donors(output, donee)
    else:
        print("Please specify a donor and/or donee.", file=sys.stderr)
