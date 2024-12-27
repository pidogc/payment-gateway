BEGIN;
ALTER TABLE `payment_gateway_payment_config`
    ADD COLUMN `solution_type` int (11) unsigned NOT NULL DEFAULT 0;
COMMIT;