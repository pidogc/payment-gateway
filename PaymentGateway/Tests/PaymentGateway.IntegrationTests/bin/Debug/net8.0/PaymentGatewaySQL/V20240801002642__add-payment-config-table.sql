DROP TABLE IF EXISTS `payment_config`;
DROP TABLE IF EXISTS `payment_gateway_payment_config`;
CREATE TABLE `payment_gateway_payment_config`
(
    `id`                      VARCHAR(36)  NOT NULL,
    `create_at`               DATETIME     NULL,
    `update_at`               DATETIME     NULL,
    `subject_id`              VARCHAR(36)  NOT NULL,
    `subject_name`            VARCHAR(20)  NOT NULL,
    `app_id`                  VARCHAR(128) NOT NULL,
    `app_secret`              VARCHAR(128) NOT NULL,
    `location_id`             VARCHAR(128) NOT NULL,
    `payment_provider_key`    VARCHAR(255) NOT NULL,
    `payment_provider_secret` VARCHAR(255) NOT NULL DEFAULT '',
    `is_delete`               BIT                   DEFAULT b'0',
    PRIMARY KEY (`id`),
    UNIQUE INDEX `IX_AppId_AppSecret` (`app_id`, `app_secret`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_general_ci;