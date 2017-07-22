#!/usr/bin/env python3

# This script reads organization names from standard input and highlights
# possible duplicates (i.e. instances of the same organization written in
# different ways). It is intended to cast a wide net, so there might be false
# positives (i.e. rather than finding a small number of certain duplicates, it
# finds a large number of possible duplicates). This script just flags these
# potential duplicates; the actual deduplication must be done elsewhere.

import re
import sys


def donees(f):
    result = {}

    for line in f:
        original = line.rstrip()

        donee = line.strip().lower()
        donee = re.sub(r"the regents of (the )?", "", donee).strip()
        donee = donee.replace('.', '')
        donee = re.sub(r"\b(the|and|at|of)\b", " ", donee).strip()
        donee = donee.replace(' & ', ' ')
        donee = donee.replace('-', ' ')
        donee = donee.replace(': ', ' ')
        donee = re.sub(r"(,? (inc|llc|nfp|institute|fund|foundation"
                       r"|headquarters|hq))+$",
                       "", donee).strip()

        donee = donee.replace("institutes", "institute")
        donee = donee.replace(',', '')
        donee = donee.replace(' ', "")

        if donee in result:
            result[donee].append(original)
        else:
            result[donee] = [original]

    return result


if __name__ == "__main__":
    d = donees(sys.stdin)
    for donee in d:
        if len(d[donee]) > 1:
            print(donee + ":", d[donee])
