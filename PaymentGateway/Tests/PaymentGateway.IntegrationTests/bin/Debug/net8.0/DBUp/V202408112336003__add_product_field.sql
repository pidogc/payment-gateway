BEGIN;
ALTER TABLE `product`
    ADD COLUMN `product_num` varchar(20) NOT NULL DEFAULT '',
    ADD COLUMN `sales_unit_type` tinyint NOT NULL DEFAULT 0;
COMMIT;