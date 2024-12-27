BEGIN;
alter table `waiting_send_kitchen`
    add `product_id` bigint not null default 0,
    add `status` tinyint unsigned not null default 0,
    add `remark` text not null,
    ADD INDEX idx_product_id (`product_id`);
COMMIT;