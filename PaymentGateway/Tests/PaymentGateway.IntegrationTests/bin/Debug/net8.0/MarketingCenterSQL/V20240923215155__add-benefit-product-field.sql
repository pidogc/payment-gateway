BEGIN;
ALTER TABLE `marketing_center_benefit_product`
    ADD COLUMN `platform_id` VARCHAR(36) NOT NULL;
COMMIT;