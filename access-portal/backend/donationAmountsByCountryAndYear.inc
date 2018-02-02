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
  ($_REQUEST['display'] == "full" ? -1 : 30),
  ($_REQUEST['display'] ?? '') == "individual-scale" ? "donor in (select donor from donors where donor_type = 'Individual' or donor_type = 'Couple')" : ""
);
