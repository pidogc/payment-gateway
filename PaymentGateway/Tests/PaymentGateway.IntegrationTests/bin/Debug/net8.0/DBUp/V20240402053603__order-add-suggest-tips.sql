BEGIN;
alter table `order`
    add `suggest_tips` decimal(12, 2) default 0.00;
COMMIT;