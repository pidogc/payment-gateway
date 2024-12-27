BEGIN;
alter table `order`
    add `platform` tinyint NOT NULL default 0;
COMMIT;