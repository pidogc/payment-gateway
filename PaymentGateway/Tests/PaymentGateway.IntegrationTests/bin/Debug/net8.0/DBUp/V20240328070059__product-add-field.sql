BEGIN;
alter table `product`
    add stock_status tinyint unsigned default 0;
COMMIT;