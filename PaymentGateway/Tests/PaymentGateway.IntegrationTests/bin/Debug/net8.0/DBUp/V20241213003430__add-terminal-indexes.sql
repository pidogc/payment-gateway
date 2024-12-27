BEGIN;
CREATE INDEX idx_delete_terminal_merchant_id ON terminal (is_delete, terminal_id, merchant_id);
COMMIT;