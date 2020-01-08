#!/usr/bin/env python3

import sys
import datetime
import mysql.connector
# import matplotlib
# matplotlib.use('Agg')
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

def single_donor_single_donee(donor, donee):
    cursor.execute("""select intended_funding_timeframe_in_months,donation_date from donations where donor = %s and donee = %s""", (donor, donee))
    y = 1
    for intended_funding_timeframe_in_months, donation_date in cursor:
        funding_timeframe_in_days = 30*intended_funding_timeframe_in_months if intended_funding_timeframe_in_months else 10
        xstart = donation_date
        xstop = xstart + datetime.timedelta(days=funding_timeframe_in_days)
        plt.hlines(y, xstart, xstop, 'b', lw=4)
        y += 1

    plt.yticks(range(1,y))
    plt.xlabel("Date")
    plt.ylabel("Grant number")
    plt.show()

def single_donor_multiple_donees(donor):
    cursor.execute("""select donee,intended_funding_timeframe_in_months,donation_date from donations where donor = %s and substring_index(cause_area,'/',1)='AI safety' """, (donor,))
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
    plt.xlabel("Date")
    plt.ylabel("Donee")
    plt.tight_layout()
    plt.show()

def single_donee_multiple_donors(donee):
    cursor.execute("""select donor,intended_funding_timeframe_in_months,donation_date from donations where donee = %s and amount > 100000""", (donee,))
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
    plt.xlabel("Date")
    plt.ylabel("Donor")
    plt.tight_layout()
    plt.show()


# single_donor_single_donee("Open Philanthropy Project", "Machine Intelligence Research Institute")
# single_donor_single_donee("Open Philanthropy Project", "Center for Applied Rationality")
# single_donor_multiple_donees("Open Philanthropy Project")
# single_donee_multiple_donors("Machine Intelligence Research Institute")
