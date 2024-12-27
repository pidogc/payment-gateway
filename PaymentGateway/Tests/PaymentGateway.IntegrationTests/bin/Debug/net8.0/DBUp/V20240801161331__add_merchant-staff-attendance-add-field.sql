BEGIN;
ALTER TABLE `merchant_staff_attendance_record`
    ADD COLUMN `record_type` tinyint UNSIGNED NOT NULL DEFAULT 0 AFTER `merchant_staff_id`;

CREATE INDEX idx_record_type ON merchant_staff_attendance_record (record_type);

COMMIT;