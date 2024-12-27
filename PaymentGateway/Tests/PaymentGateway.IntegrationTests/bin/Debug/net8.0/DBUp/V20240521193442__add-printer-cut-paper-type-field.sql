BEGIN;
alter table `printer`
    add COLUMN `print_item_type` int unsigned NOT NULL default '0';
COMMIT;