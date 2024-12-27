BEGIN;
ALTER TABLE `marketing_center_members`
    ADD INDEX idx_name (`name`);
COMMIT;
