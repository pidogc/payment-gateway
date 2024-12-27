BEGIN;

alter table `order`
    add `member_id` varchar(50) NOT NULL default "";
COMMIT;