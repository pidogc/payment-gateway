BEGIN;
CREATE INDEX idx_oq_mid_status_pm_st_isdel ON order_query (merchant_id, status, payment_status, source_type, is_delete);
COMMIT;