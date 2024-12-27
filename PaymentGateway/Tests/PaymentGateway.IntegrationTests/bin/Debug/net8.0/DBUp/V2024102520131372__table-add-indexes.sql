CREATE INDEX idx_report_collection_is_delete_numeric_date ON report_collection (is_delete, numeric_date, merchant_id, company_id);

CREATE INDEX idx_id_is_delete ON report_collection (id, is_delete);