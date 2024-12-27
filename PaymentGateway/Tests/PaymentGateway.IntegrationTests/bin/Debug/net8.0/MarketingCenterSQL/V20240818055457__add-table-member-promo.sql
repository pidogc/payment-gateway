BEGIN;

DROP TABLE IF EXISTS `marketing_center_member_promo_exclusion_coupon`;
CREATE TABLE marketing_center_member_promo_exclusion_coupon
(
    id                    VARCHAR(36) NOT NULL,
    platform_id           VARCHAR(36) NOT NULL,
    promotion_id          VARCHAR(36) NOT NULL,
    exclusion_coupon_type TINYINT UNSIGNED,
    create_at             DATETIME,
    update_at             DATETIME,
    PRIMARY KEY (id),
    INDEX                 idx_coupon_platform_promotion (platform_id, promotion_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

DROP TABLE IF EXISTS `marketing_center_member_promo_included_level`;
CREATE TABLE marketing_center_member_promo_included_level
(
    id           VARCHAR(36) NOT NULL,
    platform_id  VARCHAR(36) NOT NULL,
    promotion_id VARCHAR(36) NOT NULL,
    level        TINYINT UNSIGNED,
    create_at    DATETIME,
    update_at    DATETIME,
    PRIMARY KEY (id),
    INDEX        idx_level_platform_promotion (platform_id, promotion_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

DROP TABLE IF EXISTS `marketing_center_member_promo_exclusion_promo`;
CREATE TABLE marketing_center_member_promo_exclusion_promo
(
    id                   VARCHAR(36) NOT NULL,
    platform_id          VARCHAR(36) NOT NULL,
    promotion_id         VARCHAR(36) NOT NULL,
    exclusion_promo_type TINYINT UNSIGNED,
    create_at            DATETIME,
    update_at            DATETIME,
    PRIMARY KEY (id),
    INDEX                idx_platform_promotion (platform_id, promotion_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

DROP TABLE IF EXISTS `marketing_center_member_promo_rule`;
CREATE TABLE marketing_center_member_promo_rule
(
    id            VARCHAR(36) NOT NULL,
    platform_id   VARCHAR(36) NOT NULL,
    promotion_id  VARCHAR(36) NOT NULL,
    associated_id VARCHAR(36) NOT NULL,
    `type`        TINYINT UNSIGNED,
    `value`       DECIMAL(10, 2),
    create_at     DATETIME,
    update_at     DATETIME,
    PRIMARY KEY (id),
    INDEX         idx_rule_platform_promotion (platform_id, promotion_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

DROP TABLE IF EXISTS `marketing_center_member_promo_template`;
CREATE TABLE marketing_center_member_promo_template
(
    id              VARCHAR(36)  NOT NULL,
    platform_id     VARCHAR(36)  NOT NULL,
    name            VARCHAR(255) NOT NULL,
    img_url         VARCHAR(255),
    type            TINYINT UNSIGNED,
    status          TINYINT UNSIGNED,
    sort            INT(11),
    is_delete       BIT DEFAULT 0,
    term_begin_at   DATETIME,
    term_end_at     DATETIME,
    create_at       DATETIME,
    update_at       DATETIME,
    PRIMARY KEY (id),
    INDEX           idx_id_is_delete (id, is_delete),
    INDEX           idx_platform_is_delete (platform_id, is_delete),
    INDEX           idx_platform_status_is_delete (platform_id, status, is_delete)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

COMMIT;