<?php
include_once('../doctype.inc');
include_once('../analytics.inc');
?>
<script src="../change-theme.js"></script>
<title>About Donations List Website</title>
<?php
include_once("../style.inc");;
?>

</head>

<body>

<p><span id="changeThemeMenu" style="display: none;">Change <a href="javascript:;" onclick="change_theme_color()">color</a></span>   &thinsp;<!-- blank space to prevent cumulative layout shift --></p>

<p><strong>Donations List Website</strong> is a minimalistic website
with a razor-like focus on understanding donations, donors, donees,
and the thoughts and discussions that go alongside donation
decisions. The site is slated for official launch in July 2024,
and is currently very much in beta.</p>

<h3>Table of contents</h3>

<ul>
  <li><p><a href="#behind-the-curtain">Behind the curtain</a></p></li>
  <li><p><a href="#how-we-built-data">How we built data</a></p></li>
  <li><p><a href="#reliability-concerns">Reliability concerns</a></p></li>
  <li><p><a href="#playing-with-the-data">Playing with the data</a></p></li>
</ul>

<h3 id="behind-the-curtain">Behind the curtain</h3>

<p>The code and data entry for the Donations List Website has been
done by <a href="https://vipulnaik.com">Vipul Naik</a>
and <a href="https://issarice.com">Issa Rice</a>. Vipul Naik takes
primary responsibility for the content. Vipul hosts both the
domain <a href="https://donations.vipulnaik.com">donations.vipulnaik.com</a>
and the GitHub repository of the content,
at <a href="https://github.com/vipulnaik/donations">vipulnaik/donations</a>.</p>

<p>Issa's contributions to the code can be seen by looking
at <a href="https://github.com/vipulnaik/donations/commits?author=riceissa">his
commit history</a>. To see a list of his payments for this work, go
to <a href="https://contractwork.vipulnaik.com/venue.php?venue=Donations+list+website&matching=exact">the contract work page listing all financially compensated tasks for the Donations List Website</a>. With the
exception
of <a href="https://contractwork.vipulnaik.com/tasks.php?receptacle=Donation+amounts+by+disclosures+and+year&matching=exact">one
task commissioned by Peter Hurford</a>, all other work on the site was
paid for by Vipul Naik.</p>

<h3 id="how-we-built-data">How we built data</h3>

<p>Data for the site has come from a mix of publicly available data
and data shared with permission. The data entry methods include:</p>

<ul>
  <li>Completely manual entry: We construct the SQL insert statements
  by examining the donation log or other donation announcement. This
  method has been used for the Open Philanthropy Project, Google.org, and many
  small donors.</li>
  <li>Entry based on processing scripts: We construct the SQL insert
  statements by downloading or otherwise obtaining the data, in a
  format such as CSV. Then we process it using our scripts (in a
  language such as Python) to generate SQL insert statements. In cases
  where the automatic processing has errors, we may hardcode
  exceptions within the script. We always expect that rerunning the
  script on a new version of the data incorporates the fixes for known
  errors. Examples of donors for whom we extracted data using
  processing scripts are the Bill and Melinda Gates Foundation and the
  Laura and John Arnold Foundation.</li>
</ul>

<p>The data entry method is usually described in the donor information
section on the page about the donor; if nothing is mentioned, you can
assume that it is completely manual entry. The donor information
section also includes a link to the donor's own donation log (if
available) as well as information on the frequency and lag of
updates.</p>

<h3 id="reliability-concerns">Reliability concerns</h3>

Data may be unreliable in the following ways:

<ul>
  <li><p>The raw data that we rely on (coming from donors and donees)
  may be inaccurate or not have enough information. For instance, it
  may round up donation amounts, report them in currencies for which
  we do not have an accurate currency conversion factor, not report
  the exact date of the donation, not report whether the donation was
  matched, etc. In some cases, the amounts reported by the donor and
  donee may differ.</p></li>
  <li><p>There may be errors in our process (manual or automated) of
  converting the raw data into SQL insert statements.</p></li>
  <li><p>Data may not be comprehensive, because donors and donees may
  not reveal the entirety of the donations. There may also be issues
  of low frequency of updates and long lag in updates, both on the
  side of the donor/donee, and on our side in incorporating their data
  to update on the Donations List Website.</p></li>
</ul>

<p>If you notice any errors in the data on our side, please email
vipulnaik1@gmail.com with information about what's wrong, and publicly
citable references (if any) for the correct version of the
information. You can do this both if you are the donor/donee or if you
are a third party, though if you are a third party then presenting
citable references is more important.</p>

<p>If you are a donor who made some donation information public but
have now retracted that information from the public sphere, and want
the Donations List Website to also remove the information, again
please email vipulnaik1@gmail.com. Requests from individual donors and
couples will generally be honored if the data we are being asked to
remove is not otherwise publicly available; requests from institutions
(private foundations or their subsidiary grantmaking bodies) will be
evaluated on a case-by-case basis.</p>

<p>If you have any other concerns around reliability, completeness,
accuracy, privacy, or usability of data, please email
vipulnaik1@gmail.com to share your concerns. All your feedback will be
considered before we officially launch the site.</p>

<h3 id="#playing-with-the-data">Playing with the data</h3>

<p>A tutorial for the data
is <a href="https://github.com/vipulnaik/donations#tutorial">available
in the README on GitHub</a>. The tutorial was also posted, along with
a request for feedback, to
the <a href="https://forum.effectivealtruism.org/posts/A7NWTjnWZPmjyLdtT/donations-list-website-tutorial-and-request-for-feedback">Effective Altruism Forum</a>.</p>

<p>Pageview data for this site is available at monthly granularity
at <a href="https://analytics.vipulnaik.com/">analytics.vipulnaik.com</a>.</p>

<?php
include_once("../anchorjs.inc");
?>
</body>
