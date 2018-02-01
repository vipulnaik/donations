<?php

yearlyGroupings(
  $mysqli,
  $generateGraphCmdBase,
  $imagesPath,
  $years,
  "",
  "country",
  "affected_countries",
  $causeAreaFilterString,
  "",
  ($_REQUEST['display'] == "full" ? -1 : 30)
);
