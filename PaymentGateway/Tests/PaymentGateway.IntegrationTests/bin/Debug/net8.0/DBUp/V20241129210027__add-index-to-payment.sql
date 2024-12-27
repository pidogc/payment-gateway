BEGIN;
ALTER TABLE `payment`
    ADD INDEX `IX_payment_is_delete_merchant_status`(`is_delete`, `merchant_id`, `status`) USING BTREE;
COMMIT;