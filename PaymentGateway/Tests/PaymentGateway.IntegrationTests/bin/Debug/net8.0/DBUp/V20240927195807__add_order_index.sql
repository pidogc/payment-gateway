BEGIN;
ALTER TABLE `order`
DROP INDEX `IX_order_is_delete_merchant_id`,
ADD INDEX `IX_order_is_delete_merchant_id`(`is_delete` ASC, `merchant_id` ASC, `is_push`) USING BTREE;
COMMIT;