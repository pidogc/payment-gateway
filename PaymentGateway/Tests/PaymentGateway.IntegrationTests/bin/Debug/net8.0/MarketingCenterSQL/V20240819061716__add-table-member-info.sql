BEGIN;
DROP TABLE IF EXISTS `marketing_center_member_info`;
CREATE TABLE marketing_center_member_info
(
    id                          VARCHAR(36) NOT NULL,
    platform_id                 VARCHAR(36) NOT NULL,
    member_id                   VARCHAR(36) NOT NULL,
    available_user_coupon_count INT(11) UNSIGNED,
    points                      DECIMAL(12, 2),
    growth                      DECIMAL(12, 2),
    member_level                TINYINT UNSIGNED NOT NULL,
    points_rate                 DECIMAL(5, 2),
    level_expiration_time       DATETIME,
    create_at                   DATETIME,
    update_at                   DATETIME,
    PRIMARY KEY (id),
    INDEX                       idx_member_platform (member_id, platform_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

alter table marketing_center_members drop column available_user_coupon_count;

alter table marketing_center_members drop column points;

alter table marketing_center_members drop column member_level;

alter table marketing_center_members drop column points_rate;

alter table marketing_center_members drop column level_expiration_time;

alter table marketing_center_members drop column growth;

alter table marketing_center_user_coupon add platform_id varchar(36) not null;

COMMIT;