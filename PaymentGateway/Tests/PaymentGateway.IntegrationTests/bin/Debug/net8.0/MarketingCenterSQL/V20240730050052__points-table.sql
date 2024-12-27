DROP TABLE IF EXISTS `marketing_center_points_record`;
CREATE TABLE `marketing_center_points_record`
(
    `id`                  varchar(36)    NOT NULL,
    `user_id`             varchar(36)    NOT NULL,
    `platform_id`         varchar(36)    NOT NULL DEFAULT '',
    `reference_id`        varchar(36)    NOT NULL DEFAULT '',
    `points_promotion_id` varchar(36)    NOT NULL DEFAULT '',
    `point_value`         DECIMAL(12, 2) NOT NULL DEFAULT 0.00,
    `point_type`          TINYINT UNSIGNED NOT NULL,
    `create_at`           datetime(6) NOT NULL,
    `update_at`           datetime(6) NOT NULL,
    `desc`                VARCHAR(1024)           DEFAULT '',
    `term_begin_at`       DATETIME                DEFAULT NULL,
    `term_end_at`         DATETIME                DEFAULT NULL,
    `is_calculated`       BOOLEAN                 DEFAULT FALSE,
    `is_delete`           BOOLEAN                 DEFAULT FALSE,
    `member_level`        TINYINT UNSIGNED NOT NULL,
    `points_rate`         DECIMAL(5, 2)  NOT NULL DEFAULT 0.00,
    PRIMARY KEY (`id`),
    KEY                   `idx_user_id_point_type_platform_id` (`id`,`user_id`, `point_type`, `platform_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

DROP TABLE IF EXISTS `marketing_center_member_config`;
CREATE TABLE `marketing_center_member_config`
(
    `id`          varchar(36)   NOT NULL,
    `platform_id` varchar(36)   NOT NULL DEFAULT '',
    `name`        VARCHAR(255)  NOT NULL,
    `level`       TINYINT UNSIGNED NOT NULL DEFAULT 0,
    `rate`        DECIMAL(5, 2) NOT NULL DEFAULT 0.00,
    `is_delete`   BOOLEAN                DEFAULT FALSE,
    PRIMARY KEY (`id`),
    KEY           `idx_member_config_id_level_platform_id` (`id`, `level`, `platform_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

