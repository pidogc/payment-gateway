BEGIN;
ALTER TABLE `terminal`
    ADD COLUMN `provider_id` bigint(20) DEFAULT 0;
COMMIT;