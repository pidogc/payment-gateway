BEGIN;
create index IX_order_query_is_delete_merchant_id_order_id on order_query (is_delete, merchant_id, order_id);
create INDEX IX_order_query_is_delete_start_at ON order_query (is_delete, start_at);

create index IX_payment_is_delete_order_id on payment (is_delete, order_id);
create index IX_payment_is_delete_merchant_id_order_id_company_id on payment (is_delete, merchant_id, order_id, company_id);
create index IX_payment_is_delete_merchant_id_order_id on payment (is_delete, merchant_id, order_id);
create index IX_payment_is_delete_merchant_id_order_id_serial on payment (is_delete, merchant_id, serial);
create index IX_payment_is_delete_status_provider_order_id on payment (is_delete, order_id, status, provider);
create index IX_payment_is_delete_payment_intent_id on payment (is_delete, payment_intent_id);
create index IX_payment_is_delete_status_provider on payment (is_delete, status, provider);
create index IX_payment_is_delete_status_provider_order_id_combined on payment (is_delete, status, provider, company_id, merchant_id, order_id);

create index IX_order_is_delete_merchant_id on `order` (is_delete, merchant_id);
create index IX_order_item_is_delete_order_id_product_id on order_item (order_id, product_id, is_delete);

create INDEX IX_waiting_send_kitchen_combined ON waiting_send_kitchen (is_delete, send_kitchen_time, company_id, merchant_id, status);

COMMIT;