<?php

if (!isset($causeAreaFilterString)) {
  $causeAreaFilterString = '';
}

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
  (isset($_REQUEST['display']) && $_REQUEST['display'] == "full" ? -1 : 30)
);

?>
