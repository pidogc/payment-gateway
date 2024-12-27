BEGIN;
alter table `working_shift_record`
    add COLUMN `serial_start_at` DATETIME NOT NULL default current_timestamp;
COMMIT;