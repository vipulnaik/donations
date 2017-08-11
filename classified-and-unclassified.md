# Clarification on "classified" and "unclassified" totals

Several tables on the donations portal have rows labels "classified total" and
"unclassified total". This document explains what they mean and when they add
up to what.

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
