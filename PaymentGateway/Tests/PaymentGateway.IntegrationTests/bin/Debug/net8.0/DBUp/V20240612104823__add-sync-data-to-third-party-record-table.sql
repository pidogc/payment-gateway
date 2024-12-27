DROP TABLE IF EXISTS `sync_data_to_third_party_record`;
CREATE TABLE `sync_data_to_third_party_record` (
                                                `id` bigint(20) NOT NULL,
                                                `company_id` bigint(20) NOT NULL,
                                                `merchant_id` bigint(20) NOT NULL,
                                                `type` int unsigned NOT NULL,
                                                `third_party_type` int unsigned NOT NULL,
                                                `status` int unsigned NOT NULL,
                                                `remark` varchar(255) NULL,
                                                `create_at` datetime(6) NOT NULL,
                                                `update_at` datetime(6) NOT NULL,
                                                PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

BEGIN;
alter table `pub_to_third_party_webhook_callback_record`
    add COLUMN `sync_data_record_id` bigint NULL;
COMMIT;