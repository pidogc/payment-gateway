BEGIN;
alter table `payment`
    add `last4` varchar(12) not null default '';
COMMIT;