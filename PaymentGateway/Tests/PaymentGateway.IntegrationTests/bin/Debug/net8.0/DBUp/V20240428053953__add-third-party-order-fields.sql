BEGIN;
alter table `third_party_order_query_change_snapshot`
    add `receipt_printable` longtext NOT NULL;
COMMIT;