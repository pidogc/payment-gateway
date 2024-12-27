SET NAMES utf8mb4;
SET
FOREIGN_KEY_CHECKS = 0;

-- 模版表 --
DROP TABLE IF EXISTS `message_center_wallet_template`;
CREATE TABLE `message_center_wallet_template`
(
    `id`                   VARCHAR(36)  NOT NULL COMMENT '唯一ID',
    `platform_id`          VARCHAR(36) NOT NULL DEFAULT '' COMMENT '商家ID',
    `data`                 longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '数据内容',
    `wallet_platform_type` tinyint unsigned NOT NULL DEFAULT '0' COMMENT 'wallet平台类型',
    `template_type`        tinyint unsigned NOT NULL DEFAULT '0' COMMENT '模板类型',
    `create_at`            DATETIME              DEFAULT NULL COMMENT '创建时间',
    `update_at`            DATETIME              DEFAULT NULL COMMENT '更新时间',
    PRIMARY KEY (`id`),
    INDEX                  `idx_associated_id_platform_type_template_type` (`platform_id`, `wallet_platform_type`, `template_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT '消息中心钱包模板表';

-- 模版和活动类型的关联 --
DROP TABLE IF EXISTS `message_center_wallet_template_relation`;
CREATE TABLE `message_center_wallet_template_relation`
(
    `id`                   VARCHAR(36)  NOT NULL COMMENT '唯一ID',
    `platform_id`          VARCHAR(36) NOT NULL DEFAULT '' COMMENT '商家ID',
    `associated_id`        VARCHAR(36) NOT NULL DEFAULT '' COMMENT '关联ID',
    `template_id`          VARCHAR(36) NOT NULL DEFAULT '' COMMENT '模板ID',
    `wallet_platform_type` tinyint unsigned NOT NULL DEFAULT '0' COMMENT '钱包平台类型',
    `template_type`        tinyint unsigned NOT NULL DEFAULT '0' COMMENT '模板类型',
    `create_at`            DATETIME              DEFAULT NULL COMMENT '创建时间',
    `update_at`            DATETIME              DEFAULT NULL COMMENT '更新时间',
    PRIMARY KEY (`id`),
    INDEX                  `idx_subject_id_related_id_template_id_related_type` (`platform_id`, `associated_id`, `template_id`, `wallet_platform_type`),
    INDEX                  `idx_subject_id_platform_type_related_type` (`platform_id`, `wallet_platform_type`, `template_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT '消息中心钱包模板关联表';

-- wallet info --
DROP TABLE IF EXISTS `message_center_wallet_relation`;
CREATE TABLE `message_center_wallet_relation`
(
    `id`                        VARCHAR(36)  NOT NULL COMMENT '唯一ID',
    `associated_id`             VARCHAR(36) NOT NULL DEFAULT '' COMMENT '关联ID',
    `push_token`                VARCHAR(255) NOT NULL DEFAULT '' COMMENT '推送Token',
    `user_id`                   VARCHAR(36) NOT NULL DEFAULT '' COMMENT '用户ID',
    `device_library_identifier` VARCHAR(255) NOT NULL DEFAULT '' COMMENT '设备库标识符',
    `pass_type_identifier`      VARCHAR(255) NOT NULL DEFAULT '' COMMENT '通行证类型标识符',
    `platform_type`             tinyint unsigned NOT NULL DEFAULT '0' COMMENT '平台类型',
    `related_type`              tinyint unsigned NOT NULL DEFAULT '0' COMMENT '关联类型',
    `create_at`                 DATETIME              DEFAULT NULL COMMENT '创建时间',
    `update_at`                 DATETIME              DEFAULT NULL COMMENT '更新时间',
    `last_updated`              DATETIME              DEFAULT NULL COMMENT '最后更新时间',
    PRIMARY KEY (`id`),
    INDEX                       `idx_user_id` (`user_id`),
    INDEX                       `idx_serial_number_pass_type_identifier_device_library_identifier` (`associated_id`, `pass_type_identifier`, `device_library_identifier`),
    INDEX                       `idx_push_token_serial_number` (`push_token`, `associated_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT '消息中心钱包关联表';
