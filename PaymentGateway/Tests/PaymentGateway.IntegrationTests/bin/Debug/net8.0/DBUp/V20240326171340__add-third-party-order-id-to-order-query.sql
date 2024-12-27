BEGIN;
alter table `order_query`
    add `pickup_time` datetime(6) NOT NULL DEFAULT '0001-01-01 00:00:00.000000',
    add `delivery_time` datetime(6) NOT NULL DEFAULT '0001-01-01 00:00:00.000000';
COMMIT;