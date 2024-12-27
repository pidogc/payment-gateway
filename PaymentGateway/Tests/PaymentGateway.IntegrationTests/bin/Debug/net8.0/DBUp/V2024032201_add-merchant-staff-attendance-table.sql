-- ----------------------------
-- Table structure for merchant_staff_attendance_record
-- ----------------------------
DROP TABLE IF EXISTS `merchant_staff_attendance_record`;
CREATE TABLE `merchant_staff_attendance_record` (
                                                    `id` bigint(20) NOT NULL,
                                                    `company_id` bigint(20) NOT NULL,
                                                    `merchant_id` bigint(20) NOT NULL,
                                                    `merchant_staff_id` bigint(20) NOT NULL,
                                                    `check_in` datetime(6) NULL,
                                                    `check_out` datetime(6) NULL,
                                                    `duration_time` time(6) NULL,
                                                    `work_total_time` time(6) NULL,
                                                    `break_total_time` time(6) NULL,
                                                    `create_at` datetime(6) NOT NULL,
                                                    `update_at` datetime(6) NOT NULL,
                                                    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for merchant_staff_break_record
-- ----------------------------
DROP TABLE IF EXISTS `merchant_staff_break_record`;
CREATE TABLE `merchant_staff_break_record` (
                                               `id` bigint(20) NOT NULL,
                                               `company_id` bigint(20) NOT NULL,
                                               `merchant_id` bigint(20) NOT NULL,
                                               `merchant_staff_id` bigint(20) NOT NULL,
                                               `attendance_record_id` bigint(20) NOT NULL,                                                
                                               `start_time` datetime(6) NULL,
                                               `end_time` datetime(6) NULL,
                                               `create_at` datetime(6) NOT NULL,
                                               `update_at` datetime(6) NOT NULL,
                                               PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


BEGIN;
alter table `merchant_staff`
    add `is_need_check_in` bit(1) NOT NULL DEFAULT b'0',
    add `attendance_status` tinyint(3) unsigned NOT NULL DEFAULT '0';
COMMIT;
