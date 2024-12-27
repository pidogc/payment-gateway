BEGIN;
alter table `payment`
    add `capture_amount` decimal(8, 2) not null default 0.00;
COMMIT;