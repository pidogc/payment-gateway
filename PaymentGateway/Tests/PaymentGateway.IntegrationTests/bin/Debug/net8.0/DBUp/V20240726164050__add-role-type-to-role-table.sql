BEGIN;
alter table `role`
    add `role_type` tinyint(3) UNSIGNED not null default '3';

update role set role_type = 0 where name = "Boss" and is_default = 1;
update role set role_type = 1 where name = "Manager" and is_default = 1;
update role set role_type = 2 where name = "Server" and is_default = 1;
COMMIT;

