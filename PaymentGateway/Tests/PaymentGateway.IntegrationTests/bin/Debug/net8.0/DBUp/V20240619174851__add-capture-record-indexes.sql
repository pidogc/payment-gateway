CREATE INDEX idx_is_delete ON capture_record (is_delete);

CREATE INDEX idx_id_merchant_order_id_delete ON order_snapshot (merchant_id, order_id, id DESC, is_delete);

CREATE INDEX idx_merchant_order_id_delete ON order_snapshot (merchant_id, order_id, is_delete);

CREATE INDEX idx_merchant_status_time_order_delete ON capture_record (merchant_id, create_at DESC, order_serial DESC, status, is_delete);

CREATE INDEX idx_merchant_status_delete ON capture_record (merchant_id, status, is_delete);
