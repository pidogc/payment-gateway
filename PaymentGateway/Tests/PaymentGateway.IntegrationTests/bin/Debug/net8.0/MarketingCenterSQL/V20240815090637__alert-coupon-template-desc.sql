BEGIN;
alter table marketing_center_coupon_template
    modify `desc` varchar(2048) default '' null;
COMMIT;