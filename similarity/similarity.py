#!/usr/bin/env python3

import sys
import mysql.connector
import math

cnx = mysql.connector.connect(user='issa', database='donations')
cursor = cnx.cursor()

first_donor = "Open Philanthropy Project"
cursor.execute("""select donee, coalesce(sum(amount), 0) from donations where donor = %s group by donee""", (first_donor,))
first_donor_dict = {donee: amount for (donee, amount) in cursor}
first_donor_weighted_magnitude = math.sqrt(sum(map(lambda x: x**2, first_donor_dict.values())))

WEIGHTED_DOT_PRODUCTS = {}
UNION_SIZES = {}
INTERSECT_SIZES = {}
WEIGHTED_MAGNITUDES = {}

SIMILARITY_RESULT = []

# cursor.execute("""select, donor, donee, coalesce(sum(amount), 0) as total_donation, count(*) as num_donations from donations where donor = %s group by donor, donee""", (first_donor,))
# rows = cursor.fetchall()

cursor.execute("""select distinct(donor) from donations""")
donors = cursor.fetchall()
for (second_donor,) in donors:
    cursor.execute("""select donee, coalesce(sum(amount), 0) from donations where donor = %s group by donee""", (second_donor,))
    second_donor_dict = {donee: amount for (donee, amount) in cursor}
    WEIGHTED_DOT_PRODUCTS[second_donor] = 0
    intersection = set(first_donor_dict.keys()).intersection(second_donor_dict.keys())
    INTERSECT_SIZES[second_donor] = len(intersection)
    UNION_SIZES[second_donor] = len(set(first_donor_dict.keys()).union(second_donor_dict.keys()))
    for donee in intersection:
        WEIGHTED_DOT_PRODUCTS[second_donor] += first_donor_dict[donee] * second_donor_dict[donee]

    WEIGHTED_MAGNITUDES[second_donor] = math.sqrt(sum(map(lambda x: x**2, second_donor_dict.values())))

    assert len(first_donor_dict) + len(second_donor_dict) == UNION_SIZES[second_donor] + INTERSECT_SIZES[second_donor]

    jaccard_index = INTERSECT_SIZES[second_donor] / UNION_SIZES[second_donor]
    if WEIGHTED_MAGNITUDES[second_donor] != 0 and first_donor_weighted_magnitude != 0:
        weighted_cosine_similarity = WEIGHTED_DOT_PRODUCTS[second_donor] / (WEIGHTED_MAGNITUDES[second_donor] * first_donor_weighted_magnitude)
    else:
        weighted_cosine_similarity = "null"
    if len(first_donor_dict) != 0 and len(second_donor_dict) != 0:
        cosine_similarity = INTERSECT_SIZES[second_donor] / (math.sqrt(len(first_donor_dict)) * math.sqrt(len(second_donor_dict)))
    else:
        cosine_similarity = "null"
    SIMILARITY_RESULT.append((second_donor, jaccard_index, cosine_similarity, weighted_cosine_similarity))

for (second_donor, jaccard_index, cosine_similarity, weighted_cosine_similarity) in sorted(SIMILARITY_RESULT, key=lambda t: t[1]):
    print("%s: Jaccard index=%s, Cosine similarity=%s, Weighted cosine similarity=%s" % (second_donor, jaccard_index, cosine_similarity, weighted_cosine_similarity))
