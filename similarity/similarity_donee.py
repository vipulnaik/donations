#!/usr/bin/env python3

import sys
import mysql.connector
import math
import time

start_time = time.time()

cnx = mysql.connector.connect(user='issa', database='donations')
cursor = cnx.cursor()
cursor.execute("""select distinct(donee) from donations""")
DONEES = cursor.fetchall()
print("NUM DONEES: " + str(len(DONEES)))
count = 0
for (first_donee,) in DONEES:
    count += 1
    print("Donee number %s, Elapsed time: %s" % (count, time.time() - start_time,))
    cursor.execute("""select donor, coalesce(sum(amount), 0) from donations where donee = %s group by donor""", (first_donee,))
    first_donee_dict = {donor: amount for (donor, amount) in cursor}
    first_donee_weighted_magnitude = math.sqrt(sum(map(lambda x: x**2, first_donee_dict.values())))

    WEIGHTED_DOT_PRODUCTS = {}
    UNION_SIZES = {}
    INTERSECT_SIZES = {}
    WEIGHTED_MAGNITUDES = {}

    SIMILARITY_RESULT = []

    # cursor.execute("""select, donee, donor, coalesce(sum(amount), 0) as total_donation, count(*) as num_donations from donations where donee = %s group by donee, donor""", (first_donee,))
    # rows = cursor.fetchall()

    cursor.execute("""select distinct(donee) from donations""")
    donees = cursor.fetchall()
    for (second_donee,) in donees:
        cursor.execute("""select donor, coalesce(sum(amount), 0) from donations where donee = %s group by donor""", (second_donee,))
        second_donee_dict = {donor: amount for (donor, amount) in cursor}
        WEIGHTED_DOT_PRODUCTS[second_donee] = 0
        intersection = set(first_donee_dict.keys()).intersection(second_donee_dict.keys())
        INTERSECT_SIZES[second_donee] = len(intersection)
        UNION_SIZES[second_donee] = len(set(first_donee_dict.keys()).union(second_donee_dict.keys()))
        for donor in intersection:
            WEIGHTED_DOT_PRODUCTS[second_donee] += first_donee_dict[donor] * second_donee_dict[donor]

        WEIGHTED_MAGNITUDES[second_donee] = math.sqrt(sum(map(lambda x: x**2, second_donee_dict.values())))

        assert len(first_donee_dict) + len(second_donee_dict) == UNION_SIZES[second_donee] + INTERSECT_SIZES[second_donee]

        jaccard_index = INTERSECT_SIZES[second_donee] / UNION_SIZES[second_donee]
        if WEIGHTED_MAGNITUDES[second_donee] != 0 and first_donee_weighted_magnitude != 0:
            weighted_cosine_similarity = WEIGHTED_DOT_PRODUCTS[second_donee] / (WEIGHTED_MAGNITUDES[second_donee] * first_donee_weighted_magnitude)
        else:
            weighted_cosine_similarity = "null"
        if len(first_donee_dict) != 0 and len(second_donee_dict) != 0:
            cosine_similarity = INTERSECT_SIZES[second_donee] / (math.sqrt(len(first_donee_dict)) * math.sqrt(len(second_donee_dict)))
        else:
            cosine_similarity = "null"
        SIMILARITY_RESULT.append((second_donee, jaccard_index, cosine_similarity, weighted_cosine_similarity))

    # for (second_donee, jaccard_index, cosine_similarity, weighted_cosine_similarity) in sorted(SIMILARITY_RESULT, key=lambda t: t[1]):
        # print("%s: Jaccard index=%s, Cosine similarity=%s, Weighted cosine similarity=%s" % (second_donee, jaccard_index, cosine_similarity, weighted_cosine_similarity))
