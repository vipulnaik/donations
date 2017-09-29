<?php
$doneeSelectQuery = "select * from donees where donee='$donee';";
$doneeSelectResult = $mysqli -> query($doneeSelectQuery);
print '<h4 id="doneeInfo">Basic donee information</h4>';
if ($doneeSelectResult -> num_rows == 0) {
  print "<p>We do not have any donee information for the donee $donee in our system.";
} else {
  $row = $doneeSelectResult -> fetch_assoc();
  print "\n";
  print '<table id="myTableDoneeInfo" class="tablesorter">'."\n";
  print "<thead>\n";
  print '<tr><th>Item</th><th>Value</th></tr>';
  print "</thead>\n<tbody>\n";
  print "<tr>\n    <td>Country</td>\n    <td>".$row['country']."</td>\n</tr>\n";
  if ($row['facebook_username'] != '') {
    $facebook_username = $row['facebook_username'];
    $facebook_url = 'https://www.facebook.com/'.$facebook_username;
    if (substr($facebook_username, 0, 4) == "http") {
      $facebook_url = $facebook_username;
    }
    print "<tr>\n    <td>Facebook page</td>\n    ".'<td><a href="'.$facebook_url.'">'.$facebook_username."</a></td>\n</tr>\n";
  }
  if (isset($row['website']) && $row['website'] != '') {
    print '<tr><td>Website</td><td><a href="'.$row['website'].'">'.$row['website'].'</a></td></tr>';
  }
  if (isset($row['donate_page']) && $row['donate_page'] != '') {
    print '<tr><td>Donate page</td><td><a href="'.$row['donate_page'].'">'.$row['donate_page'].'</a></td></tr>';
  }
  if (isset($row['donor_list_page']) && $row['donor_list_page'] != '') {
    print '<tr><td>Donors list page</td><td><a href="'.$row['donor_list_page'].'">'.$row['donor_list_page'].'</a></td></tr>';
  }
  if (isset($row['transparency_and_financials_page']) && $row['transparency_and_financials_page'] != '') {
    print '<tr><td>Transparency and financials page</td><td><a href="'.$row['transparency_and_financials_page'].'">'.$row['transparency_and_financials_page'].'</a></td></tr>';
  }
  if (isset($row['donation_case_page']) && $row['donation_case_page'] != '') {
    print '<tr><td>Donation case page</td><td><a href="'.$row['donation_case_page'].'">'.$row['donation_case_page'].'</a></td></tr>';
  }
  if (isset($row['donation_statistics_page']) && $row['donation_statistics_page'] != '') {
    print '<tr><td>Donation statistics page</td><td><a href="'.$row['donation_statistics_page'].'">'.$row['donation_statistics_page'].'</a></td></tr>';
  }
  if (isset($row['contact_email']) && $row['contact_email'] != '') {
    print '<tr><td>'.$row['contact_email'].'</td></tr>';
  }
  if (isset($row['twitter_username']) && $row['twitter_username'] != '') {
    print '<tr><td>Twitter username</td><td><a href="https://twitter.com/'.$row['twitter_username'].'">'.$row['twitter_username'].'</a></td></tr>';
  }
  if (isset($row['lesswrong_username']) && $row['lesswrong_username'] != '') {
    print '<tr><td>LessWrong username</td><td><a href="http://lesswrong.com/user/'.$row['lesswrong_username'].'">'.$row['lesswrong_username'].'</a></td></tr>';
  }
  if (isset($row['eahub_username']) && $row['eahub_username'] != '') {
    print '<tr><td>Effective Altruism Hub</td><td><a href="https://eahub.org/charities/'.$row['eahub_username'].'">'.$row['eahub_username'].'</a></td></tr>';
  }
  if (isset($row['wikipedia_page']) && $row['wikipedia_page'] != '') {
    print '<tr><td>Wikipedia page</td><td><a href="'.$row['wikipedia_page'].'">'.$row['wikipedia_page'].'</a></td></tr>';
  }
  if (isset($row['givewell_review']) && $row['givewell_review'] != '') {
    print '<tr><td>GiveWell review</td><td><a href="'.$row['givewell_review'].'">'.$row['givewell_review'].'</a></td></tr>';
  }
  if (isset($row['open_phil_grant_review']) && $row['open_phil_grant_review'] != '') {
    print '<tr><td>Open Philanthropy Project grant review</td><td><a href="'.$row['open_phil_grant_review'].'">'.$row['open_phil_grant_review'].'</a></td></tr>';
  }
  if (isset($row['instagram_username']) && $row['instagram_username'] != '') {
    print '<tr><td>Instagram username</td><td><a href="https://www.instagram.com/'.$row['instagram_username'].'">'.$row['instagram_username'].'</a></td></tr>';
  }
  if (isset($row['tumblr_subdomain']) && $row['tumblr_subdomain'] != '') {
    print '<tr><td>Tumblr subdomain</td><td><a href="http://'.$row['tumblr_subdomain'].'.tumblr.com">'.$row['tumblr_subdomain'].'</a></td></tr>';
  }
  if (isset($row['medium_username']) && $row['medium_username'] != '') {
    print '<tr><td>Medium username</td><td><a href="https://www.medium.com/@'.$row['medium_username'].'">'.$row['medium_username'].'</a></td></tr>';
  }
  if (isset($row['charity_navigator_page']) && $row['charity_navigator_page'] != '') {
    print '<tr><td>Charity Navigator page</td><td><a href="'.$row['charity_navigator_page'].'">'.$row['charity_navigator_page'].'</a></td></tr>';
  }
  if (isset($row['guidestar_page']) && $row['guidestar_page'] != '') {
    print '<tr><td>Guidestar page</td><td><a href="'.$row['guidestar_page'].'">'.$row['guidestar_page'].'</a></td></tr>';
  }
  if (isset($row['timelines_wiki_page']) && $row['timelines_wiki_page'] != '') {
    print '<tr><td>Timelines wiki page</td><td><a href="'.$row['timelines_wiki_page'].'">'.$row['timelines_wiki_page'].'</a></td></tr>';
  }
  if ($row['notes'] != '') {
    print '<tr><td>Notes</td><td>'.$row['notes'].'</td></tr>';
  }
  print "</tbody>\n</table>\n";
}
?>
