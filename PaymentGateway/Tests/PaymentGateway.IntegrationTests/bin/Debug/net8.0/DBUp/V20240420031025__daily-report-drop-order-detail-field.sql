BEGIN;
alter table `daily_report`
    drop COLUMN `orders_detail_report` ;
COMMIT;