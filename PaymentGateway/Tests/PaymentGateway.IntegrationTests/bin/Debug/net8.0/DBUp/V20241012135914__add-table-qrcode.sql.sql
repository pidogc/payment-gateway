DROP TABLE IF EXISTS `table_qrcode`;
-- 创建 'table_qrcode' 表
CREATE TABLE `table_qrcode`
(
    `id`          BIGINT NOT NULL COMMENT '二维码唯一标识',

    `company_id`  BIGINT NOT NULL COMMENT '公司的唯一标识',

    `merchant_id` BIGINT NOT NULL COMMENT '商户的唯一标识',

    `create_at`   DATETIME(6) NOT NULL COMMENT '记录的创建时间',

    `update_at`   DATETIME(6) NOT NULL COMMENT '记录的最后更新时间',

    -- 定义主键并使用 BTREE 索引
    PRIMARY KEY (`id`) USING BTREE,

    -- 创建组合索引，基于 company_id 和 merchant_id
    KEY           `IX_company_id_merchant_id` (`company_id`, `merchant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='台桌二维码表，用于记录生成的台桌二维码信息';