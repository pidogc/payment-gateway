BEGIN;
    ALTER TABLE `merchant_staff` MODIFY pin VARCHAR (24);
COMMIT;