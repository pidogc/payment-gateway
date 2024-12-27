BEGIN;
alter table `subscription_report`
    add `day_of_month` tinyint unsigned not null default 5;
COMMIT;