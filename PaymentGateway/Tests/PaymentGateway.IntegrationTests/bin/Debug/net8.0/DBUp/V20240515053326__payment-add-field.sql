BEGIN;
alter table `payment`
    add COLUMN `cust_name` varchar(255) NOT NULL default '';
COMMIT;