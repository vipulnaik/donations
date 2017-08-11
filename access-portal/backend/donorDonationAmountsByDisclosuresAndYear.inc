<?php

$query = <<<EOD
    select
        d1.donor_side_name as donor_side_name,
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

$data = array();

if ($stmt = $mysqli->prepare($query)) {
  $stmt->execute();
  $result = $stmt->get_result();
  while ($row = $result->fetch_assoc()) {
    $g = $row['donor_side_name'];
    $y = $row['year'];

    $data['amount'][$g][$y] = $row['amount'];
    $data['numDonees'][$g][$y] = $row['numDonees'];
    $data['numDonations'][$g][$y] = $row['numDonations'];

    $data['amount'][$g]['Total'] = ($data['amount'][$g]['Total'] ?? 0)
      + $row['amount'];

    $data['amount']['Total'][$y] = ($data['amount']['Total'][$y] ?? 0)
      + $row['amount'];
    $data['numDonees']['Total'][$y] = ($data['numDonees']['Total'][$y] ?? 0)
      + $row['numDonees'];
    $data['numDonations']['Total'][$y] =
      ($data['numDonations']['Total'][$y] ?? 0) + $row['numDonations'];
  }
}

$groupMembers = array_keys($data['amount']);

usort($groupMembers, function($a, $b) use ($data) {
  return intval($data['amount'][$b]['Total'] ?? 0)
    - intval($data['amount'][$a]['Total'] ?? 0);
});

print '<table class="tablesorter">' . "\n";
print "<thead>\n";
print "  <tr>\n";
print "    <th>Donor side name</th>\n";
print "    <th>Total</th>\n";
foreach ($years as $y) {
  if (($data['amount']['Total'][$y] ?? 0) != 0) {
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
    . number_format($data['amount'][$g]['Total'] ?? 0, 2) . "</td>\n";
  foreach ($years as $y) {
    if (($data['amount']['Total'][$y] ?? 0) != 0) {
      print '    <td align="right">'
        . number_format($data['amount'][$g][$y] ?? 0, 2) . "</td>\n";
    }
  }
  print "  </tr>\n";
}
print'</tbody>';

print '</table>';

?>
