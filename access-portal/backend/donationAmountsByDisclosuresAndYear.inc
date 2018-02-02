<?php

disclosuresYearlyGroupings(
  $mysqli,
  $generateGraphCmdBase,
  $imagesPath,
  $years,
  "",
  $causeAreaFilterString,
  ($_REQUEST['display'] ?? '') == "individual-scale" ? "donations.donor in (select donor from donors where donor_type = 'Individual' or donor_type = 'Couple')" : ""
);

?>
