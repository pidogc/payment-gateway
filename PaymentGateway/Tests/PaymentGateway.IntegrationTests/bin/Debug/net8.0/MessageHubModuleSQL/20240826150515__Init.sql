SET NAMES utf8mb4;
SET
FOREIGN_KEY_CHECKS = 0;

DROP TABLE IF EXISTS `message_hub_api_record`;
CREATE TABLE `message_hub_api_record`  (
   `id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '唯一ID',
   `platform_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '平台ID',
   `api_type` tinyint UNSIGNED NOT NULL DEFAULT 0,
   `request_params` text NOT NULL COMMENT '请求参数',
   `create_at` datetime NOT NULL COMMENT '创建时间',
   `update_at` datetime NOT NULL COMMENT '更新时间',
   PRIMARY KEY (`id`),
   INDEX `idx_platform_id_api_type`(`platform_id`, `api_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;