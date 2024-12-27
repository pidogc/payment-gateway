BEGIN;
alter table order_query drop order_update_at;

alter table order_query
    add order_update_at datetime not null default current_timestamp;

create index order_query_order_update_at_index
    on order_query (order_update_at);
COMMIT;