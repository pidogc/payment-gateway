BEGIN;
ALTER TABLE message_hub_push_failures_record
    ADD COLUMN `is_retry` bit(1) NOT NULL DEFAULT b'0' AFTER `failure_reason`;

ALTER TABLE message_hub_push_failures_record
DROP INDEX `idx_platform_id_associated_id_api_type`,
ADD INDEX `idx_platform_id_associated_id_api_type_is_retry`(`platform_id` ASC, `associated_id` ASC, `api_type` ASC, `is_retry`) USING BTREE;
COMMIT;