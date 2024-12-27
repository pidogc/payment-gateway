BEGIN;
ALTER TABLE `marketing_center_points_promotion_template`
    ADD COLUMN `platform_id` varchar(32) NOT NULL DEFAULT '',
    ADD COLUMN `consuming` decimal(12, 2) NOT NULL DEFAULT 0.00,
    ADD COLUMN `status` tinyint unsigned NOT NULL DEFAULT 1,
DROP
COLUMN `rule`,
    ADD INDEX idx_platform_id_is_delete (`platform_id`, `is_delete`),
    ADD INDEX idx_platform_id_type_is_delete (`platform_id`, `type`, `is_delete`);

DROP INDEX idx_points_promotion_template_id_type ON marketing_center_points_promotion_template;

COMMIT;