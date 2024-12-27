BEGIN;
-- 删除旧索引
DROP INDEX `idx_user_id` ON `message_center_wallet_relation`;
DROP INDEX `idx_serial_number_pass_type_identifier_device_library_identifier` ON `message_center_wallet_relation`;
DROP INDEX `idx_push_token_serial_number` ON `message_center_wallet_relation`;

-- 添加新的复合索引
CREATE INDEX `idx_user_associated_pass_device`
    ON `message_center_wallet_relation` (`user_id`, `associated_id`, `pass_type_identifier`,
                                         `device_library_identifier`);

CREATE INDEX `idx_user_push`
    ON `message_center_wallet_relation` (`user_id`, `push_token`);

CREATE INDEX `idx_user_associated_platform_related`
    ON `message_center_wallet_relation` (`user_id`, `associated_id`, `platform_type`, `related_type`);
COMMIT;