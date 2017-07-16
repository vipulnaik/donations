import re


donees = []

with open("temp", "r") as f:
    for line in f:
        d = line.strip().lower()
        d = d.replace('.', '')

        d = re.sub(r",? inc\.?", "", d)

        if d in donees:
            print(d)
        donees.append(d)

print(len(donees))
