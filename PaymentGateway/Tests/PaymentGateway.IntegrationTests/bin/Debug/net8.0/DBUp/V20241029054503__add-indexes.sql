BEGIN;
drop index idx_oq_oid_mid_id on order_query;
CREATE INDEX idx_oq_oid_mid_id_id ON order_query (order_id, merchant_id, id desc );
COMMIT;