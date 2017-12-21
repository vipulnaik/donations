<?php

$influencerMoneyMovedSelectQuery = "select * from money_moved where influencer=".'"'.str_replace('"','\"',$influencer).'"'." order by start_date desc";
$influencerMoneyMovedSelectResult = $mysqli -> query($influencerMoneyMovedSelectQuery);
if ($influencerMoneyMovedSelectResult -> num_rows > 0) {
  print '<h4 id="influencerMoneyMovedList">Money moved infomation for influencer '.$influencer.' ('.($influencerMoneyMovedSelectResult -> num_rows).' rows)</h4>';
  print '<table id="myTableInfluencerMoneyMovedList" class="tablesorter">'."\n";
  print "<tr>\n";
  print "<thead>\n";
  print "   <th>Identified donees</th>\n";
  print "   <th>Identified donors</th>\n";
  print "   <th>Amount (current USD)</th>\n";
  print "   <th>Start date</th>\n";
  print "   <th>End date</th>\n";
  print "   <th>Document</th>\n";
  print "   <th>Notes</th>\n";
  print "</tr>\n";
  print "</thead>\n";
  print "<tbody>\n";
  for ($i=0; $i < $influencerMoneyMovedSelectResult -> num_rows; $i++) {
    $moneyMovedRow = $influencerMoneyMovedSelectResult -> fetch_assoc();
    print "<tr>\n";
    print "    <td>".$moneyMovedRow['identified_donees']."</td>\n";
    if ($moneyMovedRow['identified_donors'] != '') {
      print "    <td>".$moneyMovedRow['identified_donors']."</td>\n";
    } else {
      print "    <td>All donors other than ones specified</td>\n";
    }
    print '    <td right="align">'.number_format($moneyMovedRow['amount'],2)."</td>\n";
    print "    <td>".$moneyMovedRow['start_date']."</td>\n";
    print "    <td>".$moneyMovedRow['end_date']."</td>\n";
    print '    <td><a href="'.$moneyMovedRow['document_url'].'">'.$moneyMovedRow['document_title'].'</a></td>'."\n";
    print "    <td>".cleanNotes($moneyMovedRow['notes'])."</td>\n";
    print "</tr>\n";
  }
  print "</tbody>\n";
  print "</table>\n";
}
?>