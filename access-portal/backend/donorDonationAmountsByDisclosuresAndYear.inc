<?php

/* Stick in donor and cause area filtering into the query. query1 is the
 * beginning of the query ("select ... from ...") and query2 is the last part
 * ("group by ..."). Return a mysqli result.
 */
function filteredDonorCauseArea($mysqli, $query1, $query2, $donor,
    $causeAreaFilterString) {

  $query = $query1;

  if ($donor && $causeAreaFilterString) {
    $query .= " where donations.donor = ? and donations.cause_area REGEXP ?";
  } else if ($donor) {
    $query .= " where donations.donor = ?";
  } else if ($causeAreaFilterString) {
    $query .= " where donations.cause_area REGEXP ?";
  }

  $query .= " " . $query2;

  if ($stmt = $mysqli->prepare($query)) {
    if ($donor && $causeAreaFilterString) {
      $stmt->bind_param("ss", $donor, $causeAreaFilterString);
    } else if ($donor) {
      $stmt->bind_param("s", $donor);
    } else if ($causeAreaFilterString) {
      $stmt->bind_param("s", $causeAreaFilterString);
    }
    $stmt->execute();
    $result = $stmt->get_result();
    return $result;
  } else {
    print 'DEBUG: ' . $mysqli->error;
  }
}

$data = array();

/* Fill data for total row total donees cell */
$query = <<<EOD
    select count(distinct donee) as numDonees
    from donations
EOD;
$r = filteredDonorCauseArea($mysqli, $query, "", $donor, $causeAreaFilterString);
while ($row = $r->fetch_assoc()) {
  $data['numDonees']['Total']['Total'] = $row['numDonees'];
}

/* Fill data for classified row total donees */
$query = <<<EOD
    select
        count(distinct donations.donee) as numDonees
    from (
        select
            donor,
            donee,
            donation_url,
            donation_date
        from disclosures
        group by
            donor,
            donee,
            donation_url,
            donation_date
    ) as d1
    left join donations on
        d1.donation_url=donations.url
        and d1.donor=donations.donor
        and d1.donee=donations.donee
        and d1.donation_date=donations.donation_date
EOD;
$r = filteredDonorCauseArea($mysqli, $query, "", $donor,
  $causeAreaFilterString);
while ($row = $r->fetch_assoc()) {
  $data['numDonees']['Classified']['Total'] = $row['numDonees'];
}

/* Fill data for classified row's total cells except total donees */
$query = <<<EOD
    select
        year(donations.donation_date) as year,
        count(*) as numDonations,
        sum(amount) as amount
    from (
        select
            donor,
            donee,
            donation_url,
            donation_date
        from disclosures
        group by
            donor,
            donee,
            donation_url,
            donation_date
    ) as d1
    left join donations on
        d1.donation_url=donations.url
        and d1.donor=donations.donor
        and d1.donee=donations.donee
        and d1.donation_date=donations.donation_date
EOD;

$r = filteredDonorCauseArea(
  $mysqli,
  $query,
  "group by year(donations.donation_date)",
  $donor,
  $causeAreaFilterString
);
while ($row = $r->fetch_assoc()) {
  $y = $row['year'];
  $data['amount']['Classified'][$y] = $row['amount'];

  $data['amount']['Classified']['Total'] =
   ($data['amount']['Classified']['Total'] ?? 0) + $row['amount'];
  $data['numDonations']['Classified']['Total'] =
   ($data['numDonations']['Classified']['Total'] ?? 0) +  $row['numDonations'];
}

/* Fill data for total row except for total donees cell */
$query = <<<EOD
    select
        count(distinct donee) as numDonees,
        count(*) as numDonations,
        year(donation_date) as year,
        sum(amount) as amount
    from donations
EOD;

$r = filteredDonorCauseArea($mysqli, $query, "group by year(donation_date)",
  $donor, $causeAreaFilterString);

while ($row = $r->fetch_assoc()) {
  $y = $row['year'];
  $data['amount']['Total'][$y] = $row['amount'];
  $data['numDonees']['Total'][$y] = $row['numDonees'];
  $data['numDonations']['Total'][$y] = $row['numDonations'];

  $data['amount']['Total']['Total'] =
   ($data['amount']['Total']['Total'] ?? 0) + $row['amount'];
  $data['numDonations']['Total']['Total'] =
   ($data['numDonations']['Total']['Total'] ?? 0) + $row['numDonations'];
}

/* Fill data for individual donor side name rows, for total donees and
 * donations */
$query = <<<EOD
    select
        case when d1.donor_side_name is NULL
            then 'Unknown, generic, or multiple'
            else d1.donor_side_name
            end as donor_side_name,
        count(distinct donations.donee) as numDonees,
        count(*) as numDonations
    from (
        select
            distinct donor_side_name,
            donor,
            donee,
            donation_url,
            donation_date
        from disclosures
    ) as d1
    left join donations on
        d1.donor=donations.donor
        and d1.donee=donations.donee
        and d1.donation_date=donations.donation_date
        and d1.donation_url=donations.url
EOD;

$r = filteredDonorCauseArea($mysqli, $query, "group by d1.donor_side_name",
  $donor, $causeAreaFilterString);

while ($row = $r->fetch_assoc()) {
  $g = $row['donor_side_name'];

  $data['numDonees'][$g]['Total'] = $row['numDonees'];
  $data['numDonations'][$g]['Total'] = $row['numDonations'];
}

/* Fill in data for individual donor side name rows, for yearly cells and total
 * by year. Also fill in data for classified yearly cells. */
$query = <<<EOD
    select
        case when d1.donor_side_name is NULL
            then 'Unknown, generic, or multiple'
            else d1.donor_side_name
            end as donor_side_name,
        year(donations.donation_date) as year,
        count(distinct donations.donee) as numDonees,
        count(*) as numDonations,
        sum(amount) as amount
    from (
        select
            distinct donor_side_name,
            donor,
            donee,
            donation_url,
            donation_date
        from disclosures
    ) as d1
    left join donations on
        d1.donor=donations.donor
        and d1.donee=donations.donee
        and d1.donation_date=donations.donation_date
        and d1.donation_url=donations.url
EOD;

$r = filteredDonorCauseArea($mysqli, $query,
  "group by d1.donor_side_name, year(donations.donation_date)",
  $donor, $causeAreaFilterString);

while ($row = $r->fetch_assoc()) {
  $g = $row['donor_side_name'];
  $y = $row['year'];

  $data['amount'][$g][$y] = $row['amount'];
  $data['numDonees'][$g][$y] = $row['numDonees'];
  $data['numDonations'][$g][$y] = $row['numDonations'];

  $data['amount'][$g]['Total'] =
    ($data['amount'][$g]['Total'] ?? 0) + $row['amount'];
}

$query = <<<EOD
    select
        count(distinct d1.donee) as numDonees
    from (
        select
            donee,
            (donor, donee, url, donation_date) in (
                select
                    donor,
                    donee,
                    donation_url,
                    donation_date
                from disclosures
                group by
                    donor,
                    donee,
                    donation_url,
                    donation_date
            ) as disclosed
        from donations
EOD;
$r = filteredDonorCauseArea(
  $mysqli,
  $query,
  ") as d1 where d1.disclosed=0",
  $donor,
  $causeAreaFilterString
);
while ($row = $r->fetch_assoc()) {
  $data['numDonees']['Unclassified']['Total'] = $row['numDonees'];
}

/* Calculate missing unclassified values */
$data['amount']['Unclassified']['Total'] =
  ($data['amount']['Total']['Total'] ?? 0)
  - ($data['amount']['Classified']['Total'] ?? 0);
$data['numDonations']['Unclassified']['Total'] =
  ($data['numDonations']['Total']['Total'] ?? 0)
  - ($data['numDonations']['Classified']['Total'] ?? 0);
foreach ($years as $y) {
  if (($data['amount']['Classified'][$y] ?? 0) != 0) {
    $data['amount']['Unclassified'][$y] =
      ($data['amount']['Total'][$y] ?? 0)
      - ($data['amount']['Classified'][$y] ?? 0);
  }
}

# print '<pre>';
# print_r($data);
# print '</pre>';

$groupMembers = array_keys($data['amount']);

usort($groupMembers, function($a, $b) use ($data) {
  return intval($data['amount'][$b]['Total'] ?? 0)
    - intval($data['amount'][$a]['Total'] ?? 0);
});

printYearlyGroupedHtmlTable(
  $data,
  "disclosures",
  $groupMembers,
  "",
  $years,
  $causeAreaFilterString,
  $donor ? "donor" : ""
);

?>
