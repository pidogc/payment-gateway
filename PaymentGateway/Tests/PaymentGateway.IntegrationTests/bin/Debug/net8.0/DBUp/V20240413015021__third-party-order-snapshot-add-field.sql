BEGIN;
alter table `third_party_order_query_change_snapshot`
    add `waiting_to_kitchen` longtext NOT NULL;
COMMIT;