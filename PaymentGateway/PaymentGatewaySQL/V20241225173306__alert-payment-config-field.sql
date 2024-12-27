BEGIN;
ALTER TABLE `payment_gateway_payment_config`
    MODIFY COLUMN `payment_provider_key` text,
    MODIFY COLUMN `payment_provider_secret` text;
COMMIT;