DROP TABLE IF EXISTS `report_collection`;
CREATE TABLE `report_collection`
(
    `id`                   bigint NOT NULL,
    `numeric_date`         bigint NOT NULL DEFAULT '0',
    `day_of_year`          bigint NOT NULL DEFAULT '0',
    `merchant_id`          bigint NOT NULL DEFAULT '0',
    `company_id`           bigint NOT NULL DEFAULT '0',
    `create_at`            datetime(6) NOT NULL,
    `update_at`            datetime(6) NOT NULL,
    `is_delete`            bit(1) NOT NULL DEFAULT b'0',
    `closing_report`       longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
    `total_report`         longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
    `void_order_report`    longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
    `product_sales_report` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
    `report_header`        longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
    PRIMARY KEY (`id`) USING BTREE,
    KEY                    `IX_id_merchant_id_company_id_numeric_date` (`id`,`merchant_id`, `company_id`, `numeric_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;