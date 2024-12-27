DROP TABLE IF EXISTS product_specifications;
CREATE TABLE `product_specifications` (
      `id` bigint NOT NULL,
      `company_id` bigint NOT NULL,
      `merchant_id` bigint NOT NULL,
      `product_id` bigint NOT NULL,
      `product_num` varchar(20)  NOT NULL,
      `ref_num` varchar(20) NOT NULL DEFAULT '',
      `crv` decimal(10,2) NOT NULL DEFAULT '0.00',
      `size` varchar(255) NOT NULL DEFAULT '',
      `fixed_weight` decimal(10,2) NOT NULL DEFAULT '0.00',
      `original_price` decimal(10,2) NOT NULL DEFAULT '0.00',
      `create_at` datetime(6) NOT NULL,
      `update_at` datetime(6) NOT NULL,
      `is_delete` bit(1) NOT NULL DEFAULT b'0',
      PRIMARY KEY (`id`),
      INDEX                      idx_product_id (`company_id`, `merchant_id`, `product_id`, `is_delete`),
      INDEX                      idx_product_num (`company_id`, `merchant_id`, `product_num`, `is_delete`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
