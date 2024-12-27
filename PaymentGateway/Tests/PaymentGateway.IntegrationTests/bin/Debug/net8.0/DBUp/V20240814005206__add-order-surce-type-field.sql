BEGIN;
ALTER TABLE `order`
    ADD COLUMN `source_type` int unsigned NOT NULL DEFAULT '0',
    ADD COLUMN `source_name` varchar(255) not null default '';
COMMIT;