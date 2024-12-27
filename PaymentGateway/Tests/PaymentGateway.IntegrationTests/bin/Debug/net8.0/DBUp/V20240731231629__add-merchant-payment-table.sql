DROP TABLE IF EXISTS `merchant_payment`;
CREATE TABLE `merchant_payment`
(
    `id`          BIGINT(20)       NOT NULL,
    `merchant_id` BIGINT(20)  NOT NULL,
    `name`        VARCHAR(255) NOT NULL,
    `key`         VARCHAR(255) NOT NULL,
    `secret`      VARCHAR(255) NOT NULL,
    `domain`      VARCHAR(255) NOT NULL,
    `status`      TINYINT UNSIGNED NULL,
    `is_delete`   BIT DEFAULT b'0',
    `sort`        INT DEFAULT 0,
    `create_at`   DATETIME NULL,
    `update_at`   DATETIME NULL,
    PRIMARY KEY (`id`),
    INDEX         `IX_MerchantId_Status_IsDelete` (`merchant_id`, `status`, `is_delete`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_general_ci;
