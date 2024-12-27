BEGIN;
alter table `event_store`
    add `sync_count` tinyint(6) not null  DEFAULT 0;
COMMIT;