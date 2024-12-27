DROP TABLE IF EXISTS subscription_report;

CREATE TABLE subscription_report
(
    id                 BIGINT(20) UNSIGNED NOT NULL,
    merchant_id        BIGINT(20) UNSIGNED NOT NULL DEFAULT '0',
    company_id         BIGINT(20) UNSIGNED NOT NULL DEFAULT '0',
    account_id         BIGINT(20) UNSIGNED NOT NULL DEFAULT '0',
    email              VARCHAR(64) NOT NULL,
    subscription_types VARCHAR(32) NOT NULL,
    `is_delete`        bit(1)      NOT NULL DEFAULT b'0',
    create_at          DATETIME    NOT NULL,
    update_at          DATETIME    NOT NULL,
    PRIMARY KEY (id),
    INDEX              idx_id_merchant_id_company_id_account_id_email (id, merchant_id, company_id,account_id, email)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
