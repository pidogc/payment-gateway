BEGIN;
CREATE INDEX idx_order_query_mstds_table ON order_query (merchant_id, start_at, table_id, is_delete, serial);
CREATE INDEX idx_order_query_merchant_id_delete_company_id ON order_query (merchant_id, start_at, company_id, is_delete);
CREATE INDEX idx_order_query_merchant_id_delete_company_id_order_id ON order_query (merchant_id, source_type, company_id, status, is_delete);
CREATE INDEX idx_order_query_merchant_id_third_party_order_id ON order_query (merchant_id, third_party_order_id, is_delete);
COMMIT;