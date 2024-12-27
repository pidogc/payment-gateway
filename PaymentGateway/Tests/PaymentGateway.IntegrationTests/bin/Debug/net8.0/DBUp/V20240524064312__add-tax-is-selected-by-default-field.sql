BEGIN;
alter table `tax`
    add COLUMN `is_selected_by_default` bit(1) NOT NULL DEFAULT b'0';
COMMIT;