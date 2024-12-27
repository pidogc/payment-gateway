BEGIN;
ALTER TABLE `merchant`
    MODIFY COLUMN `type` tinyint UNSIGNED NOT NULL DEFAULT 0 AFTER `update_report_at`;
COMMIT;
