<?php

yearlyGroupings(
  $mysqli,
  $generateGraphCmdBase,
  $imagesPath,
  $years,
  $donor,
  "subcause area",
  "cause_area",
  $causeAreaFilterString,
  "",
  ($_REQUEST['display'] == "full" ? -1 : 30)
);

?>
