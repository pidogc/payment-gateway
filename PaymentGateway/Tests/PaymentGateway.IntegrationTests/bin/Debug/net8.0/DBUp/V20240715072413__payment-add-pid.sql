BEGIN;
alter table `payment`
    add COLUMN `pid` bigint(20) NOT NULL default 0;
COMMIT;