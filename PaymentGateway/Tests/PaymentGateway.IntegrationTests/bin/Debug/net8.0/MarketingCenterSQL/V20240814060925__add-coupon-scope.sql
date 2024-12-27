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