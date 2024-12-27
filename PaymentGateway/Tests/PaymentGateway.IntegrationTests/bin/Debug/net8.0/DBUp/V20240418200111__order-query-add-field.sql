BEGIN;
alter table `order_query`
    add `has_all_payments_tipped` bit(1) NOT NULL DEFAULT b'0';

create index order_query__index_has_tipped__payment_status_status
    on order_query (status, payment_status, has_all_payments_tipped);
COMMIT;