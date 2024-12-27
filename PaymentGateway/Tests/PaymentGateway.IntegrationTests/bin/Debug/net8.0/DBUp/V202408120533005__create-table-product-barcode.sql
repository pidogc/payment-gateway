DROP TABLE IF EXISTS product_barcode;
CREATE TABLE product_barcode
(
     `id` bigint NOT NULL,
     `company_id` bigint NOT NULL,
     `merchant_id` bigint NOT NULL,
     `product_id` bigint NOT NULL,
     `product_num` varchar(20) NOT NULL,
     `barcode` varchar(20) NOT NULL,
     `create_at` datetime(6) NOT NULL,
     `update_at` datetime(6) NOT NULL,
     `is_delete` bit(1) NOT NULL DEFAULT b'0',
     PRIMARY KEY (`id`),
     INDEX `idx_barcode`(`barcode` ASC, `company_id` ASC, `merchant_id` ASC, `is_delete` ASC) USING BTREE,
     INDEX `idx_product_id`(`company_id` ASC, `merchant_id` ASC, `product_id` ASC, `is_delete` ASC) USING BTREE,
     INDEX `idx_product_num`(`company_id` ASC, `merchant_id` ASC, `product_num` ASC, `is_delete` ASC) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

