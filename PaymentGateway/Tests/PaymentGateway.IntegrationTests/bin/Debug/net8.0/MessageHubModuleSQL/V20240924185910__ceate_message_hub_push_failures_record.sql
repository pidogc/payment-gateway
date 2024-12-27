DROP TABLE IF EXISTS `message_hub_push_failures_record`;
CREATE TABLE `message_hub_push_failures_record`
(
    `id`             varchar(36) NOT NULL,
    `platform_id`    varchar(36) NOT NULL,
    `associated_id`  varchar(36) NOT NULL,
    `api_type`       tinyint unsigned NOT NULL DEFAULT '0',
    `failure_reason` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
    `create_at`      datetime(6) NOT NULL,
    `update_at`      datetime(6) NOT NULL,
    PRIMARY KEY (`id`, `associated_id`, `platform_id`),
    KEY              `idx_platform_id_associated_id_api_type` (`platform_id`,`associated_id`,`api_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;