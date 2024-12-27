BEGIN;
ALTER TABLE `customized_payment_provider`
    ADD COLUMN `details` varchar(1024) DEFAULT '';
COMMIT;