<?php
print '<!doctype html public "-//W3C//DTD HTML 4.01 Transitional//EN"><html><head><meta http-equiv="Content-Type" content="text/html;charset=utf-8" >';
print '<title>Donations recorded by Vipul Naik</title>';
include_once('analytics.inc');
print '</head>';
include_once("backend/globalVariables/passwordFile.inc");
print '<body>';
print '<h3>Donations recorded for Vipul Naik</h3>';
include_once('preamble.inc');
print '<h4>Table of contents</h4>';
print '<ul>';
print '<li><a href="#donationAmountsByDonorAndYear">Donation amounts by donor and year</a></li>';
print '<li><a href="#donationAmountsByDoneeAndYear">Donation amounts by donee and year</a></li>';
print '</ul>';

include ("backend/donationAmountsByDonorAndYear.inc");
include ("backend/donationAmountsByDoneeAndYear.inc");

print '</body>';
?>