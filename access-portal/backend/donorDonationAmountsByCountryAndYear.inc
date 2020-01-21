<?php

yearlyGroupings(
  $mysqli,
  $generateGraphCmdBase,
  $imagesPath,
  $years,
  $donor,
  "country",
  "affected_countries",
  $causeAreaFilterString,
  "",
  (isset($_REQUEST['display']) && $_REQUEST['display'] == "full" ? -1 : 30)
);
