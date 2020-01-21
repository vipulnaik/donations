<?php

yearlyGroupings(
  $mysqli,
  $generateGraphCmdBase,
  $imagesPath,
  $years,
  $donor,
  "influencer",
  "influencer",
  $causeAreaFilterString,
  '<a href="/influencer.php?influencer=%s">%s</a>',
  (isset($_REQUEST['display']) && $_REQUEST['display'] == "full" ? -1 : 30)
);
