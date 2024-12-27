BEGIN;
ALTER TABLE `merchant_staff`
    MODIFY COLUMN `pin_when_deleted` varchar(24) NOT NULL DEFAULT '' AFTER `is_delete`;
COMMIT;

