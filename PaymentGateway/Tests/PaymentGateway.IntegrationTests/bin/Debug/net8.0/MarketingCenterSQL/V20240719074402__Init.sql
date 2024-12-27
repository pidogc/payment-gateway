SET NAMES utf8mb4;
SET
FOREIGN_KEY_CHECKS = 0;

DROP TABLE IF EXISTS `marketing_center_coupon_template`;
CREATE TABLE `marketing_center_coupon_template`
(
    `id`                  VARCHAR(36)  NOT NULL,
    `platform_id`         VARCHAR(36)    DEFAULT NULL,
    `name`                VARCHAR(255) NOT NULL,
    `coupon_type`         TINYINT UNSIGNED NOT NULL,
    `discount_type`       TINYINT UNSIGNED NOT NULL,
    `has_scope`           BOOLEAN        DEFAULT FALSE,
    `discount_value`      DECIMAL(12, 2) DEFAULT 0.00,
    `threshold_amount`    DECIMAL(12, 2) DEFAULT 0.00,
    `max_discount_amount` DECIMAL(12, 2) DEFAULT 0.00,
    `way`                 TINYINT UNSIGNED DEFAULT NULL,
    `term_days`           INT UNSIGNED DEFAULT NULL,
    `total_number`        INT UNSIGNED DEFAULT NULL,
    `issue_number`        INT UNSIGNED DEFAULT NULL,
    `used_number`         INT UNSIGNED DEFAULT NULL,
    `receive_limit`       INT UNSIGNED DEFAULT 1,
    `status`              TINYINT UNSIGNED DEFAULT NULL,
    `issue_begin_at`      DATETIME       DEFAULT NULL,
    `issue_end_at`        DATETIME       DEFAULT NULL,
    `term_begin_at`       DATETIME       DEFAULT NULL,
    `term_end_at`         DATETIME       DEFAULT NULL,
    `extra`               VARCHAR(1024)  DEFAULT '',
    `desc`                VARCHAR(1024)  DEFAULT '',
    `is_delete`           BOOLEAN        DEFAULT FALSE,
    `create_at`           DATETIME       DEFAULT NULL,
    `update_at`           DATETIME       DEFAULT NULL,
    PRIMARY KEY (`id`),
    INDEX                 `idx_is_delete_status_coupon_type_discount_type` (`is_delete`, `status`, `coupon_type`, `discount_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

DROP TABLE IF EXISTS `marketing_center_exchange_code`;
CREATE TABLE `marketing_center_exchange_code`
(
    `id`            VARCHAR(36) NOT NULL,
    `code`          VARCHAR(10) NOT NULL,
    `user_id`       VARCHAR(36) NOT NULL,
    `associated_id` VARCHAR(36) NOT NULL,
    `status`        TINYINT UNSIGNED NOT NULL,
    `type`          TINYINT UNSIGNED NOT NULL,
    `expired_at`    DATETIME DEFAULT NULL,
    `create_at`     DATETIME DEFAULT NULL,
    `update_at`     DATETIME DEFAULT NULL,
    PRIMARY KEY (`id`),
    INDEX           `idx_code` (`code`),
    INDEX           `idx_code_status` (`code`, `status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

DROP TABLE IF EXISTS `marketing_center_coupon_scope`;
CREATE TABLE `marketing_center_coupon_scope`
(
    `id`              VARCHAR(36) NOT NULL,
    `coupon_id`       VARCHAR(36) NOT NULL,
    `associated_id`   VARCHAR(36) NOT NULL,
    `associated_name` VARCHAR(1024) DEFAULT NULL,
    `type`            TINYINT UNSIGNED NOT NULL,
    `create_at`       DATETIME      DEFAULT NULL,
    `update_at`       DATETIME      DEFAULT NULL,
    PRIMARY KEY (`id`),
    INDEX             `idx_coupon_associated` (`coupon_id`, `associated_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

DROP TABLE IF EXISTS `marketing_center_user_coupon`;
CREATE TABLE `marketing_center_user_coupon`
(
    `id`            VARCHAR(36) NOT NULL,
    `user_id`       VARCHAR(36) NOT NULL,
    `coupon_id`     VARCHAR(36) NOT NULL,
    `status`        TINYINT UNSIGNED NOT NULL,
    `term_begin_at` DATETIME DEFAULT NULL,
    `term_end_at`   DATETIME DEFAULT NULL,
    `create_at`     DATETIME DEFAULT NULL,
    `update_at`     DATETIME DEFAULT NULL,
    PRIMARY KEY (`id`),
    INDEX           `idx_coupon_user_status` (`coupon_id`, `user_id`, `status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;