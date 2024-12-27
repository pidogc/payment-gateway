BEGIN;
DROP TABLE IF EXISTS `device_setting`;
CREATE TABLE `device_setting`
(
    `id`           bigint       NOT NULL,
    `company_id`   bigint       NOT NULL,
    `merchant_id`  bigint       NOT NULL,
    `device_id`    varchar(255) NOT NULL,
    `device_model` varchar(255) NOT NULL,
    `value`        mediumtext   NOT NULL,
    `create_at`    datetime(6)  NOT NULL,
    `update_at`    datetime(6)  NOT NULL,
    PRIMARY KEY (`id`),
    index          `idx_merchant_id_entity_id_type` (`company_id`,`merchant_id`,`device_id`)
) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
COMMIT;
