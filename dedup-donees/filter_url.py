#!/usr/bin/env python3

import json
import sys


def main():
    j = json.load(sys.stdin)
    for d in (i for sublist in j.values() for i in sublist):
        print(d["url"])


if __name__ == "__main__":
    main()
