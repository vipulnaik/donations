#!/usr/bin/env python3
import re
import sys


def donees(f):
    result = {}

    for line in f:
        original = line.rstrip()

        donee = line.strip().lower()
        donee = donee.replace('.', '')
        donee = donee.replace(' and ', ' ')
        donee = donee.replace(' & ', ' ')
        donee = donee.replace('-', ' ')
        donee = donee.replace(': ', ' ')
        donee = re.sub(r"(,? (inc|llc|nfp|institute|fund|foundation))+",
                       "", donee).strip()

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

