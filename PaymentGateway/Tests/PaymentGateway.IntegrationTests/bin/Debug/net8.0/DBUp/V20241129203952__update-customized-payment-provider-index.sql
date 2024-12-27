BEGIN;
-- 移除原有的索引
ALTER TABLE `customized_payment_provider` DROP INDEX `customized_payment_provider_merchant_id_status_index`;

-- 创建新的联合索引
CREATE INDEX `customized_payment_provider_merchant_solution_type_index`
    ON `customized_payment_provider` (`is_delete`, `merchant_id`, `solution_type`, `type`, `provider`, `status`);
COMMIT;