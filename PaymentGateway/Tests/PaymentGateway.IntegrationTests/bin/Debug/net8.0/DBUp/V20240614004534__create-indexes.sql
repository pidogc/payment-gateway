CREATE INDEX idx_wsr_merchant_company_type_id ON working_shift_record (merchant_id, company_id, type);

CREATE INDEX idx_cp_category_product_company_merchant ON category_product (category_id, product_id, company_id, merchant_id);

CREATE INDEX idx_category_product_pid_cid_mid ON category_product (product_id, company_id, merchant_id);

CREATE INDEX idx_opa_is_delete_order_id ON order_price_adjustment (is_delete, order_id);

CREATE INDEX idx_localization_assoc_type_id ON localization (associated_type, associated_id);

CREATE INDEX idx_localization_associated_merchant_company ON localization (associated_id, merchant_id, company_id);

CREATE INDEX idx_localization_main ON localization (merchant_id, company_id, associated_type);

CREATE INDEX idx_drawer_record_update_merchant ON drawer_record (update_at, merchant_id);

CREATE INDEX idx_product_cid_mid ON product (company_id, merchant_id, is_delete, type);

CREATE INDEX idx_address_delete_associated_type ON address (is_delete, associated_id, address_type);

CREATE INDEX idx_address_main ON address (is_delete, address_hash, associated_id);

CREATE INDEX idx_event_store_main ON event_store (correlation_id, sync_count);

CREATE INDEX idx_customer_main ON customer (is_delete, phone, company_id);

CREATE INDEX idx_merchant_staff_main ON merchant_staff (is_delete, merchant_id, company_id);

CREATE INDEX idx_order_item_modifier_main ON order_item_modifier (is_delete, order_id);



