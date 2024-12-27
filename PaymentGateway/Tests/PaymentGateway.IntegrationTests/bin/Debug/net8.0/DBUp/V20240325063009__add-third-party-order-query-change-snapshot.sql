BEGIN;
DROP TABLE IF EXISTS `third_party_order_query_change_snapshot`;
CREATE TABLE `third_party_order_query_change_snapshot`
(
    `id`          bigint   NOT NULL,
    `order_id`    bigint   NOT NULL,
    `company_id`  bigint   NOT NULL,
    `merchant_id` bigint   NOT NULL,
    `order_query` longtext NOT NULL,
    `create_at`   datetime(6) NOT NULL,
    `update_at`   datetime(6) NOT NULL,
    PRIMARY KEY (`id`) USING BTREE,
    index         `IX_merchant_id` ( `merchant_id`),
    index         `IX_company_id` ( `company_id`),
    index         `IX_order_id` ( `order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
COMMIT;