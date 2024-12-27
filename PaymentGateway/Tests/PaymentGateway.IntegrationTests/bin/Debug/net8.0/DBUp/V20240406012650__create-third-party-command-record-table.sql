
DROP TABLE IF EXISTS `pub_to_third_party_webhook_callback_record`;

CREATE TABLE `pub_to_third_party_webhook_callback_record` (
                           `id` bigint NOT NULL,
                           `request_url` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
                           `request_method` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
                           `request_body` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
                           `success` bit(1) NOT NULL ,
                           `response_status_code` int NOT NULL,
                           `response_body` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
                           `create_at` datetime(6) NOT NULL,
                           `update_at` datetime(6) NOT NULL,
                           PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
