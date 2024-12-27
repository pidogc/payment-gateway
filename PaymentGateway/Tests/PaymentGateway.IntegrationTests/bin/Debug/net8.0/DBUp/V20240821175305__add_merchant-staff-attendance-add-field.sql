BEGIN;
ALTER TABLE `merchant_staff_attendance_record`
    ADD COLUMN `over_work_total_time` time(6) NULL AFTER `break_total_time`;
ALTER TABLE `merchant_staff_attendance_record`
    ADD COLUMN `is_auto_check_out` bit(1) NOT NULL DEFAULT b'0' AFTER `over_work_total_time`;
ALTER TABLE `merchant_staff_attendance_record`
    ADD COLUMN `working_shift_id` bigint NOT NULL AFTER `merchant_staff_id`;
COMMIT;