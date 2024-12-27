BEGIN;
ALTER TABLE merchant_staff_attendance_record
    ADD COLUMN `description` text NULL AFTER `break_total_time`,
    ADD COLUMN `is_delete` bit(1) NOT NULL DEFAULT b'0' AFTER `description`;

ALTER TABLE `merchant_staff_break_record`
    ADD COLUMN `is_delete` bit(1) NOT NULL DEFAULT b'0' AFTER `end_time`;

CREATE INDEX idx_attendance_record_id ON merchant_staff_break_record (attendance_record_id);
COMMIT;