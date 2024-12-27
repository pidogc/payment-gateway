BEGIN;

DROP TABLE IF EXISTS marketing_center_member_level_benefit;
CREATE TABLE marketing_center_member_level_benefit
(
    id          CHAR(36) NOT NULL,
    create_at   DATETIME NULL,
    update_at   DATETIME NULL,
    platform_id CHAR(36) NOT NULL,
    benefit_id  CHAR(36) NOT NULL,
    level       TINYINT UNSIGNED NOT NULL,
    PRIMARY KEY (id),
    INDEX       idx_platform_level (platform_id, level)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

DROP TABLE IF EXISTS marketing_center_member_benefit;
CREATE TABLE marketing_center_member_benefit
(
    id            CHAR(36) NOT NULL,
    create_at     DATETIME NULL,
    update_at     DATETIME NULL,
    platform_id   CHAR(36) NOT NULL,
    member_id     CHAR(36) NOT NULL,
    benefit_id    CHAR(36) NOT NULL,
    term_begin_at DATETIME NULL,
    term_end_at   DATETIME NULL,
    is_delete     BIT      NOT NULL DEFAULT 0,
    PRIMARY KEY (id),
    INDEX         idx_platform_member_isdelete (platform_id, member_id, is_delete)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

DROP TABLE IF EXISTS marketing_center_benefit_product;
CREATE TABLE marketing_center_benefit_product
(
    id                 CHAR(36) NOT NULL,
    create_at          DATETIME NULL,
    update_at          DATETIME NULL,
    member_benefits_id CHAR(36) NOT NULL,
    associated_id      CHAR(36) NOT NULL,
    term_begin_at      DATETIME NULL,
    term_end_at        DATETIME NULL,
    sort               INT UNSIGNED NULL,
    is_delete          BIT      NOT NULL DEFAULT 0,
    PRIMARY KEY (id),
    INDEX              idx_benefit_isdelete (member_benefits_id, is_delete)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

DROP TABLE IF EXISTS marketing_center_benefit;
CREATE TABLE marketing_center_benefit
(
    id           CHAR(36) NOT NULL,
    create_at    DATETIME NULL,
    update_at    DATETIME NULL,
    platform_id  CHAR(36) NOT NULL,
    name         VARCHAR(255) NULL,
    img_url      VARCHAR(255) NULL,
    redirect_url VARCHAR(512) NULL,
    rule         TINYINT UNSIGNED NULL,
    category     TINYINT UNSIGNED NULL,
    type         TINYINT UNSIGNED NULL,
    value        DECIMAL(10, 2) NULL,
    `desc`       VARCHAR(1024) NULL,
    is_delete    BIT      NOT NULL DEFAULT 0,
    PRIMARY KEY (id),
    INDEX        idx_platform_isdelete (platform_id, is_delete),
    INDEX        idx_id_platform_isdelete (id, platform_id, is_delete),
    INDEX        idx_id_isdelete (id, is_delete)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

COMMIT;