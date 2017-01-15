<?php
$donorSelectQuery = "select * from donors where donor='$donor';";
$donorSelectResult = $mysqli -> query($donorSelectQuery);
print '<h4 id="donorInfo">Basic donor information</h4>';
if ($donorSelectResult -> num_rows == 0) {
  print "<p>We do not have any donor information for the donor $donor in our system.";
} else {
  $row = $donorSelectResult -> fetch_assoc();
  print "\n";
  print '<table id="myTableDonorInfo" class="tablesorter">'."\n";
  print "<thead>\n";
  print '<tr><th>Item</th><th>Value</th></tr>';
  print "</thead>\n<tbody>\n";
  print "<tr>\n    <td>Country</td>\n    <td>".$row['country']."</td>\n</tr>\n";
  if ($row['affiliated_orgs'] != '') {
    print '<tr><td>Affiliated organizations (current or former</td><td><a href="'.$row['affiliated_orgs'].'">'.$row['affiliated_orgs'].'</a></td></tr>';
  }
  if ($row['facebook_username'] != '') {
    $facebook_username = $row['facebook_username'];
    $facebook_url = 'https://www.facebook.com/'.$facebook_username;
    if (substr($facebook_username, 0, 4) == "http") {
      $facebook_url = $facebook_username;
    }
    print "<tr>\n    <td>Facebook username</td>\n    ".'<td><a href="'.$facebook_url.'">'.$facebook_username."</a></td>\n</tr>\n";
  }
  if ($row['linkedin_username'] != '') {
    $linkedin_username = $row['linkedin_username'];
    $linkedin_url = 'https://www.linkedin.com/in/' . $linkedin_username;
    print "<tr>\n    <td>LinkedIn username</td>\n    ".'<td><a href="'.$linkedin_url.'">'.$linkedin_username."</a></td>\n</tr>\n";
  }
  if ($row['website'] != '') {
    print '<tr><td>Website</td><td><a href="'.$row['website'].'">'.$row['website'].'</a></td></tr>';
  }
  if ($row['donations_url'] != '') {
    print '<tr><td>Donations URL</td><td><a href="'.$row['donations_url'].'">'.$row['donations_url'].'</a></td></tr>';
  }
  if ($row['twitter_username'] != '') {
    print '<tr><td>Twitter username</td><td><a href="https://twitter.com/'.$row['twitter_username'].'">'.$row['twitter_username'].'</a></td></tr>';
  }
  if ($row['lesswrong_username'] != '') {
    print '<tr><td>LessWrong username</td><td><a href="http://lesswrong.com/user/'.$row['lesswrong_username'].'">'.$row['lesswrong_username'].'</a></td></tr>';
  }
  if ($row['eaf_username'] != '') {
    print '<tr><td>Effective Altruism Forum username</td><td><a href="http://effective-altruism.com/user/'.$row['eaf_username'].'">'.$row['eaf_username'].'</a></td></tr>';
  }
  if ($row['eahub_username'] != '') {
    print '<tr><td>Effective Altruism Hub username</td><td><a href="https://eahub.com/user/'.$row['eahub_username'].'">'.$row['eahub_username'].'</a></td></tr>';
  }
  if ($row['gratipay_username'] != '') {
    print '<tr><td>GratiPay username</td><td><a href="https://gratipay.com/~'.$row['gratipay_username'].'">'.$row['gratipay_username'].'</a></td></tr>';
  }
  if ($row['notes'] != '') {
    print '<tr><td>Notes</td><td>'.$row['notes'].'</td></tr>';
  }
  print "</tbody>\n</table>\n";
}
?>