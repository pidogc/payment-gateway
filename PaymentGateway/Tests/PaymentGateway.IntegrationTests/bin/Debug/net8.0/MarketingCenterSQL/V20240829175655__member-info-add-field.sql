BEGIN;
ALTER TABLE `marketing_center_member_info`
    ADD COLUMN `member_card` varchar(255) NOT NULL DEFAULT '' AFTER `member_id`,
    ADD COLUMN `extra_info` VARCHAR(1024) NOT NULL DEFAULT '';

ALTER TABLE `marketing_center_member_info`
    ADD INDEX `idx_member_card`(`member_card`);
COMMIT;