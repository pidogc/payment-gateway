BEGIN;

alter table `marketing_center_coupon_template`
    add column `image` VARCHAR(255) not null DEFAULT '';

alter table `marketing_center_user_coupon`
    add index `idx_user_status` (`user_id`, `status`);

COMMIT;