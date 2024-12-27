BEGIN;

alter table `marketing_center_members`
    add column `level_expiration_time` datetime not null default '1970-01-01 00:00:00';

alter table `marketing_center_members`
    add column `growth` decimal(12, 2) not null default 0.00;


alter table `marketing_center_member_config`
    add column `standard` decimal(12, 2) not null default 0.00;

alter table `marketing_center_member_config`
    add column `period_of_day` int(11) not null default 90;

COMMIT;