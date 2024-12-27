BEGIN;
alter table customized_payment_provider drop column web_hook_secret;

alter table customized_payment_provider drop column web_hook_id;

alter table customized_payment_provider change web_hook_url domain varchar(255) default '' not null;

ALTER TABLE `customized_payment_provider` ADD COLUMN `solution_type` int (11) unsigned NOT NULL DEFAULT 0;
COMMIT;