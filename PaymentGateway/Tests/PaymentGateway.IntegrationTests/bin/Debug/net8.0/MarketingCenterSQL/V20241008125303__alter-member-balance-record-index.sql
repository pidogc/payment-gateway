BEGIN;

DROP INDEX idx_platform_source_id ON marketing_center_member_balance_record;
CREATE INDEX idx_platform_source_id_source_type ON marketing_center_member_balance_record (platform_id, source_id, source_type);

COMMIT;