BEGIN;
alter table `order_item`
    add COLUMN `original_price` decimal(12, 2) NOT NULL default 0.00;
COMMIT;