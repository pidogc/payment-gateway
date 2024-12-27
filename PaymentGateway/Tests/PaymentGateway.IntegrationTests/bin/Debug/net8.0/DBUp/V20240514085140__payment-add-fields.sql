BEGIN;
alter table `payment`
    add COLUMN `aid` varchar(255) NOT NULL default '';

alter table `payment`
    add COLUMN `app_label` varchar(255) NOT NULL default '';

alter table `payment`
    add COLUMN `exp` varchar(255) NOT NULL default '';

alter table `payment`
    add COLUMN `arqc` varchar(255) NOT NULL default '';

alter table `payment`
    add COLUMN `auth_code` varchar(255) NOT NULL default '';
COMMIT;