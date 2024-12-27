BEGIN;
create index idx_third_party_oid_mid_cid
    on third_party_order_query_change_snapshot (id, company_id, merchant_id);

CREATE INDEX idx_oq_oid_mid_id ON order_query (order_id, merchant_id);

COMMIT;