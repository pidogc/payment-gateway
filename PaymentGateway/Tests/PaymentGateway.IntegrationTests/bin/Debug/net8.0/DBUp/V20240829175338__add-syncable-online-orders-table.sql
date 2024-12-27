BEGIN;

-- ----------------------------
-- Table structure for sync able_online_orders
-- ----------------------------

DROP TABLE IF EXISTS `syncable_online_orders`;
CREATE TABLE `syncable_online_orders`
(
    `id`          bigint NOT NULL,
    `merchant_id` bigint NOT NULL,
    `order_id`    bigint NOT NULL,
    `type`        tinyint(2) unsigned NOT NULL default 0,
    `create_at`   datetime(6) NOT NULL,
    `update_at`   datetime(6) NOT NULL,
    PRIMARY KEY (`id`) USING BTREE,
    index         `idx_merchant_id` (`merchant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
COMMIT;