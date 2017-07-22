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

        words = ["the", "and", "at", "of", "inc", "llc", "nfp", "institute",
                 "fund", "foundation", "headquarters", "hq"]
        donee = re.sub(r"\b(" + "|".join(words) + r")\b", " ", donee).strip()

        donee = donee.replace("institutes", "institute")

        bad_chars = ['.', '&', '-', ':', ',', ' ']
        for c in bad_chars:
            donee = donee.replace(c, "")

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
