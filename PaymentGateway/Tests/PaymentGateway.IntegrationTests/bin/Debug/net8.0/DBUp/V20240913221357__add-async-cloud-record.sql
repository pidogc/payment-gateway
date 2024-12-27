BEGIN;
DROP TABLE IF EXISTS `async_cloud_record`;
CREATE TABLE `async_cloud_record`
(
    `id`          bigint NOT NULL,
    `merchant_id` bigint NOT NULL,
    `entity_id`   bigint NOT NULL,
    `type`        tinyint(4) NOT NULL default '0',
    `create_at`   datetime(6) NOT NULL,
    `update_at`   datetime(6) NOT NULL,
    PRIMARY KEY (`id`),
    index         `idx_merchant_id_entity_id_type` (`merchant_id`,`entity_id`,`type`)
) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
COMMIT;


