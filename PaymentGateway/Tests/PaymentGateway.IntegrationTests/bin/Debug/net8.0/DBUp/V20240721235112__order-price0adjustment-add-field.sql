BEGIN;
alter table `order_price_adjustment`
    add `category_target_id` varchar(64) NOT NULL default '';

alter table `order`
    add `best_coupon_combination` varchar(512) NOT NULL default '';
COMMIT;