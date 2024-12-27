BEGIN;
alter table `subscription_report`
    add `month_report_types` VARCHAR(32) NOT NULL;
COMMIT;