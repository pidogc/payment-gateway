BEGIN;
alter table `capture_record`
    add `is_delete` bit(1) default b'0';
COMMIT;