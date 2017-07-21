#!/usr/bin/env python3
import re
import sys


def donees(f):
    donees = {}

    for line in f:
        original = line.rstrip()
        donee = line.strip().lower()
        donee = donee.replace('.', '')
        donee = donee.replace(' and ', ' & ')
        donee = donee.replace('&', '')

        donee = re.sub(r",? inc\.?", "", donee).strip()
        donee = re.sub(r",? llc\.?", "", donee).strip()

        if donee in donees:
            # This is a duplicate, so show what it is
            donees[donee].append(original)
            print(donee, donees[donee])
        else:
            donees[donee] = [original]


donees(sys.stdin)
