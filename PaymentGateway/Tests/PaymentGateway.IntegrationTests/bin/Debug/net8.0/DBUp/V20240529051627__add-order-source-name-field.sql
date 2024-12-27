BEGIN;
alter table `order_query`
    add `source_name` varchar(255) not null default '' comment '来源名称';
COMMIT;