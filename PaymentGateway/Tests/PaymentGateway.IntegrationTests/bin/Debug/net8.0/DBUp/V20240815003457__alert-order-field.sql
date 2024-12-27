alter table `order`
    change best_coupon_combination best_user_coupon_combination varchar(512) default '' not null;

