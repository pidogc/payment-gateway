BEGIN;
alter table `order_item`
    add `recharge_discount_amount` decimal(10, 2) NOT NULL default 0.00;

alter table `order`
    add `total_recharge_discount_amount` decimal(10, 2) NOT NULL default 0.00,
    add `total_recharge_amount` decimal(10,2) NOT NULL default 0.00;
COMMIT;