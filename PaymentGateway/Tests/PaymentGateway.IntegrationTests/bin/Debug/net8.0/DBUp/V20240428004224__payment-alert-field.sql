BEGIN;
alter table `payment`
    drop COLUMN `other_tips_amount`;

alter table `payment`
    add COLUMN `pay_before_tips_amount` decimal(10, 2) default 0.00;
COMMIT;