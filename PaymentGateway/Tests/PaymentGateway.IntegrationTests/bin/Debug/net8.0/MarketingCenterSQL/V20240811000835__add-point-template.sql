BEGIN;

DROP TABLE IF EXISTS `marketing_center_points_promotion_template`;
CREATE TABLE `marketing_center_points_promotion_template`
(
    `id`            varchar(36)    NOT NULL,
    `name`          VARCHAR(255)   NOT NULL,
    `value`         DECIMAL(12, 2) NOT NULL DEFAULT 0.00,
    `rule`          TINYINT UNSIGNED NOT NULL,
    `type`          TINYINT UNSIGNED NOT NULL,
    `create_at`     datetime(6) NOT NULL,
    `update_at`     datetime(6) NOT NULL,
    `term_begin_at` DATETIME                DEFAULT NULL,
    `term_end_at`   DATETIME                DEFAULT NULL,
    `desc`          VARCHAR(1024)           DEFAULT '',
    `is_delete`     BOOLEAN                 DEFAULT FALSE,
    PRIMARY KEY (`id`),
    KEY             `idx_points_promotion_template_id_type` (`id`,`type`, `is_delete`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


DROP TABLE IF EXISTS `marketing_center_members`;
CREATE TABLE `marketing_center_members`
(
    `id`                          varchar(36)                                                  NOT NULL,
    `phone`                       varchar(20)                                                  NOT NULL,
    `name`                        varchar(255)                                                 NOT NULL,
    `first_name`                  varchar(255)                                                 NOT NULL,
    `last_name`                   varchar(255)                                                 NOT NULL,
    `mail`                        varchar(255)                                                 NOT NULL,
    `birthday`                    integer unsigned                                             NOT NULL DEFAULT 101,
    `identifier`                  varchar(128)                                                 NOT NULL DEFAULT '',
    `language_preference`         varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'en_US',
    `platform`                    tinyint unsigned NOT NULL,
    `status`                      tinyint unsigned NOT NULL,
    `available_user_coupon_count` INT UNSIGNED NOT NULL DEFAULT 0,
    `points`                      DECIMAL(12, 2)                                               NOT NULL DEFAULT 0.00,
    `member_level`                TINYINT UNSIGNED NOT NULL DEFAULT 0,
    `points_rate`                 DECIMAL(5, 2)                                                NOT NULL DEFAULT 0.00,
    `create_at`                   datetime(6) NOT NULL,
    `update_at`                   datetime(6) NOT NULL,
    PRIMARY KEY (`id`),
    KEY                           `IX_marketing_center_members_phone` (`phone`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

COMMIT;