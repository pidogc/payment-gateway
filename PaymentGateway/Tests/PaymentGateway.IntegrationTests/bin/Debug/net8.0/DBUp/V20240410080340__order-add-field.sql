BEGIN;
alter table `order`
    add `capture_amount` decimal(10, 2) default 0.00;
COMMIT;