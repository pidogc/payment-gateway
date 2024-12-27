BEGIN;
alter table `printer`
    add COLUMN `backup_printer_id` bigint(20) NOT NULL default 0;
COMMIT;