CREATE INDEX idx_merchant_order_id ON order_snapshot (merchant_id, order_id, id DESC);

CREATE INDEX idx_is_delete ON order_snapshot (is_delete);

CREATE INDEX idx_delete_template_merchant ON setting_values (is_delete, template_enum, merchant_id);
