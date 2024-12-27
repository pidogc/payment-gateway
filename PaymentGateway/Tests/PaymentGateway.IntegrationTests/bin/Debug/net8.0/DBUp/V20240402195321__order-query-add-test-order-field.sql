BEGIN;
alter table `order_query`
    add `env` bit(1) default b'0' not null;
COMMIT;