import re


def donees(filename):
    donees = []

    with open(filename, "r") as f:
        for line in f:
            d = line.strip().lower()
            d = d.replace('.', '')
            d = d.replace(' and ', '&')
            d = d.replace('&', '')

            d = re.sub(r",? inc\.?", "", d).strip()
            d = re.sub(r",? llc\.?", "", d).strip()

            # if d in donees:
            #     print(d)
            donees.append(d)
    return donees

# print(len(donees("temp")))
print(len(set(donees("temp"))))
# print(len(donees("temp2")))
print(len(set(donees("temp2"))))

print(set(donees("temp2")).difference(set(donees("temp"))))
