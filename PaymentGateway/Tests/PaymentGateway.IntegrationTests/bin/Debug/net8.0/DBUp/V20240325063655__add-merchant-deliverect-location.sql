DROP TABLE IF EXISTS `merchant_deliverect_location`;
CREATE TABLE `merchant_deliverect_location`
(
    `id`            bigint(20) NOT NULL,
    `company_id`    bigint(20) NOT NULL,
    `merchant_id`   bigint(20) NOT NULL,
    `account_id`    varchar(60)  NOT NULL,
    `location_id`   varchar(60)  NOT NULL,
    `location_name` varchar(255) NOT NULL,
    `status`        tinyint unsigned NOT NULL,
    `create_at`     datetime(6) NOT NULL,
    `update_at`     datetime(6) NOT NULL,
    PRIMARY KEY (`id`),
    index           `IX_merchant_id` ( `merchant_id`),
    index           `IX_location_id` ( `location_id`),
    index           `IX_account_id` ( `account_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;