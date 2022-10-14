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
  ($_REQUEST['display'] ?? '') == "individual-scale" ? "donor in (select donor from donors where donor_type = 'Individual' or donor_type = 'Couple')" : ""
);
