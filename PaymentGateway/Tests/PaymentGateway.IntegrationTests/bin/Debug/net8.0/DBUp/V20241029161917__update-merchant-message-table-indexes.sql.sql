BEGIN;

-- 删除原有的索引
DROP INDEX `idx_status_sender_source_action_type` ON `merchant_message`;

-- 创建包含 merchant_id 和 id 的新组合索引
CREATE INDEX `idx_is_delete_merchant_id_id_status_sender_source_action_type`
    ON `merchant_message` (`is_delete`, `merchant_id`, `id`, `status`, `sender_source`, `action_type`);

COMMIT;