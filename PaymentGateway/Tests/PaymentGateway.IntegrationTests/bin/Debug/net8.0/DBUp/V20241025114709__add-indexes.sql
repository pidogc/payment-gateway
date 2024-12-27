BEGIN;
CREATE INDEX idx_order_query_is_delete_p_id_merchant_id ON order_query (is_delete, p_id, merchant_id);

CREATE INDEX idx_account_is_delete_id ON account (is_delete, id);

CREATE INDEX idx_table_is_delete_region_company_merchant ON `table` (is_delete, region_id, company_id, merchant_id);

CREATE INDEX idx_order_receipt_del_type_status_and_id ON `order_receipt_printable` (is_delete, printer_type, status, company_id, merchant_id);

CREATE INDEX idx_event_store_sync_count ON `event_store` (sync_count);

CREATE INDEX idx_company_account_delete_company_owner ON `company_account` (is_delete, company_id, is_owner);

CREATE INDEX idx_merchant_staff_delete_merchant_owner ON `merchant_staff` (is_delete, merchant_id, is_owner);
COMMIT;