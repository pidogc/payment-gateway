BEGIN;
ALTER TABLE `marketing_center_benefit` ADD COLUMN `threshold` DECIMAL(10, 2) DEFAULT 0;
COMMIT;