BEGIN;
alter table `payment`
    add `has_captured` bit(1) not null default b'0';
COMMIT;