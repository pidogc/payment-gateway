CREATE INDEX idx_wsr_ids ON working_shift_record (merchant_id, company_id, working_shift_id, serial, serial_start_at);
CREATE INDEX idx_wsr_company_and_merchant_ids ON working_shift_record (id, company_id, merchant_id);
CREATE INDEX idx_wsr_serial_start_at_ids ON working_shift_record (merchant_id, company_id, serial_start_at);