DROP TABLE IF EXISTS `merchant_message`;
CREATE TABLE `merchant_message`
(
    `id`            bigint      NOT NULL,                                   -- 消息ID
    `merchant_id`   VARCHAR(36) NOT NULL,                                   -- 商户ID
    `sender_id`     VARCHAR(36) NOT NULL,                                   -- 发送者ID
    `handler_id`    VARCHAR(36) NOT NULL DEFAULT "",                        -- 处理者ID
    `sender_source` TINYINT UNSIGNED NOT NULL COMMENT '发送者来源',         -- 发送者来源
    `content`       TEXT        NOT NULL,                                   -- 消息内容
    `action_type`   TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '行为类型', -- 行为类型（枚举）
    `status`        TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '消息状态', -- 消息状态
    `row_version`   bigint      NOT NULL DEFAULT '0',
    `create_at`     DATETIME(6) NOT NULL COMMENT '记录的创建时间',
    `update_at`     DATETIME(6) NOT NULL COMMENT '记录的最后更新时间',
    `is_delete`     bit(1)      NOT NULL DEFAULT b'0',
    PRIMARY KEY (`id`),
    KEY             `idx_merchant_id` (`merchant_id`),                      -- 商户ID的索引
    KEY             `idx_sender_id` (`sender_id`),                          -- 发送者ID的索引
    KEY             `idx_status_sender_source_action_type` (`status`, `sender_source`, `action_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='用于存储商家消息，客户请求或员工处理等信息';
