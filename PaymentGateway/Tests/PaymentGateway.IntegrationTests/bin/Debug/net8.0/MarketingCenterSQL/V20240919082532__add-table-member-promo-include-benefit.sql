BEGIN;
DROP TABLE IF EXISTS `marketing_center_member_promo_included_benefit`;
CREATE TABLE marketing_center_member_promo_included_benefit
(
    id           VARCHAR(36) NOT NULL,
    platform_id  VARCHAR(36) NOT NULL,
    promotion_id VARCHAR(36) NOT NULL,
    benefit_id   VARCHAR(36) NOT NULL,
    create_at    DATETIME,
    update_at    DATETIME,
    PRIMARY KEY (id),
    INDEX        idx_level_platform_promotion (platform_id, promotion_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

COMMIT;