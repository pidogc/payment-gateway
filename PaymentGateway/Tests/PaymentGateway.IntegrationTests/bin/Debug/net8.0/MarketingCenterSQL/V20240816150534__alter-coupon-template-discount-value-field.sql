BEGIN;
ALTER TABLE marketing_center_coupon_template MODIFY COLUMN `discount_value` decimal (12,4) DEFAULT 0.000 NOT NULL;
COMMIT;