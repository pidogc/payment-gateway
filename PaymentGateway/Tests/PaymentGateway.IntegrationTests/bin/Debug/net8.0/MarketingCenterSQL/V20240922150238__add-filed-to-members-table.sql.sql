BEGIN;
ALTER TABLE `marketing_center_members`
    ADD `guest_account_identifier` VARCHAR(36) NOT NULL DEFAULT '' COMMENT '游客账号标识',
ADD `registration_state` tinyint unsigned NOT NULL DEFAULT 1 COMMENT '注册状态, 默认已注册',
ADD INDEX `idx_guest_account_identifier` (`guest_account_identifier`), -- 为游客账号标识添加索引
ADD INDEX `idx_registration_state` (`registration_state`); -- 为注册状态添加索引
COMMIT;