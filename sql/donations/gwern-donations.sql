# This file is manually edited.

insert into donations(donor, donee, amount, donation_date, donation_date_precision, donation_date_basis, cause_area, url, notes, payment_modality, amount_original_currency, original_currency, currency_conversion_date, currency_conversion_basis) values
    ('Gwern Branwen','Internet Archive',1000.0,'2015-11-18','day','date of donation announcement','Digital preservation','https://twitter.com/gwern/status/667082325637914625',NULL,NULL,NULL,NULL,NULL,NULL)
    ,('Gwern Branwen','Internet Archive',20.0,'2011-08-01','month','date of donation announced in announcement','Digital preservation','https://www.reddit.com/r/Bitcoin/comments/1sek9w/web_archive_is_asking_for_donations_they_accept/cdx551u/?context=2',NULL,NULL,NULL,NULL,NULL,NULL)
    ,('Gwern Branwen','Internet Archive',6.0,'2012-01-01','month','date of donation announced in announcement','Digital preservation','https://www.reddit.com/r/Bitcoin/comments/1sek9w/web_archive_is_asking_for_donations_they_accept/cdx551u/?context=2',NULL,'Bitcoin transaction',1.0,'BTC','2012-01-15'/* Actually I'm just eyeballing the graph for the whole month of January */,'Coindesk')
    ,('Gwern Branwen','GiveDirectly',540.0,'2015-11-01','month','date of donation announced in announcement','Global poverty','https://www.gwern.net/Tea#ku-ki',NULL,NULL,NULL,NULL,NULL,NULL)
    ,('Gwern Branwen','Brain Preservation Foundation',50.0,'2015-11-01','month','date of donation announced in announcement','Life sciences','https://www.gwern.net/Tea#ku-ki',NULL,NULL,NULL,NULL,NULL,NULL)
    ,('Gwern Branwen','Against Malaria Foundation',NULL,'2015-01-01','year','date of donation announced in announcement','Global health','https://www.reddit.com/r/linuxmasterrace/comments/418xqw/foldinghome_linuxmasterrace_team/cz0zp7e/','Gwern writes that more than 10% of his 2015 income was donated to AMF. The same comment mentions donating to GiveDirectly, but that might just be the November 2015 donations that is entered separately.',NULL,NULL,NULL,NULL,NULL)
;