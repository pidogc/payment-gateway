BEGIN;
alter table `order_item`
    add `coupon_discount_amount` decimal(10,2) NOT NULL default 0.00;

alter table `order`
    add `coupon_discount_amount` decimal(10,2) NOT NULL default 0.00;
COMMIT;