BEGIN;
alter table `order`
    add staff_name varchar(255) default '' not null;
COMMIT;