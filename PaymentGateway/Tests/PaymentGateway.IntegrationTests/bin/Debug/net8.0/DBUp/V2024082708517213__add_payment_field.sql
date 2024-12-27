BEGIN;
ALTER TABLE `payment`
    ADD COLUMN `is_push` bit(1) NOT NULL DEFAULT b'0' AFTER `pid`;
COMMIT;