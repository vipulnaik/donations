<?php
$donorSelectQuery = "select * from donors where donor = ?";
$stmt = $mysqli->prepare($donorSelectQuery);
$stmt->bind_param("s", $donor);
$stmt->execute();
$donorSelectResult = $stmt->get_result();
$affiliatedOrgsList = array();
print '<h4 id="donorInfo">Basic donor information</h4>';
if ($donorSelectResult -> num_rows == 0) {
  print "<p>We do not have any donor information for the donor " . htmlspecialchars($donor) . " in our system.";
} else {
  $row = $donorSelectResult -> fetch_assoc();
  print "\n";
  print '<table id="myTableDonorInfo" class="tablesorter">'."\n";
  print "<thead>\n";
  print '<tr><th>Item</th><th>Value</th></tr>';
  print "</thead>\n<tbody>\n";
  print "<tr>\n    <td>Country</td>\n    <td>".$row['country']."</td>\n</tr>\n";
  if (isset($row['affiliated_orgs']) && $row['affiliated_orgs'] != '') {
    print "<tr><td>Affiliated organizations (current or former; restricted to potential donees or others relevant to donation decisions)</td><td>".explodeDoneePsv($row['affiliated_orgs']).'</td></tr>';
  }
  if (isset($row['wikipedia_page']) && $row['wikipedia_page'] != '') {
    print '<tr><td>Wikipedia page</td><td><a href="'.$row['wikipedia_page'].'">'.$row['wikipedia_page'].'</a></td></tr>';
  }
  if (isset($row['best_overview_url']) && $row['best_overview_url'] != '') {
    print '<tr><td>Best overview URL</td><td><a href="'.$row['best_overview_url'].'">'.$row['best_overview_url'].'</a></td></tr>';
  }
  if (isset($row['facebook_username']) && $row['facebook_username'] != '') {
    $facebook_username = $row['facebook_username'];
    $facebook_url = 'https://www.facebook.com/'.$facebook_username;
    if (substr($facebook_username, 0, 4) == "http") {
      $facebook_url = $facebook_username;
    }
    print "<tr>\n    <td>Facebook username</td>\n    ".'<td><a href="'.$facebook_url.'">'.$facebook_username."</a></td>\n</tr>\n";
  }
  if (isset($row['linkedin_username']) && $row['linkedin_username'] != '') {
    $linkedin_username = $row['linkedin_username'];
    if ($row['donor_type'] == "Individual" or $row['donor_type'] == "Couple") {
      $linkedin_url = 'https://www.linkedin.com/in/' . $linkedin_username;
    } else {
      $linkedin_url = 'https://www.linkedin.com/company/' . $linkedin_username;
    }
    print "<tr>\n    <td>LinkedIn username</td>\n    ".'<td><a href="'.$linkedin_url.'">'.$linkedin_username."</a></td>\n</tr>\n";
  }
  if (isset($row['website']) && $row['website'] != '') {
    print '<tr><td>Website</td><td><a href="'.$row['website'].'">'.$row['website'].'</a></td></tr>';
  }
  if (isset($row['donations_url']) && $row['donations_url'] != '') {
    if (substr($row['donations_url'],0,4) == 'http') {
      print '<tr><td>Donations URL</td><td><a href="'.$row['donations_url'].'">'.$row['donations_url'].'</a></td></tr>';
    } else {
      print '<tr><td>Donations URL</td><td>'.$row['donations_url'].'</td></tr>';
    }
  }
  if (isset($row['twitter_username']) && $row['twitter_username'] != '') {
    print '<tr><td>Twitter username</td><td><a href="https://twitter.com/'.$row['twitter_username'].'">'.$row['twitter_username'].'</a></td></tr>';
  }
  if (isset($row['lesswrong_username']) && $row['lesswrong_username'] != '') {
    print '<tr><td>LessWrong username</td><td><a href="http://lesswrong.com/user/'.$row['lesswrong_username'].'">'.$row['lesswrong_username'].'</a></td></tr>';
  }
  if (isset($row['eaf_username']) && $row['eaf_username'] != '') {
    print '<tr><td>Effective Altruism Forum username</td><td><a href="http://effective-altruism.com/user/'.$row['eaf_username'].'">'.$row['eaf_username'].'</a></td></tr>';
  }
  if (isset($row['eahub_username']) && $row['eahub_username'] != '') {
    print '<tr><td>Effective Altruism Hub username</td><td><a href="https://eahub.org/profile/'.$row['eahub_username'].'">'.$row['eahub_username'].'</a></td></tr>';
  }
  if (isset($row['github_username']) && $row['github_username'] != '') {
    print '<tr><td>GitHub username</td><td><a href="https://github.com/'.$row['github_username'].'">'.$row['github_username'].'</a></td></tr>';
  }
  if (isset($row['gratipay_username']) && $row['gratipay_username'] != '') {
    print '<tr><td>GratiPay username</td><td><a href="https://gratipay.com/~'.$row['gratipay_username'].'">'.$row['gratipay_username'].'</a></td></tr>';
  }
  if (isset($row['predictionbook_username']) && $row['predictionbook_username'] != '') {
    print '<tr><td>PredictionBook username</td><td><a href="https://predictionbook.com/users/'.$row['predictionbook_username'].'">'.$row['predictionbook_username'].'</a></td></tr>';
  }
  if (isset($row['philosophy_url']) && $row['philosophy_url'] != '') {
    print '<tr><td>Page on philosophy informing donations</td><td><a href="'.$row['philosophy_url'].'">'.$row['philosophy_url'].'</a></td></tr>';
  }
  if (isset($row['grant_application_process_url']) && $row['grant_application_process_url'] != '') {
    print '<tr><td>Grant application process page</td><td><a href="'.$row['grant_application_process_url'].'">'.$row['grant_application_process_url'].'</a></td></tr>';
  }
  if (isset($row['donations_data_update_regularity']) && $row['donations_data_update_regularity'] != '') {
    print '<tr><td>Regularity with which donor updates donations data</td><td>'.$row['donations_data_update_regularity'].'</td></tr>';
  }
  if (isset($row['donations_data_dlw_update_regularity']) && $row['donations_data_dlw_update_regularity'] != '') {
    print '<tr><td>Regularity with which Donations List Website updates donations data (after donor update)</td><td>'.$row['donations_data_dlw_update_regularity'].'</td></tr>';
  }
  if (isset($row['donations_data_update_lag']) && $row['donations_data_update_lag'] != '') {
    print '<tr><td>Lag with which donor updates donations data</td><td>'.$row['donations_data_update_lag'].'</td></tr>';
  }
  if (isset($row['donations_data_dlw_update_lag']) && $row['donations_data_dlw_update_lag'] != '') {
    print '<tr><td>Lag with which Donations List Website updates donations data (after donor update)</td><td>'.$row['donations_data_dlw_update_lag'].'</td></tr>';
  }
  if (isset($row['dlw_data_processing_script']) && $row['dlw_data_processing_script'] != '') {
    print '<tr><td>Data entry method on Donations List Website</td><td>SQL insertion commands generated by script <a href="'.$row['dlw_data_processing_script'].'">'.$row['dlw_data_processing_script'].'</td></tr>';
  } else {
    print '<tr><td>Data entry method on Donations List Website</td><td>Manual (no scripts used)</td></tr>';
  }
  if (isset($row['orgwatch']) && $row['orgwatch'] == "1" && isset($row['donor_type'])) {
    $orgwatch_url = 'https://orgwatch.issarice.com';
    if ($row['donor_type'] == "Individual") {
      $orgwatch_url = 'https://orgwatch.issarice.com/?person='.urlencode($row['donor']);
    } else if ($row['donor_type'] == "Private foundation" or $row['donor_type'] == "Subsidiary") {
      $orgwatch_url = 'https://orgwatch.issarice.com/?organization='.urlencode($row['donor']);
    }
    print '<tr><td>Org Watch page</td><td><a href="'.$orgwatch_url.'">'.$orgwatch_url.'</a></td></tr>';
  }
  print "</tbody>\n</table>\n";
}

if (isset($row['brief_history']) && $row['brief_history'] != '') {
    print '<p><b>Brief history</b>: '.cleanNotes($row['brief_history']).'</p>';
}

if (isset($row['brief_donor_focus_notes']) && $row['brief_donor_focus_notes'] != '') {
    print '<p><b>Brief notes on broad donor philosophy and major focus areas</b>: '.cleanNotes($row['brief_donor_focus_notes']).'</p>';
}

if (isset($row['grant_decision_logistics_notes']) && $row['grant_decision_logistics_notes'] != '') {
    print '<p><b>Notes on grant decision logistics</b>: '.cleanNotes($row['grant_decision_logistics_notes']).'</p>';
}

if (isset($row['grant_publication_logistics_notes']) && $row['grant_publication_logistics_notes'] != '') {
    print '<p><b>Notes on grant publication logistics</b>: '.cleanNotes($row['grant_publication_logistics_notes']).'</p>';
}

if (isset($row['grant_financing_notes']) && $row['grant_financing_notes'] != '') {
    print '<p><b>Notes on grant financing</b>: '.cleanNotes($row['grant_financing_notes']).'</p>';
}

if (isset($row['notes']) && $row['notes'] != '') {
    print '<p><b>Miscellaneous notes</b>: '.cleanNotes($row['notes']).'</p>';
}

if ($stmt = $mysqli->prepare("select donee from donations where donee = ?")) {
  $stmt->bind_param("s", $donor);
  $stmt->execute();
  $result = $stmt->get_result();
  if ($result->num_rows > 0) {
    print '<p><a href="/donee.php?donee=' . urlencode($donor)
      . '">This entity is also a donee<a/>.</p>' . "\n";
  }
}

if ($stmt = $mysqli->prepare("select influencer from money_moved where influencer = ?")) {
  $stmt->bind_param("s", $donor);
  $stmt->execute();
  $result = $stmt->get_result();
  if ($result->num_rows > 0) {
    print '<p><a href="/influencer.php?influencer=' . urlencode($donor)
      . '">This entity has also influenced donations by others<a/>.</p>' . "\n";
  }
}
?>
