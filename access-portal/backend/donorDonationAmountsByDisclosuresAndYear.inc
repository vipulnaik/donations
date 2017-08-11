<?php

$data = array();

$query = <<<EOD
    select count(distinct donee) as numDonees
    from donations
EOD;

if ($stmt = $mysqli->prepare($query)) {
  $stmt->execute();
  $result = $stmt->get_result();
  while ($row = $result->fetch_assoc()) {
    $data['numDonees']['Total']['Total'] = $row['numDonees'];
  }
}

$query = <<<EOD
    select
        count(distinct donee) as numDonees,
        count(*) as numDonations,
        year(donation_date) as year,
        sum(amount) as amount
    from donations
    group by year(donation_date)
EOD;

if ($stmt = $mysqli->prepare($query)) {
  $stmt->execute();
  $result = $stmt->get_result();
  while ($row = $result->fetch_assoc()) {
    $y = $row['year'];
    $data['amount']['Total'][$y] = $row['amount'];
    $data['numDonees']['Total'][$y] = $row['numDonees'];
    $data['numDonations']['Total'][$y] = $row['numDonations'];

    $data['amount']['Total']['Total'] =
     ($data['amount']['Total']['Total'] ?? 0) + $row['amount'];
    $data['numDonations']['Total']['Total'] =
     ($data['numDonations']['Total']['Total'] ?? 0) + $row['numDonations'];
  }
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
    group by
        d1.donor_side_name
EOD;

if ($stmt = $mysqli->prepare($query)) {
  $stmt->execute();
  $result = $stmt->get_result();
  while ($row = $result->fetch_assoc()) {
    $g = $row['donor_side_name'];

    $data['numDonees'][$g]['Total'] = $row['numDonees'];
    $data['numDonations'][$g]['Total'] = $row['numDonations'];

    $data['numDonations']['Classified']['Total'] =
      ($data['numDonations']['Classified']['Total'] ?? 0) + $row['numDonations'];
    $data['numDonees']['Classified']['Total'] =
      ($data['numDonees']['Classified']['Total'] ?? 0) + $row['numDonees'];
  }
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
    group by
        d1.donor_side_name,
        year(donations.donation_date)
EOD;

if ($stmt = $mysqli->prepare($query)) {
  $stmt->execute();
  $result = $stmt->get_result();
  while ($row = $result->fetch_assoc()) {
    $g = $row['donor_side_name'];
    $y = $row['year'];

    $data['amount'][$g][$y] = $row['amount'];
    $data['numDonees'][$g][$y] = $row['numDonees'];
    $data['numDonations'][$g][$y] = $row['numDonations'];

    $data['amount'][$g]['Classified'] =
      ($data['amount'][$g]['Classified'] ?? 0) + $row['amount'];

    $data['amount']['Classified'][$y] =
      ($data['amount']['Classified'][$y] ?? 0) + $row['amount'];
    $data['numDonees']['Classified'][$y] =
      ($data['numDonees']['Classified'][$y] ?? 0) + $row['numDonees'];
    $data['numDonations']['Classified'][$y] =
      ($data['numDonations']['Classified'][$y] ?? 0) + $row['numDonations'];
  }
}

$groupMembers = array_keys($data['amount']);

usort($groupMembers, function($a, $b) use ($data) {
  return intval($data['amount'][$b]['Classified'] ?? 0)
    - intval($data['amount'][$a]['Classified'] ?? 0);
});

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
  print "  <tr>\n";
  print "    <td>$g</td>\n";
  print '    <td align="right">'
    . ($data['numDonations'][$g]['Total'] ?? 0) . "</td>\n";
  print '    <td align="right">'
    . ($data['numDonees'][$g]['Total'] ?? 0) . "</td>\n";
  print '    <td align="right">'
    . number_format($data['amount'][$g]['numDonees'] ?? 0, 2) . "</td>\n";
  foreach ($years as $y) {
    if (($data['amount']['Classified'][$y] ?? 0) != 0) {
      print '    <td align="right">'
        . number_format($data['amount'][$g][$y] ?? 0, 2) . "</td>\n";
    }
  }
  print "  </tr>\n";
}
print'</tbody>';

print "<tfoot>\n";
printFooterRow($data, $years, 'Classified', "Classified total");
printFooterRow($data, $years, 'Total', "Total");
# printFooterRow($data, $years, 'U', "Classified total");
print "</tfoot>\n";

print '</table>';

?>
