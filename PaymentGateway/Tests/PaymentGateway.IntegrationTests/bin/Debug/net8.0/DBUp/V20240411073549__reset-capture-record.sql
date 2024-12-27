SET NAMES utf8mb4;

BEGIN;
DROP TABLE IF EXISTS `capture_record`;
CREATE TABLE `capture_record`
(
    `id`                bigint unsigned NOT NULL,
    `serial`            bigint unsigned NOT NULL,
    `merchant_id`       bigint unsigned NOT NULL,
    `order_id`          bigint unsigned NOT NULL,
    `staff_id`          bigint unsigned NOT NULL,
    `staff_name`        varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
    `status`            tinyint unsigned DEFAULT '0',
    `capture_amount`    decimal(10, 2)                                   DEFAULT '0.00',
    `type`              tinyint unsigned DEFAULT '0',
    `order_serial`      bigint                                  NOT NULL DEFAULT '0',
    `payment_providers` varchar(1024) COLLATE utf8mb4_general_ci         DEFAULT '[]',
    `error`             longtext COLLATE utf8mb4_general_ci,
    `create_at`         datetime                                NOT NULL,
    `update_at`         datetime                                NOT NULL,
    PRIMARY KEY (`id`),
    INDEX                 `IX_capture_record_order_id` (`order_id`),
    INDEX                 `IX_capture_record_merchant_id_serial` (`merchant_id`,`serial`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
COMMIT;