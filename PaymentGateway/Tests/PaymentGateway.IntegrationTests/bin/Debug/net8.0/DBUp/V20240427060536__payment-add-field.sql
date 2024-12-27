BEGIN;
alter table `payment`
    add COLUMN `other_tips_amount` decimal(10, 2) default 0.00;

alter table `payment`
    add COLUMN `cash_tips_amount` decimal(10, 2) default 0.00;
COMMIT;