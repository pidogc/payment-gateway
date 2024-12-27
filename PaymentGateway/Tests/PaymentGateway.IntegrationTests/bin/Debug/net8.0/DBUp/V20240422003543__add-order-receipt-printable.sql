BEGIN;


-- ----------------------------
-- Table structure for waiting_send_kitchen
-- ----------------------------
DROP TABLE IF EXISTS `order_receipt_printable`;
CREATE TABLE `order_receipt_printable`
(
    `id`           bigint NOT NULL,
    `company_id`   bigint NOT NULL,
    `merchant_id`  bigint NOT NULL,
    `order_id`     bigint NOT NULL,
    `printer_type` int unsigned NOT NULL,
    `status`       tinyint unsigned not null default 0,
    `remark`       text   not null,
    `is_delete`    bit(1) NOT NULL DEFAULT b'0',
    `create_at`    datetime(6) NOT NULL,
    `update_at`    datetime(6) NOT NULL,
    PRIMARY KEY (`id`) USING BTREE,
    index          `IX_order_id` (`order_id`) USING BTREE,
    index          `IX_company_id` (`company_id`) USING BTREE,
    index          `IX_merchant_id` (`merchant_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

COMMIT;