SET NAMES utf8mb4;
SET
FOREIGN_KEY_CHECKS = 0;

DROP TABLE IF EXISTS `message_center_sms_configuration`;
CREATE TABLE `message_center_sms_configuration`
(
    `id`         VARCHAR(36)  NOT NULL,
    `app_id`     VARCHAR(255) NOT NULL,
    `app_secret` VARCHAR(255) NOT NULL,
    `key`        text         NOT NULL,
    `secret`     text         NOT NULL,
    `platform`   int unsigned NOT NULL DEFAULT '0',
    `name`       VARCHAR(255) NOT NULL DEFAULT '',
    `from`       VARCHAR(20)  NOT NULL DEFAULT '',
    `create_at`  DATETIME              DEFAULT NULL,
    `update_at`  DATETIME              DEFAULT NULL,
    PRIMARY KEY (`id`),
    INDEX        `idx_app_id_app_secret` (`app_id`, `app_secret`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;