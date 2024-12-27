BEGIN;
alter table `order_query`
    add `third_party_status` int unsigned NOT NULL DEFAULT '1';
COMMIT;

UPDATE order_query
SET third_party_status = COALESCE(JSON_EXTRACT(detail, '$.ThirdPartyExtraInfo.Status'), '1')
WHERE third_party_order_id != '';

