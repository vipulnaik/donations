Minor wrap-up

* Add tables such as cause area X influencer, cause area X country, cause area X disclosures

* There are still a bunch of `PHP Notice:  Undefined offset:` warnings when
  running. Using the [null coalescing operator `??`](http://php.net/manual/en/migration70.new-features.php#migration70.new-features.null-coalesce-op)
  seems like the easiest way to deal with this. This is already used in some
  places ([example](https://github.com/vipulnaik/donations/blob/2b0490bb342613b4f1ca94e9925ca7d0d29f8480/access-portal/backend/yearlyGroupings.inc#L274)).

Next projects

* Classification of donations: discretionary versus normal, general support versus not.

* Display grants by classification in donor page

* Expand disclosure and grant classification beyond Open Phil

Data entry:

* Gates outside IATI

* IATI outside Gates

* Atlantic Philanthropies

* Effective Altruism Survey results?

