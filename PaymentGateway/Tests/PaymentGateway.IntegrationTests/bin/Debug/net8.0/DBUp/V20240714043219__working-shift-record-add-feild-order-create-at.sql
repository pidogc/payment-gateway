BEGIN;
alter table `working_shift_record`
    add COLUMN `order_create_at` DATETIME NOT NULL default current_timestamp;
COMMIT;

             