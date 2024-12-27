BEGIN;
alter table `daily_report`
    add `is_delete` bit(1) NOT NULL DEFAULT b'0';
COMMIT;