BEGIN;
alter table `printer`
    ADD COLUMN `extra_details` text NOT NULL;
COMMIT;