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

$query = <<<EOD
    select count(distinct donee) as numDonees
    from donations
EOD;
$r = filteredDonorCauseArea($mysqli, $query, "", $donor, $causeAreaFilterString);
while ($row = $r->fetch_assoc()) {
  $data['numDonees']['Total']['Total'] = $row['numDonees'];
}

$query = <<<EOD
    select
        count(*) as numDonations,
        count(distinct donations.donee) as numDonees,
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

$r = filteredDonorCauseArea($mysqli, $query, "", $donor,
  $causeAreaFilterString);
while ($row = $r->fetch_assoc()) {
  $data['amount']['Classified']['Total'] = $row['amount'];
  $data['numDonees']['Classified']['Total'] = $row['numDonees'];
  $data['numDonations']['Classified']['Total'] = $row['numDonations'];
}

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

  $data['amount']['Classified'][$y] =
    ($data['amount']['Classified'][$y] ?? 0) + $row['amount'];
  $data['numDonees']['Classified'][$y] =
    ($data['numDonees']['Classified'][$y] ?? 0) + $row['numDonees'];
  $data['numDonations']['Classified'][$y] =
    ($data['numDonations']['Classified'][$y] ?? 0) + $row['numDonations'];
}

$data['amount']['Unclassified']['Total'] =
  ($data['amount']['Total']['Total'])
  - ($data['amount']['Classified']['Total']);
$data['numDonees']['Unclassified']['Total'] =
  ($data['numDonees']['Total']['Total'])
  - ($data['numDonees']['Classified']['Total']);
$data['numDonations']['Unclassified']['Total'] =
  ($data['numDonations']['Total']['Total'])
  - ($data['numDonations']['Classified']['Total']);

# print '<pre>';
# print_r($data);
# print '</pre>';

$groupMembers = array_keys($data['amount']);

usort($groupMembers, function($a, $b) use ($data) {
  return intval($data['amount'][$b]['Total'] ?? 0)
    - intval($data['amount'][$a]['Total'] ?? 0);
});

print "<p>If you hover over a cell for a given donor side name and year, "
  . "you will get a tooltip with the number of donees and the number of "
  . "donations.</p>\n";

print "<p>Note: Cause area classification used here may not match that "
  ."used by donor for all cases.</p>\n";

print '<table class="tablesorter">' . "\n";
print "<thead>\n";
print "  <tr>\n";
print "    <th>Donor side name</th>\n";
print "    <th>Number of donations</th>\n";
print "    <th>Number of donees</th>\n";
print "    <th>Total</th>\n";
foreach ($years as $y) {
  if (($data['amount']['Classified'][$y] ?? 0) != 0) {
    print "    <th>$y</th>\n";
  }
}
print "  </tr>\n";
print "</thead>\n";

print "<tbody>\n";
foreach ($groupMembers as $g) {
  if ($g != 'Total' && $g != 'Classified' && $g != 'Unclassified') {
    print "  <tr>\n";
    print "    <td>$g</td>\n";
    print '    <td align="right">'
      . ($data['numDonations'][$g]['Total'] ?? 0) . "</td>\n";
    print '    <td align="right">'
      . ($data['numDonees'][$g]['Total'] ?? 0) . "</td>\n";
    print '    <td align="right"><strong>'
      . number_format($data['amount'][$g]['Total'] ?? 0, 2)
      . "</strong></td>\n";
    foreach ($years as $y) {
      if (($data['amount']['Classified'][$y] ?? 0) != 0) {
        print '    <td align="right"><a title="'
          . ($data['numDonations'][$g][$y] ?? 0)
          . ' donations to '
          . ($data['numDonees'][$g][$y] ?? 0)
          . ' distinct donees">'
          . number_format($data['amount'][$g][$y] ?? 0, 2) . "</a></td>\n";
      }
    }
    print "  </tr>\n";
  }
}
print'</tbody>';

print "<tfoot>\n";
printFooterRow($data, $years, 'Classified', "Classified total");
printFooterRow($data, $years, 'Unclassified', "Unclassified total");
printFooterRow($data, $years, 'Total', "Total");
print "</tfoot>\n";

print '</table>';

?>
