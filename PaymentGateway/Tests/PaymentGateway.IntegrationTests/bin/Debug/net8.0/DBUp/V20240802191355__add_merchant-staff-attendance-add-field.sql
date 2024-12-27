BEGIN;
ALTER TABLE `merchant_staff_attendance_record`
    ADD COLUMN `numeric_date` bigint NOT NULL AFTER `merchant_id`;


CREATE INDEX idx_filtering_index ON merchant_staff_attendance_record (is_delete, merchant_id, company_id, check_in, check_out);
CREATE INDEX idx_staff_merchant_date ON merchant_staff_attendance_record (merchant_staff_id, merchant_id, numeric_date, record_type, is_delete);
COMMIT;