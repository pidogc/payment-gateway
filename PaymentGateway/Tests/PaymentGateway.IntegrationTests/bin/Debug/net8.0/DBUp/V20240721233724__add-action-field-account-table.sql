BEGIN;
alter table `account`
    add COLUMN `action` tinyint unsigned NOT NULL default 0;
COMMIT;