<?php

print '<h4>Donor–donee relationship</h4>';

$query = "select * from donor_donee_relationships where donor = ? and donee = ?";
if ($stmt = $mysqli->prepare($query)) {
  $stmt->bind_param("ss", $donor, $donee);
  $stmt->execute();
  $result = $stmt->get_result();
}

print '<table id="myTableDonorDoneeRelationship" class="tablesorter">' . "\n";
print "  <thead>\n";
print "    <tr>\n";
print "      <th>Item</th>\n";
print "      <th>Value</th>\n";
print "    </tr>\n";
print "  </thead>\n";
print "  <tbody>\n";
// There should be at most one row here, but doing it in a while loop is still
// convenient.
while ($row = $result->fetch_assoc()) {
  if ($row['relationship_start_date']) {
    print "<tr>\n";
    print "  <td>Relationship start date</td>\n";
    print "  <td>" . $row['relationship_start_date'] . "(precision: " . $row['relationship_start_date_precision'] . ")</td>\n";
    print "</tr>\n";
  }
  if ($row['key_interaction_urls']) {
    print "<tr>\n";
    print "  <td>Key interactions</td>\n";
    print "  <td><ul>";
    foreach (explode("|", $row['key_interaction_urls']) as $url) {
      print '  <li><a href="' . $url . '">' . $url . "</a></li>\n";
    }
    print "</ul></td>\n";
    print "</tr>\n";
  }
  if ($row['notes']) {
    print "<tr>\n";
    print "  <td>Notes</td>\n";
    print "  <td>" . $row['notes'] . "</td>\n";
    print "</tr>\n";
  }
}
print "  </tbody>\n";
print "</table>\n";

?>
