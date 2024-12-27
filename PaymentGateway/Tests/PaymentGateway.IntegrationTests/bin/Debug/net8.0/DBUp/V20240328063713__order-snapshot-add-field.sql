BEGIN;
alter table `order_snapshot`
    add is_delete bit(1) default b'0';
COMMIT;