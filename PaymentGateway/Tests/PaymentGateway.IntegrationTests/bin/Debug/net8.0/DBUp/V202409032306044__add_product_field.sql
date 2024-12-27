BEGIN;
ALTER TABLE `product`
    ADD COLUMN `sales_unit_factor` decimal(10, 2) NOT NULL DEFAULT 1 AFTER `product_num`;


ALTER TABLE `product`
DROP INDEX `idx_product_cid_mid`,
ADD INDEX `idx_product_cid_mid`(`company_id` ASC, `merchant_id` ASC, `is_delete` ASC, `type` ASC, `product_num`) USING BTREE;

COMMIT;