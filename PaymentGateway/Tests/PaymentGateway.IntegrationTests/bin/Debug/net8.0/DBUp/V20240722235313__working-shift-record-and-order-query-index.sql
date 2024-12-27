DROP INDEX idx_wsr_company_and_merchant_ids ON working_shift_record;

CREATE INDEX idx_wsr_id_merchant_and_company ON working_shift_record (id, merchant_id, company_id);

CREATE INDEX idx_order_query_merchant_company_start_at ON order_query (merchant_id, company_id, start_at);
