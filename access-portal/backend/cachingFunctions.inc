<?php

function needToRegenerate($cache_location) {
  if (!file_exists("cache")) {
    mkdir("cache");
  }
  if (file_exists("cache/DB_LAST_UPDATE_TRACKER")
      && file_exists($cache_location)
      && filemtime("cache/DB_LAST_UPDATE_TRACKER") > filemtime($cache_location)) {
    // Both the tracker and cache exist, but the cache is stale so regenerate
    $regenerate = true;
  } else if (file_exists($cache_location)) {
    // Tracker doesn't exist or the cache is newer so use the cache
    $regenerate = false;
  } else {
    // Cache doesn't exist so generate it
    $regenerate = true;
  }

  return $regenerate;
}
