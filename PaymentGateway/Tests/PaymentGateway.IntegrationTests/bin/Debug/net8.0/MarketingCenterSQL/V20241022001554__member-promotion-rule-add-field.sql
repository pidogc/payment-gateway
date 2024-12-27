BEGIN;
alter table marketing_center_member_promo_rule
    add sort int default 0 not null;
COMMIT;