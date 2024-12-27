BEGIN;
alter table `marketing_center_member_config` add `card_img` varchar(255) not null default "";
COMMIT;