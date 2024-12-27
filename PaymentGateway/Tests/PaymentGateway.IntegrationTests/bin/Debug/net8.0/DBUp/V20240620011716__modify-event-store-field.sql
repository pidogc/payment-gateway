BEGIN;
alter table `event_store`
    MODIFY `error_msg` MEDIUMTEXT NOT NULL;
COMMIT;