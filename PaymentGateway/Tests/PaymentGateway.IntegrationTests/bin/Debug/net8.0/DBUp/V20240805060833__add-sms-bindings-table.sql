-- ----------------------------
-- Table structure for sms_bindings
-- ----------------------------
BEGIN;
DROP TABLE IF EXISTS `sms_bindings`;
CREATE TABLE sms_bindings
(
    `id`         bigint       NOT NULL,
    company_id   bigint       NOT NULL DEFAULT '0',
    merchant_id  bigint       NOT NULL DEFAULT '0',
    `app_id`     VARCHAR(255) NOT NULL,
    `app_secret` VARCHAR(255) NOT NULL,
    type         int unsigned NOT NULL DEFAULT '0',
    create_at    DATETIME(6) NOT NULL,
    update_at    DATETIME(6) NOT NULL,
    PRIMARY KEY (id),
    INDEX        idx_merchant_company_type (merchant_id, company_id, `type`),
    INDEX        idx_app_id_secret (app_id, app_secret)
) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
COMMIT;