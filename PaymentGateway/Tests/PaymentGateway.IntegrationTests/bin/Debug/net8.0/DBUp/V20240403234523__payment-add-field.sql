BEGIN;
alter table `payment`
    add `refund_status` tinyint unsigned not null default 0;
COMMIT;