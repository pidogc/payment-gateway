BEGIN;
alter table `order_price_adjustment`
    add `amount` decimal(8, 2) NOT NULL default 0.00;
COMMIT;