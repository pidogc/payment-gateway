BEGIN;
ALTER TABLE `merchant_payment`
    ADD COLUMN `solution_type` int (11) unsigned NOT NULL DEFAULT 0;
COMMIT;