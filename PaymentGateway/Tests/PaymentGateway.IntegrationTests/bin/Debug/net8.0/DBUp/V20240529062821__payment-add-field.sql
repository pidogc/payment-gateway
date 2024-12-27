BEGIN;
alter table `order`
    add COLUMN `payments_refund` decimal(12, 2) default 0.00;
COMMIT;