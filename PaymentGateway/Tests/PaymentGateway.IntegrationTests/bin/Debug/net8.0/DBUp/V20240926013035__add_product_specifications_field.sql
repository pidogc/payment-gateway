BEGIN;
ALTER TABLE `product_specifications`
    ADD COLUMN `type` varchar(20) NOT NULL DEFAULT '' AFTER `original_price`;
COMMIT;