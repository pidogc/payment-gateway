BEGIN;
alter table marketing_center_member_config change `rate` `points_rate` decimal (5, 2) default 0.00 not null;

alter table marketing_center_member_config
    add product_discount_rate decimal(5, 2) default 0.00 not null;

alter table marketing_center_member_config
    add `mate` text null;

COMMIT;