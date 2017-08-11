# Clarification on "classified" and "unclassified" totals

Several tables on the donations portal have rows labeled "classified total" and
"unclassified total". This document explains what they mean and when they add
up to what.

## Meaning

These rows show up in tables that have groupings (e.g. cause area, influencer,
country, disclosures). If a donation can be associated with a group member, it
is "classified"; otherwise it is "unclassified".

As such, these terms have nothing to do with the
[confidential nature](https://en.wikipedia.org/wiki/Classified_information)
of the donations (all donation information is gathered from public sources).

## Summing up columns

- In general, classified total + unclassified total ≥ total.
- For number of donees, classified total + unclassified total ≥ total. Equality
  is not guaranteed because a donee might have received a donation that was
  classified and also a donation that was unclassified.
- For number of donations, classified total + unclassified total = total.
  Equality is guaranteed because each donation is classified xor unclassified.
- For donation amount, classified total + unclassified total = total.
  Equality is guaranteed because each donation is classified xor unclassified.

For groupings, the relevant question is whether each donation can be associated
with just one group member (cause area, influencer, country list – these are
just strings rather than actual lists) or with multiple group members
(`donor_side_name` of disclosures). In the former case, adding up an amounts,
number of donations, or number of donees column will equal the "classified
total" value. In the latter, adding up the column will be greater than or
equal to the "classified total" value.
