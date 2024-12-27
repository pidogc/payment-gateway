BEGIN;
alter table `pub_to_third_party_webhook_callback_record`
    add COLUMN `merchant_id` bigint NOT NULL default '0',
    add COLUMN `company_id` bigint NOT NULL default '0';
COMMIT;