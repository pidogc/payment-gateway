BEGIN;
alter table marketing_center_members add extra_info varchar(255) default '' not null;
COMMIT;