BEGIN;
ALTER TABLE `product_specifications`
    MODIFY COLUMN `ref_num` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' AFTER `product_num`;
ALTER TABLE `product_barcode`
    MODIFY COLUMN `barcode` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' AFTER `product_num`;
COMMIT;