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
  ($_REQUEST['display'] == "full" ? -1 : 30)
);
