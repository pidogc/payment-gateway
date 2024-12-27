alter table `order`
    add column `p_id` bigint(20) NOT NULL default 0;

alter table `order_query`
    add column `p_id` bigint(20) NOT NULL default 0;

alter table `order_item`
    add column `p_id` bigint(20) NOT NULL default 0;
