DROP INDEX idx_wsr_serial_start_at_ids ON working_shift_record;

CREATE INDEX idx_wsr_start_at_end_at ON working_shift_record (start_at, end_at, merchant_id, company_id);

DROP INDEX idx_wsr_ids ON working_shift_record;

CREATE INDEX idx_wsr_serial_working_shift_id_merchant_id_company_id ON working_shift_record (serial, working_shift_id, merchant_id, company_id);

