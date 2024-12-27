BEGIN;
alter table `working_shift`
    add COLUMN `sort` int NOT NULL DEFAULT '0';
COMMIT;