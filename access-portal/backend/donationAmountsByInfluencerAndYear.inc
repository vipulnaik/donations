<?php

yearlyGroupings(
  $mysqli,
  $generateGraphCmdBase,
  $imagesPath,
  $years,
  "",
  "influencer",
  "influencer",
  $causeAreaFilterString,
  '<a href="/influencer.php?influencer=%s">%s</a>',
  ($_REQUEST['display'] ?? '') == "full" ? -1 : 30,
  ($_REQUEST['display'] ?? '') == "individual-scale" ? "donation_date is not null and donor in (select donor from donors where donor_type = 'Individual' or donor_type = 'Couple')" : "donation_date is not null"
);
