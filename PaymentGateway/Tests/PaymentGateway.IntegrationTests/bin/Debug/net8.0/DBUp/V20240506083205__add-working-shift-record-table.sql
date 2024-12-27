-- ----------------------------
-- Table structure for working_shift_record
-- ----------------------------
DROP TABLE IF EXISTS `working_shift_record`;
CREATE TABLE working_shift_record
(
    `id`               bigint      NOT NULL,
    company_id         bigint      NOT NULL DEFAULT '0',
    merchant_id        bigint      NOT NULL DEFAULT '0',
    staff_id           bigint      NOT NULL DEFAULT '0',
    serial             bigint      NOT NULL DEFAULT '0',
    working_shift_id   bigint      NOT NULL DEFAULT '0',
    numeric_date_time  bigint      NOT NULL DEFAULT '0',
    working_shift_name VARCHAR(50) NOT NULL DEFAULT "",
    `type`             tinyint unsigned NOT NULL,
    report             longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
    start_at           DATETIME(6) NOT NULL,
    end_at             DATETIME(6) NOT NULL,
    create_at          DATETIME(6) NOT NULL,
    update_at          DATETIME(6) NOT NULL,
    PRIMARY KEY (id),
    INDEX              idx_merchant_company_staff (merchant_id, company_id, staff_id)
) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;

-- ----------------------------
-- Table structure for working_shift
-- ----------------------------
DROP TABLE IF EXISTS `working_shift`;
CREATE TABLE working_shift
(
    `id`        bigint       NOT NULL,
    company_id  bigint       NOT NULL DEFAULT '0',
    merchant_id bigint       NOT NULL DEFAULT '0',
    `name`      VARCHAR(50)  NOT NULL DEFAULT "",
    `desc`        VARCHAR(255) NOT NULL DEFAULT "",
    `is_delete`   bit(1)       NOT NULL DEFAULT b'0',
    create_at   DATETIME(6) NOT NULL,
    update_at   DATETIME(6) NOT NULL,
    PRIMARY KEY (id),
    INDEX       idx_merchant_company (id, merchant_id, company_id)
) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;