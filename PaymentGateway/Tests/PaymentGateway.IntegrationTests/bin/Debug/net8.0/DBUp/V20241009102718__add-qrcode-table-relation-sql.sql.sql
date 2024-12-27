DROP TABLE IF EXISTS `qrcode_table_relation`;
-- 创建 'QRCodeTableRelation' 表
CREATE TABLE `qrcode_table_relation`
(
    `id`          BIGINT      NOT NULL COMMENT '二维码与台桌关联的唯一标识',

    `company_id`  BIGINT      NOT NULL COMMENT '公司的唯一标识',

    `merchant_id` BIGINT      NOT NULL COMMENT '商户的唯一标识',

    `code_id`     VARCHAR(36) NOT NULL COMMENT '二维码标识，用于扫码点餐',

    `table_id`    BIGINT      NOT NULL COMMENT '台桌的唯一标识',

    `create_at`   DATETIME(6) NOT NULL COMMENT '记录的创建时间',

    `update_at`   DATETIME(6) NOT NULL COMMENT '记录的最后更新时间',

    -- 定义主键并使用 BTREE 索引
    PRIMARY KEY (`id`) USING BTREE,

    -- 创建组合索引，基于 company_id 和 merchant_id
    KEY           `IX_company_id_merchant_id_table_id_code_id` (`company_id`, `merchant_id`, `table_id`, `code_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='二维码与台桌的关联表，用于记录扫码点餐信息';