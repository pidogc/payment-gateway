BEGIN;
ALTER TABLE `marketing_center_member_info`
    ADD COLUMN `balance` DECIMAL(10, 2) DEFAULT 0;
COMMIT;