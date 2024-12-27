BEGIN;
DROP TABLE IF EXISTS `drawer`;
CREATE TABLE `drawer`
(
    `id`                    bigint(20) NOT NULL,
    `company_id`            bigint(20) NOT NULL,
    `merchant_id`           bigint(20) NOT NULL,
    `name`                  varchar(255) NOT NULL,
    `device_name`           varchar(255) NOT NULL,
    `connected_device_id`   bigint(20) NOT NULL,
    `connected_device_type` TINYINT UNSIGNED DEFAULT 0,
    `create_at`             datetime(6) NOT NULL,
    `update_at`             datetime(6) NOT NULL,
    `is_active`             bit(1)       NOT NULL DEFAULT b'1',
    `is_delete`             bit(1)       NOT NULL DEFAULT b'0',
    PRIMARY KEY (`id`),
    KEY                     `IX_drawer_company_id_merchant_id` (`company_id`,`merchant_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `drawer_authorized_staff`;
CREATE TABLE `drawer_authorized_staff`
(
    `id`          bigint(20) NOT NULL,
    `drawer_id`   bigint(20) NOT NULL,
    `staff_id`    bigint(20) NOT NULL,
    `company_id`  bigint(20) NOT NULL,
    `merchant_id` bigint(20) NOT NULL,
    `create_at`   datetime(6) NOT NULL,
    `update_at`   datetime(6) NOT NULL,
    PRIMARY KEY (`id`),
    Key           `IX_drawer_id` ( `drawer_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

alter table `drawer_record`
    add `drawer_id` bigint(20) NOT NULL,
    add `automated_pattern` TINYINT UNSIGNED NOT NULL;

create index `IX_drawer_id` on `drawer_record` (`drawer_id`) USING BTREE;

COMMIT 