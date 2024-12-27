BEGIN;
CREATE INDEX idx_payment_event_is_delete ON payment_event (is_delete);
CREATE INDEX idx_daily_report_is_delete ON daily_report (is_delete);
COMMIT;