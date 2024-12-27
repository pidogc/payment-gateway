DROP TABLE IF EXISTS `order_item_return`;

CREATE TABLE `order_item_return`
(
    `id`                       BIGINT(20) UNSIGNED NOT NULL,
    `merchant_id`              BIGINT(20) UNSIGNED NOT NULL DEFAULT '0',
    `original_order_id`        BIGINT(20) UNSIGNED NOT NULL DEFAULT '0',
    `original_order_item_id`   BIGINT(20) UNSIGNED NOT NULL DEFAULT '0',
    `return_order_id`          BIGINT(20) UNSIGNED NOT NULL DEFAULT '0',
    `return_order_item_id`     BIGINT(20) UNSIGNED NOT NULL DEFAULT '0',
    `return_quantity`          int unsigned NOT NULL default 0,
    `return_sales_unit_factor` decimal(8, 2) NOT NULL,
    `create_at`                DATETIME      NOT NULL,
    `update_at`                DATETIME      NOT NULL,
    PRIMARY KEY (id),
    INDEX                      merchant_id_original_order_id_original_order_item_id (merchant_id, original_order_id,original_order_item_id),
    INDEX                      merchant_id_return_order_id_return_order_item_id (merchant_id, return_order_id, return_order_item_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
