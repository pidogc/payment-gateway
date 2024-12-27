BEGIN;
alter table `payment`
    add COLUMN `source_type` tinyint NOT NULL default 0;
COMMIT;