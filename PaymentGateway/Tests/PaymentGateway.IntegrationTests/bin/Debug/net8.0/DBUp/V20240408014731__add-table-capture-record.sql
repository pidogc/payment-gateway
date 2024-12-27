DROP TABLE IF EXISTS capture_record;

CREATE TABLE capture_record
(
    id           BIGINT(20) UNSIGNED NOT NULL,
    serial       BIGINT(20) UNSIGNED NOT NULL,
    merchant_id  BIGINT(20) UNSIGNED NOT NULL,
    order_id     BIGINT(20) UNSIGNED NOT NULL,
    staff_id     BIGINT(20) UNSIGNED NOT NULL,
    staff_name   VARCHAR(255) NOT NULL,
    order_detail LONGTEXT,
    status       TINYINT UNSIGNED DEFAULT 0,
    error        LONGTEXT,
    create_at    DATETIME     NOT NULL,
    update_at    DATETIME     NOT NULL,
    PRIMARY KEY (id),
    INDEX        IX_capture_record_order_id (order_id),
    INDEX        IX_capture_record_merchant_id_serial (merchant_id, serial)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
