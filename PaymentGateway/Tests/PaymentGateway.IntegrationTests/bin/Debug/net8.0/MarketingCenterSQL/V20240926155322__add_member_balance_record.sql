DROP TABLE IF EXISTS `marketing_center_member_balance_record`;
CREATE TABLE `marketing_center_member_balance_record`
(
    id             VARCHAR(36) NOT NULL,
    platform_id    VARCHAR(36) NOT NULL,
    member_id      VARCHAR(36) NOT NULL,
    value          DECIMAL(10, 2) NULL,
    mode           TINYINT UNSIGNED NOT NULL,
    source_type    TINYINT UNSIGNED NOT NULL,
    source_id      VARCHAR(36) NOT NULL,
    type           TINYINT UNSIGNED NOT NULL,
    promotion_type TINYINT UNSIGNED NOT NULL,
    promotion_id   VARCHAR(36) NOT NULL,
    create_at      datetime(6) NOT NULL,
    update_at      datetime(6) NOT NULL,
    PRIMARY KEY (id),
    INDEX          idx_platform_member_id_mode (platform_id, member_id, mode),
    INDEX          idx_platform_promotion_id (platform_id, promotion_id),
    INDEX          idx_platform_source_id (platform_id, source_id)
)