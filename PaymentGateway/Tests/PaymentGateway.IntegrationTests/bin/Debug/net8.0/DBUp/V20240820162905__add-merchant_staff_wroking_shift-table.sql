
DROP TABLE IF EXISTS `merchant_staff_working_shift`;
CREATE TABLE merchant_staff_working_shift
(
    `id` bigint NOT NULL,
    `company_id` bigint NOT NULL,
    `merchant_id` bigint NOT NULL,
    `merchant_staff_id` bigint NOT NULL,
    `weeks` varchar(50) NOT NULL,
    `working_shift` text NOT NULL,
    `create_at` datetime(6) NOT NULL,
    `update_at` datetime(6) NOT NULL,
    `is_delete` bit(1) NOT NULL DEFAULT b'0',
    PRIMARY KEY (`id`)
) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;


CREATE INDEX idx_company_merchant ON merchant_staff_working_shift (company_id, merchant_id);
CREATE INDEX idx_merchant_staff ON merchant_staff_working_shift (merchant_staff_id);


