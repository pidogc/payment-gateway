DROP TABLE IF EXISTS `drawer_record`;
CREATE TABLE drawer_record
(
    `id`        bigint       NOT NULL,
    merchant_id bigint       NOT NULL,
    staff_id    bigint       NOT NULL,
    first_name  VARCHAR(255) NOT NULL DEFAULT '' COLLATE utf8mb4_general_ci,
    last_name   VARCHAR(255) NOT NULL DEFAULT '' COLLATE utf8mb4_general_ci,
    reason      VARCHAR(512) NOT NULL COLLATE utf8mb4_general_ci,
    cash_in     decimal(10, 2)        DEFAULT 0.00,
    cash_out    decimal(10, 2)        DEFAULT 0.00,
    create_at   DATETIME,
    update_at   DATETIME,
    update_by   bigint       NOT NULL,
    PRIMARY KEY (id),
    INDEX       idx_merchant_staff (merchant_id, staff_id)
) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
