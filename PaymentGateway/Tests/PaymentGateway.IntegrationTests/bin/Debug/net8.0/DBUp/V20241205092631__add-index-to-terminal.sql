-- 创建复合索引
CREATE INDEX `idx_merchant_provider_is_delete`
    ON `terminal` (`merchant_id`, `provider_id`, `is_delete`) USING BTREE;
