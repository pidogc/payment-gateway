BEGIN;
ALTER TABLE `payment`
    ADD INDEX `IX_payment_is_delete_merchant_id_is_push`(`merchant_id`, `is_delete`, `is_push`) USING BTREE;
COMMIT;