BEGIN;
ALTER TABLE `marketing_center_member_promo_template`
    ADD COLUMN `desc` VARCHAR(255) NOT NULL DEFAULT "";
COMMIT;