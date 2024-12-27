BEGIN;
CREATE INDEX idx_status_only ON marketing_center_user_coupon (status);
COMMIT;