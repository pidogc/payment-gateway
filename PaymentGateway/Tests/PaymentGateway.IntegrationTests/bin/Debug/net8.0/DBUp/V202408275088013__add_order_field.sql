BEGIN;
ALTER TABLE `order`
    ADD COLUMN `is_push` bit(1) NOT NULL DEFAULT b'0' AFTER `member_id`;
COMMIT;