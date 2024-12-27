/*
 Navicat Premium Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 80029 (8.0.29)
 Source Host           : localhost:3306
 Source Schema         : easypos_cloud

 Target Server Type    : MySQL
 Target Server Version : 80029 (8.0.29)
 File Encoding         : 65001

 Date: 27/03/2024 22:56:01
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for account
-- ----------------------------
DROP TABLE IF EXISTS `account`;
CREATE TABLE `account` (
  `id` bigint NOT NULL,
  `first_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `last_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `email` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `salt` varchar(6) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `is_delete` bit(1) NOT NULL DEFAULT b'0',
  `CreateAt` datetime(6) NOT NULL,
  `UpdateAt` datetime(6) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `IX_account_email` (`email`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of account
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for address
-- ----------------------------
DROP TABLE IF EXISTS `address`;
CREATE TABLE `address` (
  `id` bigint NOT NULL,
  `associated_id` bigint NOT NULL,
  `address_hash` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `address_type` tinyint NOT NULL,
  `full_address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `address_img` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `country` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `room` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `city` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `state` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `line1` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `line2` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `lat` decimal(11,7) NOT NULL,
  `lng` decimal(11,7) NOT NULL,
  `postal_code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `is_delete` bit(1) NOT NULL DEFAULT b'0',
  `create_at` datetime(6) NOT NULL,
  `update_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of address
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for category
-- ----------------------------
DROP TABLE IF EXISTS `category`;
CREATE TABLE `category` (
  `id` bigint NOT NULL,
  `color` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '#FFFFFF',
  `desc` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `company_id` bigint NOT NULL,
  `merchant_id` bigint NOT NULL,
  `type` int unsigned NOT NULL DEFAULT '0',
  `sort` int NOT NULL DEFAULT '0',
  `is_delete` bit(1) NOT NULL DEFAULT b'0',
  `create_at` datetime(6) NOT NULL,
  `update_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `IX_category_company_id_merchant_id` (`company_id`,`merchant_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of category
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for category_product
-- ----------------------------
DROP TABLE IF EXISTS `category_product`;
CREATE TABLE `category_product` (
  `id` bigint NOT NULL,
  `company_id` bigint NOT NULL,
  `merchant_id` bigint NOT NULL,
  `category_id` bigint NOT NULL,
  `product_id` bigint NOT NULL,
  `sort` int NOT NULL DEFAULT '0',
  `create_at` datetime(6) NOT NULL,
  `update_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `IX_category_product_company_id_merchant_id_category_id` (`company_id`,`merchant_id`,`category_id`) USING BTREE,
  KEY `IX_category_product_company_id_merchant_id_product_id` (`company_id`,`merchant_id`,`product_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of category_product
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for company
-- ----------------------------
DROP TABLE IF EXISTS `company`;
CREATE TABLE `company` (
  `id` bigint NOT NULL,
  `email` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `desc` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `is_active` bit(1) NOT NULL DEFAULT b'1',
  `is_delete` bit(1) NOT NULL DEFAULT b'0',
  `create_at` datetime(6) NOT NULL,
  `update_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of company
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for company_account
-- ----------------------------
DROP TABLE IF EXISTS `company_account`;
CREATE TABLE `company_account` (
  `id` bigint NOT NULL,
  `company_id` bigint NOT NULL,
  `account_id` bigint NOT NULL,
  `is_active` bit(1) NOT NULL DEFAULT b'1',
  `is_owner` bit(1) NOT NULL DEFAULT b'0',
  `is_delete` bit(1) NOT NULL DEFAULT b'0',
  `create_at` datetime(6) NOT NULL,
  `update_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `IX_company_account_company_id_account_id` (`company_id`,`account_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of company_account
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for company_account_merchant
-- ----------------------------
DROP TABLE IF EXISTS `company_account_merchant`;
CREATE TABLE `company_account_merchant` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `company_account_id` bigint NOT NULL,
  `merchant_id` bigint NOT NULL,
  `create_at` datetime(6) NOT NULL,
  `update_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `IX_company_account_merchant_company_account_id_merchant_id` (`company_account_id`,`merchant_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of company_account_merchant
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for customer
-- ----------------------------
DROP TABLE IF EXISTS `customer`;
CREATE TABLE `customer` (
  `id` bigint NOT NULL,
  `company_id` bigint NOT NULL,
  `name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `phone` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `phone_hash` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `notes` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `is_delete` bit(1) NOT NULL DEFAULT b'0',
  `create_at` datetime(6) NOT NULL,
  `update_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `IX_customer_phone` (`phone`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of customer
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for customized_payment_provider
-- ----------------------------
DROP TABLE IF EXISTS `customized_payment_provider`;
CREATE TABLE `customized_payment_provider` (
  `id` bigint NOT NULL,
  `create_at` datetime(6) DEFAULT NULL,
  `update_at` datetime(6) DEFAULT NULL,
  `merchant_id` bigint NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `icon` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '',
  `desc` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '',
  `provider` tinyint unsigned DEFAULT NULL,
  `status` tinyint unsigned NOT NULL DEFAULT '0',
  `sort` int unsigned NOT NULL DEFAULT '0',
  `is_delete` bit(1) DEFAULT b'0',
  `type` tinyint unsigned NOT NULL,
  `client_id` varchar(255) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `secret` varchar(255) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `web_hook_secret` varchar(255) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `web_hook_id` varchar(255) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `web_hook_url` varchar(255) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `IX_customized_payment_provider_MerchantId` (`merchant_id`) USING BTREE,
  KEY `customized_payment_provider_merchant_id_status_index` (`merchant_id`,`status`,`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of customized_payment_provider
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for daily_report
-- ----------------------------
DROP TABLE IF EXISTS `daily_report`;
CREATE TABLE `daily_report` (
  `id` bigint NOT NULL,
  `numeric_date` bigint NOT NULL,
  `day_of_year` bigint NOT NULL,
  `merchant_id` bigint NOT NULL,
  `company_id` bigint NOT NULL,
  `create_at` datetime(6) NOT NULL,
  `update_at` datetime(6) NOT NULL,
  `overall_report` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `hour_of_day_report` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `order_type_report` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `operation_monitor_report` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `orders_detail_report` longtext COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `IX_id_company_id_merchant_id` (`id`,`company_id`,`merchant_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of daily_report
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for event_store
-- ----------------------------
DROP TABLE IF EXISTS `event_store`;
CREATE TABLE `event_store` (
  `id` bigint NOT NULL,
  `correlation_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `service_full_name` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `method_name` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `is_sync` tinyint(1) NOT NULL DEFAULT '0',
  `error_msg` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `create_at` datetime(6) NOT NULL,
  `update_at` datetime(6) NOT NULL,
  `header_ids` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of event_store
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for localization
-- ----------------------------
DROP TABLE IF EXISTS `localization`;
CREATE TABLE `localization` (
  `id` bigint NOT NULL,
  `company_id` bigint NOT NULL,
  `merchant_id` bigint NOT NULL,
  `associated_id` bigint NOT NULL,
  `associated_type` tinyint NOT NULL,
  `field` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `language_code` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `create_at` datetime(6) NOT NULL,
  `update_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `IX_localization_company_id_merchant_id_associated_id_associated~` (`company_id`,`merchant_id`,`associated_id`,`associated_type`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of localization
-- ----------------------------
BEGIN;
INSERT INTO `localization` (`id`, `company_id`, `merchant_id`, `associated_id`, `associated_type`, `field`, `language_code`, `value`, `create_at`, `update_at`) VALUES (8348143697789957, 0, 0, 8348143697724421, 5, 'name', 'en_US', 'Create Order', '2024-03-04 10:23:59.330225', '2024-03-04 10:23:59.330225');
INSERT INTO `localization` (`id`, `company_id`, `merchant_id`, `associated_id`, `associated_type`, `field`, `language_code`, `value`, `create_at`, `update_at`) VALUES (8348143697789958, 0, 0, 8348143697724421, 5, 'name', 'zh_CN', '開單', '2024-03-04 10:23:59.330225', '2024-03-04 10:23:59.330225');
INSERT INTO `localization` (`id`, `company_id`, `merchant_id`, `associated_id`, `associated_type`, `field`, `language_code`, `value`, `create_at`, `update_at`) VALUES (8348143697789960, 0, 0, 8348143697789959, 5, 'name', 'en_US', 'Dine-In', '2024-03-04 10:23:59.330225', '2024-03-04 10:23:59.330225');
INSERT INTO `localization` (`id`, `company_id`, `merchant_id`, `associated_id`, `associated_type`, `field`, `language_code`, `value`, `create_at`, `update_at`) VALUES (8348143697789961, 0, 0, 8348143697789959, 5, 'name', 'zh_CN', '堂食', '2024-03-04 10:23:59.330226', '2024-03-04 10:23:59.330226');
INSERT INTO `localization` (`id`, `company_id`, `merchant_id`, `associated_id`, `associated_type`, `field`, `language_code`, `value`, `create_at`, `update_at`) VALUES (8348143697789963, 0, 0, 8348143697789962, 5, 'name', 'en_US', 'To Go', '2024-03-04 10:23:59.330226', '2024-03-04 10:23:59.330226');
INSERT INTO `localization` (`id`, `company_id`, `merchant_id`, `associated_id`, `associated_type`, `field`, `language_code`, `value`, `create_at`, `update_at`) VALUES (8348143697789964, 0, 0, 8348143697789962, 5, 'name', 'zh_CN', '等取', '2024-03-04 10:23:59.330226', '2024-03-04 10:23:59.330226');
INSERT INTO `localization` (`id`, `company_id`, `merchant_id`, `associated_id`, `associated_type`, `field`, `language_code`, `value`, `create_at`, `update_at`) VALUES (8348143697789966, 0, 0, 8348143697789965, 5, 'name', 'en_US', 'Pick Up', '2024-03-04 10:23:59.330226', '2024-03-04 10:23:59.330226');
INSERT INTO `localization` (`id`, `company_id`, `merchant_id`, `associated_id`, `associated_type`, `field`, `language_code`, `value`, `create_at`, `update_at`) VALUES (8348143697789967, 0, 0, 8348143697789965, 5, 'name', 'zh_CN', '來取', '2024-03-04 10:23:59.330226', '2024-03-04 10:23:59.330226');
INSERT INTO `localization` (`id`, `company_id`, `merchant_id`, `associated_id`, `associated_type`, `field`, `language_code`, `value`, `create_at`, `update_at`) VALUES (8348143697789969, 0, 0, 8348143697789968, 5, 'name', 'en_US', 'Delivery', '2024-03-04 10:23:59.330226', '2024-03-04 10:23:59.330226');
INSERT INTO `localization` (`id`, `company_id`, `merchant_id`, `associated_id`, `associated_type`, `field`, `language_code`, `value`, `create_at`, `update_at`) VALUES (8348143697789970, 0, 0, 8348143697789968, 5, 'name', 'zh_CN', '外送', '2024-03-04 10:23:59.330227', '2024-03-04 10:23:59.330227');
INSERT INTO `localization` (`id`, `company_id`, `merchant_id`, `associated_id`, `associated_type`, `field`, `language_code`, `value`, `create_at`, `update_at`) VALUES (8348143697789972, 0, 0, 8348143697789971, 5, 'name', 'en_US', 'Edit Sent to Kitchen Item Preferences', '2024-03-04 10:23:59.330227', '2024-03-04 10:23:59.330227');
INSERT INTO `localization` (`id`, `company_id`, `merchant_id`, `associated_id`, `associated_type`, `field`, `language_code`, `value`, `create_at`, `update_at`) VALUES (8348143697789973, 0, 0, 8348143697789971, 5, 'name', 'zh_CN', '編輯已送廚菜偏好', '2024-03-04 10:23:59.330227', '2024-03-04 10:23:59.330227');
INSERT INTO `localization` (`id`, `company_id`, `merchant_id`, `associated_id`, `associated_type`, `field`, `language_code`, `value`, `create_at`, `update_at`) VALUES (8348143697789975, 0, 0, 8348143697789974, 5, 'name', 'en_US', 'Custom Item', '2024-03-04 10:23:59.330227', '2024-03-04 10:23:59.330227');
INSERT INTO `localization` (`id`, `company_id`, `merchant_id`, `associated_id`, `associated_type`, `field`, `language_code`, `value`, `create_at`, `update_at`) VALUES (8348143697789976, 0, 0, 8348143697789974, 5, 'name', 'zh_CN', '自定義菜', '2024-03-04 10:23:59.330227', '2024-03-04 10:23:59.330227');
INSERT INTO `localization` (`id`, `company_id`, `merchant_id`, `associated_id`, `associated_type`, `field`, `language_code`, `value`, `create_at`, `update_at`) VALUES (8348143697789978, 0, 0, 8348143697789977, 5, 'name', 'en_US', 'Resend Sent to Kitchen Item', '2024-03-04 10:23:59.330227', '2024-03-04 10:23:59.330227');
INSERT INTO `localization` (`id`, `company_id`, `merchant_id`, `associated_id`, `associated_type`, `field`, `language_code`, `value`, `create_at`, `update_at`) VALUES (8348143697789979, 0, 0, 8348143697789977, 5, 'name', 'zh_CN', '重送已送廚菜', '2024-03-04 10:23:59.330228', '2024-03-04 10:23:59.330228');
INSERT INTO `localization` (`id`, `company_id`, `merchant_id`, `associated_id`, `associated_type`, `field`, `language_code`, `value`, `create_at`, `update_at`) VALUES (8348143697789981, 0, 0, 8348143697789980, 5, 'name', 'en_US', 'Edit Order', '2024-03-04 10:23:59.330228', '2024-03-04 10:23:59.330228');
INSERT INTO `localization` (`id`, `company_id`, `merchant_id`, `associated_id`, `associated_type`, `field`, `language_code`, `value`, `create_at`, `update_at`) VALUES (8348143697789982, 0, 0, 8348143697789980, 5, 'name', 'zh_CN', '訂單編輯', '2024-03-04 10:23:59.330228', '2024-03-04 10:23:59.330228');
INSERT INTO `localization` (`id`, `company_id`, `merchant_id`, `associated_id`, `associated_type`, `field`, `language_code`, `value`, `create_at`, `update_at`) VALUES (8348143697789984, 0, 0, 8348143697789983, 5, 'name', 'en_US', 'Change Order Type', '2024-03-04 10:23:59.330228', '2024-03-04 10:23:59.330228');
INSERT INTO `localization` (`id`, `company_id`, `merchant_id`, `associated_id`, `associated_type`, `field`, `language_code`, `value`, `create_at`, `update_at`) VALUES (8348143697789985, 0, 0, 8348143697789983, 5, 'name', 'zh_CN', '改訂單類型', '2024-03-04 10:23:59.330228', '2024-03-04 10:23:59.330228');
INSERT INTO `localization` (`id`, `company_id`, `merchant_id`, `associated_id`, `associated_type`, `field`, `language_code`, `value`, `create_at`, `update_at`) VALUES (8348143697789987, 0, 0, 8348143697789986, 5, 'name', 'en_US', 'Change Table', '2024-03-04 10:23:59.330228', '2024-03-04 10:23:59.330228');
INSERT INTO `localization` (`id`, `company_id`, `merchant_id`, `associated_id`, `associated_type`, `field`, `language_code`, `value`, `create_at`, `update_at`) VALUES (8348143697789988, 0, 0, 8348143697789986, 5, 'name', 'zh_CN', '換桌', '2024-03-04 10:23:59.330229', '2024-03-04 10:23:59.330229');
INSERT INTO `localization` (`id`, `company_id`, `merchant_id`, `associated_id`, `associated_type`, `field`, `language_code`, `value`, `create_at`, `update_at`) VALUES (8348143697789990, 0, 0, 8348143697789989, 5, 'name', 'en_US', 'Change Waiter', '2024-03-04 10:23:59.330229', '2024-03-04 10:23:59.330229');
INSERT INTO `localization` (`id`, `company_id`, `merchant_id`, `associated_id`, `associated_type`, `field`, `language_code`, `value`, `create_at`, `update_at`) VALUES (8348143697789991, 0, 0, 8348143697789989, 5, 'name', 'zh_CN', '換服務員', '2024-03-04 10:23:59.330229', '2024-03-04 10:23:59.330229');
INSERT INTO `localization` (`id`, `company_id`, `merchant_id`, `associated_id`, `associated_type`, `field`, `language_code`, `value`, `create_at`, `update_at`) VALUES (8348143697789993, 0, 0, 8348143697789992, 5, 'name', 'en_US', 'Change Number of Guests', '2024-03-04 10:23:59.330229', '2024-03-04 10:23:59.330229');
INSERT INTO `localization` (`id`, `company_id`, `merchant_id`, `associated_id`, `associated_type`, `field`, `language_code`, `value`, `create_at`, `update_at`) VALUES (8348143697789994, 0, 0, 8348143697789992, 5, 'name', 'zh_CN', '改客人數量', '2024-03-04 10:23:59.330229', '2024-03-04 10:23:59.330229');
INSERT INTO `localization` (`id`, `company_id`, `merchant_id`, `associated_id`, `associated_type`, `field`, `language_code`, `value`, `create_at`, `update_at`) VALUES (8348143697789996, 0, 0, 8348143697789995, 5, 'name', 'en_US', 'Void', '2024-03-04 10:23:59.330229', '2024-03-04 10:23:59.330229');
INSERT INTO `localization` (`id`, `company_id`, `merchant_id`, `associated_id`, `associated_type`, `field`, `language_code`, `value`, `create_at`, `update_at`) VALUES (8348143697789997, 0, 0, 8348143697789995, 5, 'name', 'zh_CN', '刪單', '2024-03-04 10:23:59.330230', '2024-03-04 10:23:59.330230');
INSERT INTO `localization` (`id`, `company_id`, `merchant_id`, `associated_id`, `associated_type`, `field`, `language_code`, `value`, `create_at`, `update_at`) VALUES (8348143697789999, 0, 0, 8348143697789998, 5, 'name', 'en_US', 'Split Order', '2024-03-04 10:23:59.330231', '2024-03-04 10:23:59.330231');
INSERT INTO `localization` (`id`, `company_id`, `merchant_id`, `associated_id`, `associated_type`, `field`, `language_code`, `value`, `create_at`, `update_at`) VALUES (8348143697790000, 0, 0, 8348143697789998, 5, 'name', 'zh_CN', '分單', '2024-03-04 10:23:59.330231', '2024-03-04 10:23:59.330231');
INSERT INTO `localization` (`id`, `company_id`, `merchant_id`, `associated_id`, `associated_type`, `field`, `language_code`, `value`, `create_at`, `update_at`) VALUES (8348143697790002, 0, 0, 8348143697790001, 5, 'name', 'en_US', 'Merge Orders', '2024-03-04 10:23:59.330231', '2024-03-04 10:23:59.330231');
INSERT INTO `localization` (`id`, `company_id`, `merchant_id`, `associated_id`, `associated_type`, `field`, `language_code`, `value`, `create_at`, `update_at`) VALUES (8348143697790003, 0, 0, 8348143697790001, 5, 'name', 'zh_CN', '合單', '2024-03-04 10:23:59.330231', '2024-03-04 10:23:59.330231');
INSERT INTO `localization` (`id`, `company_id`, `merchant_id`, `associated_id`, `associated_type`, `field`, `language_code`, `value`, `create_at`, `update_at`) VALUES (8348143697790005, 0, 0, 8348143697790004, 5, 'name', 'en_US', 'Void Sent to Kitchen Item', '2024-03-04 10:23:59.330231', '2024-03-04 10:23:59.330231');
INSERT INTO `localization` (`id`, `company_id`, `merchant_id`, `associated_id`, `associated_type`, `field`, `language_code`, `value`, `create_at`, `update_at`) VALUES (8348143697790006, 0, 0, 8348143697790004, 5, 'name', 'zh_CN', '刪除已送厨菜', '2024-03-04 10:23:59.330232', '2024-03-04 10:23:59.330232');
INSERT INTO `localization` (`id`, `company_id`, `merchant_id`, `associated_id`, `associated_type`, `field`, `language_code`, `value`, `create_at`, `update_at`) VALUES (8348143697790008, 0, 0, 8348143697790007, 5, 'name', 'en_US', 'Move Item', '2024-03-04 10:23:59.330232', '2024-03-04 10:23:59.330232');
INSERT INTO `localization` (`id`, `company_id`, `merchant_id`, `associated_id`, `associated_type`, `field`, `language_code`, `value`, `create_at`, `update_at`) VALUES (8348143697790009, 0, 0, 8348143697790007, 5, 'name', 'zh_CN', '移菜', '2024-03-04 10:23:59.330232', '2024-03-04 10:23:59.330232');
INSERT INTO `localization` (`id`, `company_id`, `merchant_id`, `associated_id`, `associated_type`, `field`, `language_code`, `value`, `create_at`, `update_at`) VALUES (8348143697790011, 0, 0, 8348143697790010, 5, 'name', 'en_US', 'Item Price', '2024-03-04 10:23:59.330232', '2024-03-04 10:23:59.330232');
INSERT INTO `localization` (`id`, `company_id`, `merchant_id`, `associated_id`, `associated_type`, `field`, `language_code`, `value`, `create_at`, `update_at`) VALUES (8348143697790012, 0, 0, 8348143697790010, 5, 'name', 'zh_CN', '菜品改價', '2024-03-04 10:23:59.330232', '2024-03-04 10:23:59.330232');
INSERT INTO `localization` (`id`, `company_id`, `merchant_id`, `associated_id`, `associated_type`, `field`, `language_code`, `value`, `create_at`, `update_at`) VALUES (8348143697790014, 0, 0, 8348143697790013, 5, 'name', 'en_US', 'Charge', '2024-03-04 10:23:59.330232', '2024-03-04 10:23:59.330232');
INSERT INTO `localization` (`id`, `company_id`, `merchant_id`, `associated_id`, `associated_type`, `field`, `language_code`, `value`, `create_at`, `update_at`) VALUES (8348143697790015, 0, 0, 8348143697790013, 5, 'name', 'zh_CN', '加收', '2024-03-04 10:23:59.330233', '2024-03-04 10:23:59.330233');
INSERT INTO `localization` (`id`, `company_id`, `merchant_id`, `associated_id`, `associated_type`, `field`, `language_code`, `value`, `create_at`, `update_at`) VALUES (8348143697790017, 0, 0, 8348143697790016, 5, 'name', 'en_US', 'Discount', '2024-03-04 10:23:59.330233', '2024-03-04 10:23:59.330233');
INSERT INTO `localization` (`id`, `company_id`, `merchant_id`, `associated_id`, `associated_type`, `field`, `language_code`, `value`, `create_at`, `update_at`) VALUES (8348143697790018, 0, 0, 8348143697790016, 5, 'name', 'zh_CN', '折扣', '2024-03-04 10:23:59.330233', '2024-03-04 10:23:59.330233');
INSERT INTO `localization` (`id`, `company_id`, `merchant_id`, `associated_id`, `associated_type`, `field`, `language_code`, `value`, `create_at`, `update_at`) VALUES (8348143697790020, 0, 0, 8348143697790019, 5, 'name', 'en_US', 'Tax Exempt', '2024-03-04 10:23:59.330233', '2024-03-04 10:23:59.330233');
INSERT INTO `localization` (`id`, `company_id`, `merchant_id`, `associated_id`, `associated_type`, `field`, `language_code`, `value`, `create_at`, `update_at`) VALUES (8348143697790021, 0, 0, 8348143697790019, 5, 'name', 'zh_CN', '免稅', '2024-03-04 10:23:59.330233', '2024-03-04 10:23:59.330233');
INSERT INTO `localization` (`id`, `company_id`, `merchant_id`, `associated_id`, `associated_type`, `field`, `language_code`, `value`, `create_at`, `update_at`) VALUES (8348143697790023, 0, 0, 8348143697790022, 5, 'name', 'en_US', 'Add Tip Before Payment', '2024-03-04 10:23:59.330233', '2024-03-04 10:23:59.330233');
INSERT INTO `localization` (`id`, `company_id`, `merchant_id`, `associated_id`, `associated_type`, `field`, `language_code`, `value`, `create_at`, `update_at`) VALUES (8348143697790024, 0, 0, 8348143697790022, 5, 'name', 'zh_CN', '付款前加小費', '2024-03-04 10:23:59.330234', '2024-03-04 10:23:59.330234');
INSERT INTO `localization` (`id`, `company_id`, `merchant_id`, `associated_id`, `associated_type`, `field`, `language_code`, `value`, `create_at`, `update_at`) VALUES (8348143697790026, 0, 0, 8348143697790025, 5, 'name', 'en_US', 'Payment', '2024-03-04 10:23:59.330234', '2024-03-04 10:23:59.330234');
INSERT INTO `localization` (`id`, `company_id`, `merchant_id`, `associated_id`, `associated_type`, `field`, `language_code`, `value`, `create_at`, `update_at`) VALUES (8348143697790027, 0, 0, 8348143697790025, 5, 'name', 'zh_CN', '付款', '2024-03-04 10:23:59.330234', '2024-03-04 10:23:59.330234');
INSERT INTO `localization` (`id`, `company_id`, `merchant_id`, `associated_id`, `associated_type`, `field`, `language_code`, `value`, `create_at`, `update_at`) VALUES (8348143697790029, 0, 0, 8348143697790028, 5, 'name', 'en_US', 'Open Cash Drawer', '2024-03-04 10:23:59.330234', '2024-03-04 10:23:59.330234');
INSERT INTO `localization` (`id`, `company_id`, `merchant_id`, `associated_id`, `associated_type`, `field`, `language_code`, `value`, `create_at`, `update_at`) VALUES (8348143697790030, 0, 0, 8348143697790028, 5, 'name', 'zh_CN', '打開錢箱', '2024-03-04 10:23:59.330234', '2024-03-04 10:23:59.330234');
INSERT INTO `localization` (`id`, `company_id`, `merchant_id`, `associated_id`, `associated_type`, `field`, `language_code`, `value`, `create_at`, `update_at`) VALUES (8348143697790032, 0, 0, 8348143697790031, 5, 'name', 'en_US', 'Cash Payment', '2024-03-04 10:23:59.330234', '2024-03-04 10:23:59.330234');
INSERT INTO `localization` (`id`, `company_id`, `merchant_id`, `associated_id`, `associated_type`, `field`, `language_code`, `value`, `create_at`, `update_at`) VALUES (8348143697790033, 0, 0, 8348143697790031, 5, 'name', 'zh_CN', '現金支付', '2024-03-04 10:23:59.330234', '2024-03-04 10:23:59.330235');
INSERT INTO `localization` (`id`, `company_id`, `merchant_id`, `associated_id`, `associated_type`, `field`, `language_code`, `value`, `create_at`, `update_at`) VALUES (8348143697790035, 0, 0, 8348143697790034, 5, 'name', 'en_US', 'Credit Card/Digital Payment', '2024-03-04 10:23:59.330235', '2024-03-04 10:23:59.330235');
INSERT INTO `localization` (`id`, `company_id`, `merchant_id`, `associated_id`, `associated_type`, `field`, `language_code`, `value`, `create_at`, `update_at`) VALUES (8348143697790036, 0, 0, 8348143697790034, 5, 'name', 'zh_CN', '信用卡\\數字支付', '2024-03-04 10:23:59.330235', '2024-03-04 10:23:59.330235');
INSERT INTO `localization` (`id`, `company_id`, `merchant_id`, `associated_id`, `associated_type`, `field`, `language_code`, `value`, `create_at`, `update_at`) VALUES (8348143697790038, 0, 0, 8348143697790037, 5, 'name', 'en_US', 'Credit Card Payment with Tip', '2024-03-04 10:23:59.330235', '2024-03-04 10:23:59.330235');
INSERT INTO `localization` (`id`, `company_id`, `merchant_id`, `associated_id`, `associated_type`, `field`, `language_code`, `value`, `create_at`, `update_at`) VALUES (8348143697790039, 0, 0, 8348143697790037, 5, 'name', 'zh_CN', '信用卡加小費', '2024-03-04 10:23:59.330235', '2024-03-04 10:23:59.330235');
INSERT INTO `localization` (`id`, `company_id`, `merchant_id`, `associated_id`, `associated_type`, `field`, `language_code`, `value`, `create_at`, `update_at`) VALUES (8348143697790041, 0, 0, 8348143697790040, 5, 'name', 'en_US', 'Void Cash Payment', '2024-03-04 10:23:59.330235', '2024-03-04 10:23:59.330235');
INSERT INTO `localization` (`id`, `company_id`, `merchant_id`, `associated_id`, `associated_type`, `field`, `language_code`, `value`, `create_at`, `update_at`) VALUES (8348143697790042, 0, 0, 8348143697790040, 5, 'name', 'zh_CN', '取消現金付款', '2024-03-04 10:23:59.330235', '2024-03-04 10:23:59.330235');
INSERT INTO `localization` (`id`, `company_id`, `merchant_id`, `associated_id`, `associated_type`, `field`, `language_code`, `value`, `create_at`, `update_at`) VALUES (8348143697790044, 0, 0, 8348143697790043, 5, 'name', 'en_US', 'Void Credit Card Payment', '2024-03-04 10:23:59.330236', '2024-03-04 10:23:59.330236');
INSERT INTO `localization` (`id`, `company_id`, `merchant_id`, `associated_id`, `associated_type`, `field`, `language_code`, `value`, `create_at`, `update_at`) VALUES (8348143697790045, 0, 0, 8348143697790043, 5, 'name', 'zh_CN', '取消信用卡付款', '2024-03-04 10:23:59.330236', '2024-03-04 10:23:59.330236');
INSERT INTO `localization` (`id`, `company_id`, `merchant_id`, `associated_id`, `associated_type`, `field`, `language_code`, `value`, `create_at`, `update_at`) VALUES (8348143697790047, 0, 0, 8348143697790046, 5, 'name', 'en_US', 'Operations', '2024-03-04 10:23:59.330236', '2024-03-04 10:23:59.330236');
INSERT INTO `localization` (`id`, `company_id`, `merchant_id`, `associated_id`, `associated_type`, `field`, `language_code`, `value`, `create_at`, `update_at`) VALUES (8348143697790048, 0, 0, 8348143697790046, 5, 'name', 'zh_CN', '運營', '2024-03-04 10:23:59.330236', '2024-03-04 10:23:59.330236');
INSERT INTO `localization` (`id`, `company_id`, `merchant_id`, `associated_id`, `associated_type`, `field`, `language_code`, `value`, `create_at`, `update_at`) VALUES (8348143697790050, 0, 0, 8348143697790049, 5, 'name', 'en_US', 'Log Out', '2024-03-04 10:23:59.330236', '2024-03-04 10:23:59.330236');
INSERT INTO `localization` (`id`, `company_id`, `merchant_id`, `associated_id`, `associated_type`, `field`, `language_code`, `value`, `create_at`, `update_at`) VALUES (8348143697790051, 0, 0, 8348143697790049, 5, 'name', 'zh_CN', '退出登錄', '2024-03-04 10:23:59.330236', '2024-03-04 10:23:59.330237');
INSERT INTO `localization` (`id`, `company_id`, `merchant_id`, `associated_id`, `associated_type`, `field`, `language_code`, `value`, `create_at`, `update_at`) VALUES (8348143697790053, 0, 0, 8348143697790052, 5, 'name', 'en_US', 'Orders', '2024-03-04 10:23:59.330237', '2024-03-04 10:23:59.330237');
INSERT INTO `localization` (`id`, `company_id`, `merchant_id`, `associated_id`, `associated_type`, `field`, `language_code`, `value`, `create_at`, `update_at`) VALUES (8348143697790054, 0, 0, 8348143697790052, 5, 'name', 'zh_CN', '找單', '2024-03-04 10:23:59.330237', '2024-03-04 10:23:59.330237');
INSERT INTO `localization` (`id`, `company_id`, `merchant_id`, `associated_id`, `associated_type`, `field`, `language_code`, `value`, `create_at`, `update_at`) VALUES (8348143697790056, 0, 0, 8348143697790055, 5, 'name', 'en_US', 'Reprint Receipt', '2024-03-04 10:23:59.330237', '2024-03-04 10:23:59.330237');
INSERT INTO `localization` (`id`, `company_id`, `merchant_id`, `associated_id`, `associated_type`, `field`, `language_code`, `value`, `create_at`, `update_at`) VALUES (8348143697790057, 0, 0, 8348143697790055, 5, 'name', 'zh_CN', '重新打印收據', '2024-03-04 10:23:59.330237', '2024-03-04 10:23:59.330237');
INSERT INTO `localization` (`id`, `company_id`, `merchant_id`, `associated_id`, `associated_type`, `field`, `language_code`, `value`, `create_at`, `update_at`) VALUES (8348143697790059, 0, 0, 8348143697790058, 5, 'name', 'en_US', 'All Orders', '2024-03-04 10:23:59.330237', '2024-03-04 10:23:59.330237');
INSERT INTO `localization` (`id`, `company_id`, `merchant_id`, `associated_id`, `associated_type`, `field`, `language_code`, `value`, `create_at`, `update_at`) VALUES (8348143697790060, 0, 0, 8348143697790058, 5, 'name', 'zh_CN', '所有單', '2024-03-04 10:23:59.330237', '2024-03-04 10:23:59.330237');
INSERT INTO `localization` (`id`, `company_id`, `merchant_id`, `associated_id`, `associated_type`, `field`, `language_code`, `value`, `create_at`, `update_at`) VALUES (8348143697790062, 0, 0, 8348143697790061, 5, 'name', 'en_US', 'Show All Dishes', '2024-03-04 10:23:59.330238', '2024-03-04 10:23:59.330238');
INSERT INTO `localization` (`id`, `company_id`, `merchant_id`, `associated_id`, `associated_type`, `field`, `language_code`, `value`, `create_at`, `update_at`) VALUES (8348143697790063, 0, 0, 8348143697790061, 5, 'name', 'zh_CN', '顯示所有菜', '2024-03-04 10:23:59.330238', '2024-03-04 10:23:59.330238');
INSERT INTO `localization` (`id`, `company_id`, `merchant_id`, `associated_id`, `associated_type`, `field`, `language_code`, `value`, `create_at`, `update_at`) VALUES (8348143697790065, 0, 0, 8348143697790064, 5, 'name', 'en_US', 'View History Orders', '2024-03-04 10:23:59.330238', '2024-03-04 10:23:59.330238');
INSERT INTO `localization` (`id`, `company_id`, `merchant_id`, `associated_id`, `associated_type`, `field`, `language_code`, `value`, `create_at`, `update_at`) VALUES (8348143697790066, 0, 0, 8348143697790064, 5, 'name', 'zh_CN', '查看曆史訂單', '2024-03-04 10:23:59.330238', '2024-03-04 10:23:59.330238');
INSERT INTO `localization` (`id`, `company_id`, `merchant_id`, `associated_id`, `associated_type`, `field`, `language_code`, `value`, `create_at`, `update_at`) VALUES (8348143697790068, 0, 0, 8348143697790067, 5, 'name', 'en_US', 'Cash Reconciliation', '2024-03-04 10:23:59.330238', '2024-03-04 10:23:59.330238');
INSERT INTO `localization` (`id`, `company_id`, `merchant_id`, `associated_id`, `associated_type`, `field`, `language_code`, `value`, `create_at`, `update_at`) VALUES (8348143697790069, 0, 0, 8348143697790067, 5, 'name', 'zh_CN', '現金平賬', '2024-03-04 10:23:59.330238', '2024-03-04 10:23:59.330238');
INSERT INTO `localization` (`id`, `company_id`, `merchant_id`, `associated_id`, `associated_type`, `field`, `language_code`, `value`, `create_at`, `update_at`) VALUES (8348143697790071, 0, 0, 8348143697790070, 5, 'name', 'en_US', 'Credit Card Settlement', '2024-03-04 10:23:59.330239', '2024-03-04 10:23:59.330239');
INSERT INTO `localization` (`id`, `company_id`, `merchant_id`, `associated_id`, `associated_type`, `field`, `language_code`, `value`, `create_at`, `update_at`) VALUES (8348143697790072, 0, 0, 8348143697790070, 5, 'name', 'zh_CN', '信用卡結賬', '2024-03-04 10:23:59.330239', '2024-03-04 10:23:59.330239');
INSERT INTO `localization` (`id`, `company_id`, `merchant_id`, `associated_id`, `associated_type`, `field`, `language_code`, `value`, `create_at`, `update_at`) VALUES (8348143697790074, 0, 0, 8348143697790073, 5, 'name', 'en_US', 'Driver', '2024-03-04 10:23:59.330239', '2024-03-04 10:23:59.330239');
INSERT INTO `localization` (`id`, `company_id`, `merchant_id`, `associated_id`, `associated_type`, `field`, `language_code`, `value`, `create_at`, `update_at`) VALUES (8348143697790075, 0, 0, 8348143697790073, 5, 'name', 'zh_CN', '司機', '2024-03-04 10:23:59.330239', '2024-03-04 10:23:59.330239');
INSERT INTO `localization` (`id`, `company_id`, `merchant_id`, `associated_id`, `associated_type`, `field`, `language_code`, `value`, `create_at`, `update_at`) VALUES (8348143697790077, 0, 0, 8348143697790076, 5, 'name', 'en_US', 'POS Settings', '2024-03-04 10:23:59.330239', '2024-03-04 10:23:59.330239');
INSERT INTO `localization` (`id`, `company_id`, `merchant_id`, `associated_id`, `associated_type`, `field`, `language_code`, `value`, `create_at`, `update_at`) VALUES (8348143697790078, 0, 0, 8348143697790076, 5, 'name', 'zh_CN', '管理', '2024-03-04 10:23:59.330239', '2024-03-04 10:23:59.330239');
INSERT INTO `localization` (`id`, `company_id`, `merchant_id`, `associated_id`, `associated_type`, `field`, `language_code`, `value`, `create_at`, `update_at`) VALUES (8348143697790080, 0, 0, 8348143697790079, 5, 'name', 'en_US', 'Store Management', '2024-03-04 10:23:59.330239', '2024-03-04 10:23:59.330239');
INSERT INTO `localization` (`id`, `company_id`, `merchant_id`, `associated_id`, `associated_type`, `field`, `language_code`, `value`, `create_at`, `update_at`) VALUES (8348143697790081, 0, 0, 8348143697790079, 5, 'name', 'zh_CN', '店鋪管理', '2024-03-04 10:23:59.330240', '2024-03-04 10:23:59.330240');
INSERT INTO `localization` (`id`, `company_id`, `merchant_id`, `associated_id`, `associated_type`, `field`, `language_code`, `value`, `create_at`, `update_at`) VALUES (8348143697790083, 0, 0, 8348143697790082, 5, 'name', 'en_US', 'Menu Management', '2024-03-04 10:23:59.330240', '2024-03-04 10:23:59.330240');
INSERT INTO `localization` (`id`, `company_id`, `merchant_id`, `associated_id`, `associated_type`, `field`, `language_code`, `value`, `create_at`, `update_at`) VALUES (8348143697790084, 0, 0, 8348143697790082, 5, 'name', 'zh_CN', '菜單管理', '2024-03-04 10:23:59.330240', '2024-03-04 10:23:59.330240');
INSERT INTO `localization` (`id`, `company_id`, `merchant_id`, `associated_id`, `associated_type`, `field`, `language_code`, `value`, `create_at`, `update_at`) VALUES (8348143697790086, 0, 0, 8348143697790085, 5, 'name', 'en_US', 'Hardware Management', '2024-03-04 10:23:59.330240', '2024-03-04 10:23:59.330240');
INSERT INTO `localization` (`id`, `company_id`, `merchant_id`, `associated_id`, `associated_type`, `field`, `language_code`, `value`, `create_at`, `update_at`) VALUES (8348143697790087, 0, 0, 8348143697790085, 5, 'name', 'zh_CN', '硬件管理', '2024-03-04 10:23:59.330240', '2024-03-04 10:23:59.330240');
INSERT INTO `localization` (`id`, `company_id`, `merchant_id`, `associated_id`, `associated_type`, `field`, `language_code`, `value`, `create_at`, `update_at`) VALUES (8348143697790089, 0, 0, 8348143697790088, 5, 'name', 'en_US', 'Employee Management', '2024-03-04 10:23:59.330240', '2024-03-04 10:23:59.330240');
INSERT INTO `localization` (`id`, `company_id`, `merchant_id`, `associated_id`, `associated_type`, `field`, `language_code`, `value`, `create_at`, `update_at`) VALUES (8348143697790090, 0, 0, 8348143697790088, 5, 'name', 'zh_CN', '員工管理', '2024-03-04 10:23:59.330241', '2024-03-04 10:23:59.330241');
INSERT INTO `localization` (`id`, `company_id`, `merchant_id`, `associated_id`, `associated_type`, `field`, `language_code`, `value`, `create_at`, `update_at`) VALUES (8348143697790092, 0, 0, 8348143697790091, 5, 'name', 'en_US', 'Reports', '2024-03-04 10:23:59.330241', '2024-03-04 10:23:59.330241');
INSERT INTO `localization` (`id`, `company_id`, `merchant_id`, `associated_id`, `associated_type`, `field`, `language_code`, `value`, `create_at`, `update_at`) VALUES (8348143697790093, 0, 0, 8348143697790091, 5, 'name', 'zh_CN', '報表', '2024-03-04 10:23:59.330241', '2024-03-04 10:23:59.330241');
INSERT INTO `localization` (`id`, `company_id`, `merchant_id`, `associated_id`, `associated_type`, `field`, `language_code`, `value`, `create_at`, `update_at`) VALUES (8348143697790095, 0, 0, 8348143697790094, 5, 'name', 'en_US', 'Total Report', '2024-03-04 10:23:59.330241', '2024-03-04 10:23:59.330241');
INSERT INTO `localization` (`id`, `company_id`, `merchant_id`, `associated_id`, `associated_type`, `field`, `language_code`, `value`, `create_at`, `update_at`) VALUES (8348143697790096, 0, 0, 8348143697790094, 5, 'name', 'zh_CN', '總報表', '2024-03-04 10:23:59.330241', '2024-03-04 10:23:59.330241');
COMMIT;

-- ----------------------------
-- Table structure for menu
-- ----------------------------
DROP TABLE IF EXISTS `menu`;
CREATE TABLE `menu` (
  `id` bigint NOT NULL,
  `company_id` bigint NOT NULL,
  `merchant_id` bigint NOT NULL,
  `type` int unsigned NOT NULL DEFAULT '0',
  `is_delete` bit(1) NOT NULL DEFAULT b'0',
  `status` tinyint unsigned NOT NULL,
  `coefficient` decimal(4,2) NOT NULL,
  `sort` int NOT NULL DEFAULT '0',
  `desc` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `create_at` datetime(6) NOT NULL,
  `update_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `IX_menu_company_id_merchant_id` (`company_id`,`merchant_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of menu
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for menu_category
-- ----------------------------
DROP TABLE IF EXISTS `menu_category`;
CREATE TABLE `menu_category` (
  `id` bigint NOT NULL,
  `menu_id` bigint NOT NULL,
  `category_id` bigint NOT NULL,
  `sort` int NOT NULL DEFAULT '0',
  `create_at` datetime(6) NOT NULL,
  `update_at` datetime(6) NOT NULL,
  `merchant_id` bigint NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `IX_menu_category_menu_id` (`menu_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of menu_category
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for merchant
-- ----------------------------
DROP TABLE IF EXISTS `merchant`;
CREATE TABLE `merchant` (
  `id` bigint NOT NULL,
  `company_id` bigint NOT NULL,
  `stripe_location_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `img` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `short_name` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `desc` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `is_active` bit(1) NOT NULL DEFAULT b'0',
  `phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `create_at` datetime(6) NOT NULL,
  `update_at` datetime(6) NOT NULL,
  `timezone_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'America/Los_Angeles',
  `license_key` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `client_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `secret_key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `update_report_at` datetime(6) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `IX_merchant_company_id` (`company_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of merchant
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for merchant_staff
-- ----------------------------
DROP TABLE IF EXISTS `merchant_staff`;
CREATE TABLE `merchant_staff` (
  `id` bigint NOT NULL,
  `company_id` bigint NOT NULL,
  `merchant_id` bigint NOT NULL,
  `is_active` bit(1) NOT NULL DEFAULT b'1',
  `first_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `last_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `pin` varchar(4) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `is_delete` bit(1) NOT NULL DEFAULT b'0',
  `pin_when_deleted` varchar(4) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `create_at` datetime(6) NOT NULL,
  `update_at` datetime(6) NOT NULL,
  `phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `email` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `language_preference` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'en_US',
  `is_owner` bit(1) NOT NULL DEFAULT b'0',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of merchant_staff
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for merchant_staff_role
-- ----------------------------
DROP TABLE IF EXISTS `merchant_staff_role`;
CREATE TABLE `merchant_staff_role` (
  `id` bigint NOT NULL,
  `company_id` bigint NOT NULL,
  `merchant_id` bigint NOT NULL,
  `staff_id` bigint NOT NULL,
  `role_id` bigint NOT NULL,
  `create_at` datetime(6) NOT NULL,
  `update_at` datetime(6) NOT NULL,
  `is_delete` bit(1) NOT NULL DEFAULT b'0',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of merchant_staff_role
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for modifier_group
-- ----------------------------
DROP TABLE IF EXISTS `modifier_group`;
CREATE TABLE `modifier_group` (
  `id` bigint NOT NULL,
  `company_id` bigint NOT NULL,
  `merchant_id` bigint NOT NULL,
  `minimum_select` tinyint unsigned NOT NULL DEFAULT '0',
  `maximum_selection` tinyint unsigned NOT NULL DEFAULT '1',
  `maximum_repetition` tinyint unsigned NOT NULL DEFAULT '1',
  `sort` int unsigned NOT NULL DEFAULT '0',
  `desc` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `is_deleted` bit(1) NOT NULL DEFAULT b'0',
  `create_at` datetime(6) NOT NULL,
  `update_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `IX_modifier_group_company_id_merchant_id` (`company_id`,`merchant_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of modifier_group
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for modifier_product_binding
-- ----------------------------
DROP TABLE IF EXISTS `modifier_product_binding`;
CREATE TABLE `modifier_product_binding` (
  `id` bigint NOT NULL,
  `company_id` bigint NOT NULL,
  `merchant_id` bigint NOT NULL,
  `modifier_group_id` bigint NOT NULL,
  `product_id` bigint NOT NULL,
  `price` decimal(8,2) NOT NULL DEFAULT '0.00',
  `is_default_selection` bit(1) NOT NULL DEFAULT b'0',
  `sort` int NOT NULL DEFAULT '0',
  `create_at` datetime(6) NOT NULL,
  `update_at` datetime(6) NOT NULL,
  `is_delete` bit(1) NOT NULL DEFAULT b'0',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `IX_modifier_product_binding_company_id_merchant_id` (`company_id`,`merchant_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of modifier_product_binding
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for order
-- ----------------------------
DROP TABLE IF EXISTS `order`;
CREATE TABLE `order` (
  `id` bigint NOT NULL,
  `customer_id` bigint NOT NULL DEFAULT '0',
  `address_id` bigint NOT NULL DEFAULT '0',
  `region_id` bigint NOT NULL DEFAULT '0',
  `table_id` bigint NOT NULL DEFAULT '0',
  `table_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `guests` tinyint unsigned NOT NULL DEFAULT '0',
  `serial` int unsigned NOT NULL,
  `staff_id` bigint NOT NULL DEFAULT '0',
  `company_id` bigint NOT NULL,
  `merchant_id` bigint NOT NULL,
  `total_tips_amount` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total_amount` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total_tax_amount` decimal(12,2) NOT NULL DEFAULT '0.00',
  `sub_total_amount` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total_discount_amount` decimal(12,2) NOT NULL DEFAULT '0.00',
  `total_charge_amount` decimal(12,2) NOT NULL DEFAULT '0.00',
  `payment_status` tinyint unsigned NOT NULL,
  `type` tinyint unsigned NOT NULL,
  `status` tinyint unsigned NOT NULL,
  `send_status` tinyint unsigned NOT NULL,
  `notes` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `reason` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `is_printed` bit(1) NOT NULL DEFAULT b'0',
  `created_by` bigint NOT NULL,
  `canceled_at` datetime(6) NOT NULL,
  `canceled_by` bigint NOT NULL DEFAULT '0',
  `is_tax_free` bit(1) NOT NULL DEFAULT b'0',
  `is_delete` bit(1) NOT NULL DEFAULT b'0',
  `create_at` datetime(6) NOT NULL,
  `update_at` datetime(6) NOT NULL,
  `payments_total` decimal(12,2) NOT NULL DEFAULT '0.00',
  `payments_tips` decimal(12,2) NOT NULL DEFAULT '0.00',
  `payments_change` decimal(12,2) NOT NULL DEFAULT '0.00',
  `extra_info` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `row_version` bigint NOT NULL DEFAULT '0',
  `updated_by` bigint NOT NULL DEFAULT '0',
  `updated_by_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `void_reason` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `sub_total_before_discount_amount` decimal(12,2) NOT NULL DEFAULT '0.00',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `IX_order_company_id_merchant_id` (`company_id`,`merchant_id`) USING BTREE,
  KEY `IX_order_company_id_merchant_id_create_at` (`company_id`,`merchant_id`,`create_at`) USING BTREE,
  KEY `IX_order_customer_id` (`customer_id`) USING BTREE,
  KEY `IX_order_status` (`status`) USING BTREE,
  KEY `IX_order_type` (`type`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of order
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for order_condiment
-- ----------------------------
DROP TABLE IF EXISTS `order_condiment`;
CREATE TABLE `order_condiment` (
  `id` bigint NOT NULL,
  `order_id` bigint NOT NULL,
  `menu_id` bigint NOT NULL,
  `category_id` bigint NOT NULL,
  `product_id` bigint NOT NULL,
  `associated_id` bigint NOT NULL,
  `target` tinyint unsigned NOT NULL,
  `mode` tinyint unsigned NOT NULL,
  `localizations` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `action_localizations` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `notes` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `quantity` int unsigned NOT NULL DEFAULT '1',
  `price` decimal(12,2) NOT NULL DEFAULT '0.00',
  `coefficient` decimal(4,2) NOT NULL DEFAULT '1.00',
  `created_by` bigint NOT NULL,
  `canceled_by` bigint NOT NULL DEFAULT '0',
  `sort` int unsigned NOT NULL DEFAULT '0',
  `canceled_at` datetime(6) NOT NULL,
  `is_delete` bit(1) NOT NULL DEFAULT b'0',
  `create_at` datetime(6) NOT NULL,
  `update_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `IX_order_condiment_associated_id_target` (`associated_id`,`target`) USING BTREE,
  KEY `IX_order_condiment_order_id` (`order_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of order_condiment
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for order_customer_product
-- ----------------------------
DROP TABLE IF EXISTS `order_customer_product`;
CREATE TABLE `order_customer_product` (
  `id` bigint NOT NULL,
  `order_id` bigint NOT NULL,
  `json` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `create_at` datetime(6) NOT NULL,
  `update_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `IX_order_customer_product_order_id` (`order_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of order_customer_product
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for order_item
-- ----------------------------
DROP TABLE IF EXISTS `order_item`;
CREATE TABLE `order_item` (
  `id` bigint NOT NULL,
  `order_id` bigint NOT NULL,
  `menu_id` bigint NOT NULL DEFAULT '0',
  `category_id` bigint NOT NULL DEFAULT '0',
  `product_id` bigint NOT NULL,
  `localizations` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `quantity` int unsigned NOT NULL DEFAULT '0',
  `price` decimal(12,2) NOT NULL DEFAULT '0.00',
  `item_base_amount` decimal(12,2) NOT NULL DEFAULT '0.00',
  `item_with_adjustment_amount` decimal(12,2) NOT NULL DEFAULT '0.00',
  `item_amount` decimal(12,2) NOT NULL DEFAULT '0.00',
  `item_tax` decimal(12,2) NOT NULL DEFAULT '0.00',
  `type` tinyint unsigned NOT NULL,
  `mode` tinyint unsigned NOT NULL,
  `notes` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `sent_at` datetime(6) NOT NULL,
  `canceled_at` datetime(6) NOT NULL,
  `canceled_by` bigint NOT NULL DEFAULT '0',
  `has_underline` bit(1) NOT NULL DEFAULT b'0',
  `sort` int unsigned NOT NULL DEFAULT '0',
  `is_tax_free` bit(1) NOT NULL DEFAULT b'0',
  `is_delete` bit(1) NOT NULL DEFAULT b'0',
  `create_at` datetime(6) NOT NULL,
  `update_at` datetime(6) NOT NULL,
  `item_tips_amount` decimal(12,2) NOT NULL DEFAULT '0.00',
  `item_charge_amount` decimal(12,2) NOT NULL DEFAULT '0.00',
  `item_discount_amount` decimal(12,2) NOT NULL DEFAULT '0.00',
  `qty_sent_to_kitchen` int unsigned NOT NULL DEFAULT '0',
  `qty_void` int unsigned NOT NULL DEFAULT '0',
  `void_reason` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `wait_to_send` int NOT NULL DEFAULT '0',
  `sent_kitchen_time` datetime(6) NOT NULL DEFAULT '0001-01-01 00:00:00.000000',
  `sent_kitchen_printer_count` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `IX_order_item_order_id_product_id` (`order_id`,`product_id`) USING BTREE,
  KEY `IX_order_item_product_id` (`product_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of order_item
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for order_item_deletion_record
-- ----------------------------
DROP TABLE IF EXISTS `order_item_deletion_record`;
CREATE TABLE `order_item_deletion_record` (
  `id` bigint NOT NULL,
  `company_id` bigint NOT NULL,
  `merchant_id` bigint NOT NULL,
  `staff_id` bigint NOT NULL,
  `order_id` bigint NOT NULL,
  `order_item_id` bigint NOT NULL,
  `quantity` int unsigned NOT NULL DEFAULT '0',
  `void_qty` int unsigned NOT NULL DEFAULT '0',
  `reason` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `is_printed` bit(1) NOT NULL DEFAULT b'0',
  `create_at` datetime(6) DEFAULT NULL,
  `update_at` datetime(6) DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(6),
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_order_id` (`order_id`) USING BTREE,
  KEY `idx_order_item_id` (`order_item_id`) USING BTREE,
  KEY `idx_staff_id` (`staff_id`) USING BTREE,
  KEY `idx_company_id_merchant_id` (`company_id`,`merchant_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of order_item_deletion_record
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for order_item_modifier
-- ----------------------------
DROP TABLE IF EXISTS `order_item_modifier`;
CREATE TABLE `order_item_modifier` (
  `id` bigint NOT NULL,
  `order_id` bigint NOT NULL,
  `order_item_id` bigint NOT NULL,
  `modifier_id` bigint NOT NULL,
  `modifier_product_id` bigint NOT NULL,
  `localizations` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `modifier_localizations` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `ProductId` bigint NOT NULL,
  `quantity` int unsigned NOT NULL DEFAULT '0',
  `price` decimal(8,2) NOT NULL DEFAULT '0.00',
  `sort` int unsigned NOT NULL DEFAULT '0',
  `notes` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `canceled_at` datetime(6) NOT NULL,
  `canceled_by` bigint NOT NULL DEFAULT '0',
  `is_delete` bit(1) NOT NULL DEFAULT b'0',
  `create_at` datetime(6) NOT NULL,
  `update_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `IX_order_item_modifier_order_id_order_item_id` (`order_id`,`order_item_id`) USING BTREE,
  KEY `IX_order_item_modifier_order_item_id` (`order_item_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of order_item_modifier
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for order_price_adjustment
-- ----------------------------
DROP TABLE IF EXISTS `order_price_adjustment`;
CREATE TABLE `order_price_adjustment` (
  `id` bigint NOT NULL,
  `order_id` bigint NOT NULL,
  `Name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `is_tax_free` bit(1) NOT NULL DEFAULT b'0',
  `type` tinyint unsigned NOT NULL,
  `charge_category` tinyint unsigned NOT NULL,
  `associated_id` bigint NOT NULL,
  `target` tinyint unsigned NOT NULL,
  `charge_rule` tinyint unsigned NOT NULL,
  `value` decimal(12,2) NOT NULL DEFAULT '0.00',
  `created_by` bigint NOT NULL,
  `canceled_by` bigint NOT NULL DEFAULT '0',
  `canceled_at` datetime(6) NOT NULL,
  `is_delete` bit(1) NOT NULL DEFAULT b'0',
  `create_at` datetime(6) NOT NULL,
  `update_at` datetime(6) NOT NULL,
  `pattern` tinyint unsigned NOT NULL,
  `as_tips` bit(1) NOT NULL DEFAULT b'0',
  `pre_set_id` bigint NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `IX_order_price_adjustment_associated_id_target` (`associated_id`,`target`) USING BTREE,
  KEY `IX_order_price_adjustment_charge_category` (`charge_category`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of order_price_adjustment
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for order_query
-- ----------------------------
DROP TABLE IF EXISTS `order_query`;
CREATE TABLE `order_query` (
  `id` bigint NOT NULL,
  `start_at` datetime(6) NOT NULL,
  `company_id` bigint NOT NULL,
  `merchant_id` bigint NOT NULL,
  `order_id` bigint NOT NULL,
  `customer_id` bigint NOT NULL DEFAULT '0',
  `staff_id` bigint NOT NULL,
  `table_id` bigint NOT NULL DEFAULT '0',
  `created_by` bigint NOT NULL,
  `region_id` bigint NOT NULL DEFAULT '0',
  `serial` bigint NOT NULL,
  `hour_of_day` int NOT NULL,
  `status` tinyint unsigned NOT NULL,
  `type` tinyint unsigned NOT NULL,
  `send_status` tinyint unsigned NOT NULL,
  `payment_status` tinyint unsigned NOT NULL,
  `provider` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '[]',
  `has_discount` bit(1) NOT NULL DEFAULT b'0',
  `has_charge` bit(1) NOT NULL DEFAULT b'0',
  `has_refund` bit(1) NOT NULL DEFAULT b'0',
  `is_printed` bit(1) NOT NULL DEFAULT b'0',
  `is_delete` bit(1) NOT NULL DEFAULT b'0',
  `create_at` datetime(6) NOT NULL,
  `update_at` datetime(6) NOT NULL,
  `detail` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `row_version` bigint DEFAULT '0',
  `has_delete` bit(1) DEFAULT b'0',
  `provider_ids` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `third_party_order_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `source_type` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of order_query
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for order_query_snapshot
-- ----------------------------
DROP TABLE IF EXISTS `order_query_snapshot`;
CREATE TABLE `order_query_snapshot` (
  `id` bigint NOT NULL,
  `create_at` datetime(6) NOT NULL,
  `update_at` datetime(6) NOT NULL,
  `order_id` bigint NOT NULL,
  `header_ids` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `order_query` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `platform` tinyint unsigned DEFAULT '0',
  `cloud_server` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `IX_order_id` (`order_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of order_query_snapshot
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for order_snapshot
-- ----------------------------
DROP TABLE IF EXISTS `order_snapshot`;
CREATE TABLE `order_snapshot` (
  `id` bigint NOT NULL,
  `merchant_id` bigint NOT NULL,
  `order_id` bigint NOT NULL,
  `create_at` datetime(6) NOT NULL,
  `update_at` datetime(6) NOT NULL,
  `detail` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `IX_order_id_merchant_id` (`order_id`,`merchant_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of order_snapshot
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for order_tax
-- ----------------------------
DROP TABLE IF EXISTS `order_tax`;
CREATE TABLE `order_tax` (
  `id` bigint NOT NULL,
  `order_id` bigint NOT NULL,
  `order_item_id` bigint NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `tax_id` bigint NOT NULL,
  `is_percentage` bit(1) NOT NULL DEFAULT b'0',
  `value` decimal(8,3) NOT NULL DEFAULT '0.000',
  `amount` decimal(8,2) NOT NULL DEFAULT '0.00',
  `canceled_by` bigint NOT NULL DEFAULT '0',
  `canceled_at` datetime(6) NOT NULL,
  `is_delete` bit(1) NOT NULL DEFAULT b'0',
  `create_at` datetime(6) NOT NULL,
  `update_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `IX_order_tax_order_id` (`order_id`) USING BTREE,
  KEY `IX_order_tax_order_item_id` (`order_item_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of order_tax
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for payment
-- ----------------------------
DROP TABLE IF EXISTS `payment`;
CREATE TABLE `payment` (
  `id` bigint NOT NULL,
  `payment_intent_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `terminal_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `charge_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `serial` bigint NOT NULL,
  `company_id` bigint NOT NULL,
  `merchant_id` bigint NOT NULL,
  `staff_id` bigint NOT NULL,
  `order_id` bigint NOT NULL,
  `order_item_ids` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `paid_amount` decimal(8,2) NOT NULL DEFAULT '0.00',
  `tips_amount` decimal(8,2) NOT NULL DEFAULT '0.00',
  `change_amount` decimal(8,2) NOT NULL DEFAULT '0.00',
  `status` tinyint unsigned NOT NULL,
  `mode` tinyint unsigned NOT NULL,
  `provider` tinyint unsigned NOT NULL,
  `is_delete` bit(1) NOT NULL DEFAULT b'0',
  `canceled_at` datetime(6) NOT NULL,
  `canceled_by` bigint NOT NULL DEFAULT '0',
  `error` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `create_at` datetime(6) NOT NULL,
  `update_at` datetime(6) NOT NULL,
  `brand` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `customized_provider_id` bigint DEFAULT '0',
  `customized_provider_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `event_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '',
  `customized_tips` decimal(8,2) NOT NULL DEFAULT '0.00',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `IX_payment_order_id` (`order_id`) USING BTREE,
  KEY `IX_payment_serial_company_id_merchant_id` (`serial`,`company_id`,`merchant_id`) USING BTREE,
  KEY `IX_payment_terminal_id` (`terminal_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of payment
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for payment_event
-- ----------------------------
DROP TABLE IF EXISTS `payment_event`;
CREATE TABLE `payment_event` (
  `id` bigint NOT NULL,
  `event_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `company_id` bigint NOT NULL,
  `merchant_id` bigint NOT NULL,
  `order_id` bigint NOT NULL,
  `status` tinyint unsigned NOT NULL,
  `provider` tinyint unsigned NOT NULL,
  `detail` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `is_delete` bit(1) NOT NULL DEFAULT b'0',
  `create_at` datetime(6) DEFAULT NULL,
  `update_at` datetime(6) DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(6),
  `payment_id` bigint NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_order_id` (`order_id`) USING BTREE,
  KEY `idx_order_id_merchant_id` (`merchant_id`,`order_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of payment_event
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for permission
-- ----------------------------
DROP TABLE IF EXISTS `permission`;
CREATE TABLE `permission` (
  `id` bigint NOT NULL,
  `parent_id` bigint DEFAULT NULL,
  `level` int NOT NULL,
  `permission_code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `sort` tinyint NOT NULL,
  `create_at` datetime(6) NOT NULL,
  `update_at` datetime(6) NOT NULL,
  `is_delete` bit(1) NOT NULL DEFAULT b'0',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of permission
-- ----------------------------
BEGIN;
INSERT INTO `permission` (`id`, `parent_id`, `level`, `permission_code`, `sort`, `create_at`, `update_at`, `is_delete`) VALUES (8348143697724421, NULL, 1, 'Create_Order', 1, '2024-03-04 10:23:59.330219', '2024-03-04 10:23:59.330219', b'0');
INSERT INTO `permission` (`id`, `parent_id`, `level`, `permission_code`, `sort`, `create_at`, `update_at`, `is_delete`) VALUES (8348143697789959, 8348143697724421, 2, 'Dine_In', 1, '2024-03-04 10:23:59.330172', '2024-03-04 10:23:59.330194', b'0');
INSERT INTO `permission` (`id`, `parent_id`, `level`, `permission_code`, `sort`, `create_at`, `update_at`, `is_delete`) VALUES (8348143697789962, 8348143697724421, 2, 'To_Go', 2, '2024-03-04 10:23:59.330218', '2024-03-04 10:23:59.330218', b'0');
INSERT INTO `permission` (`id`, `parent_id`, `level`, `permission_code`, `sort`, `create_at`, `update_at`, `is_delete`) VALUES (8348143697789965, 8348143697724421, 2, 'Pick_Up', 3, '2024-03-04 10:23:59.330218', '2024-03-04 10:23:59.330218', b'0');
INSERT INTO `permission` (`id`, `parent_id`, `level`, `permission_code`, `sort`, `create_at`, `update_at`, `is_delete`) VALUES (8348143697789968, 8348143697724421, 2, 'Delivery', 4, '2024-03-04 10:23:59.330218', '2024-03-04 10:23:59.330218', b'0');
INSERT INTO `permission` (`id`, `parent_id`, `level`, `permission_code`, `sort`, `create_at`, `update_at`, `is_delete`) VALUES (8348143697789971, 8348143697724421, 2, 'Edit_Sent_To_Kitchen_Item_Preferences', 5, '2024-03-04 10:23:59.330218', '2024-03-04 10:23:59.330218', b'0');
INSERT INTO `permission` (`id`, `parent_id`, `level`, `permission_code`, `sort`, `create_at`, `update_at`, `is_delete`) VALUES (8348143697789974, 8348143697724421, 2, 'Custom_Item', 6, '2024-03-04 10:23:59.330218', '2024-03-04 10:23:59.330218', b'0');
INSERT INTO `permission` (`id`, `parent_id`, `level`, `permission_code`, `sort`, `create_at`, `update_at`, `is_delete`) VALUES (8348143697789977, 8348143697724421, 2, 'Resend_Sent_To_Kitchen_Item', 7, '2024-03-04 10:23:59.330219', '2024-03-04 10:23:59.330219', b'0');
INSERT INTO `permission` (`id`, `parent_id`, `level`, `permission_code`, `sort`, `create_at`, `update_at`, `is_delete`) VALUES (8348143697789980, NULL, 1, 'Edit_Order', 2, '2024-03-04 10:23:59.330221', '2024-03-04 10:23:59.330221', b'0');
INSERT INTO `permission` (`id`, `parent_id`, `level`, `permission_code`, `sort`, `create_at`, `update_at`, `is_delete`) VALUES (8348143697789983, 8348143697789980, 2, 'Change_Order_Type', 1, '2024-03-04 10:23:59.330219', '2024-03-04 10:23:59.330219', b'0');
INSERT INTO `permission` (`id`, `parent_id`, `level`, `permission_code`, `sort`, `create_at`, `update_at`, `is_delete`) VALUES (8348143697789986, 8348143697789980, 2, 'Change_Table', 2, '2024-03-04 10:23:59.330219', '2024-03-04 10:23:59.330219', b'0');
INSERT INTO `permission` (`id`, `parent_id`, `level`, `permission_code`, `sort`, `create_at`, `update_at`, `is_delete`) VALUES (8348143697789989, 8348143697789980, 2, 'Change_Waiter', 3, '2024-03-04 10:23:59.330219', '2024-03-04 10:23:59.330219', b'0');
INSERT INTO `permission` (`id`, `parent_id`, `level`, `permission_code`, `sort`, `create_at`, `update_at`, `is_delete`) VALUES (8348143697789992, 8348143697789980, 2, 'Change_Number_Of_Guests', 4, '2024-03-04 10:23:59.330219', '2024-03-04 10:23:59.330219', b'0');
INSERT INTO `permission` (`id`, `parent_id`, `level`, `permission_code`, `sort`, `create_at`, `update_at`, `is_delete`) VALUES (8348143697789995, 8348143697789980, 2, 'Void', 5, '2024-03-04 10:23:59.330219', '2024-03-04 10:23:59.330219', b'0');
INSERT INTO `permission` (`id`, `parent_id`, `level`, `permission_code`, `sort`, `create_at`, `update_at`, `is_delete`) VALUES (8348143697789998, 8348143697789980, 2, 'Split_Order', 6, '2024-03-04 10:23:59.330220', '2024-03-04 10:23:59.330220', b'0');
INSERT INTO `permission` (`id`, `parent_id`, `level`, `permission_code`, `sort`, `create_at`, `update_at`, `is_delete`) VALUES (8348143697790001, 8348143697789980, 2, 'Merge_Orders', 7, '2024-03-04 10:23:59.330220', '2024-03-04 10:23:59.330220', b'0');
INSERT INTO `permission` (`id`, `parent_id`, `level`, `permission_code`, `sort`, `create_at`, `update_at`, `is_delete`) VALUES (8348143697790004, 8348143697789980, 2, 'Void_Sent_To_Kitchen_Item', 8, '2024-03-04 10:23:59.330220', '2024-03-04 10:23:59.330220', b'0');
INSERT INTO `permission` (`id`, `parent_id`, `level`, `permission_code`, `sort`, `create_at`, `update_at`, `is_delete`) VALUES (8348143697790007, 8348143697789980, 2, 'Move_Item', 9, '2024-03-04 10:23:59.330220', '2024-03-04 10:23:59.330220', b'0');
INSERT INTO `permission` (`id`, `parent_id`, `level`, `permission_code`, `sort`, `create_at`, `update_at`, `is_delete`) VALUES (8348143697790010, 8348143697789980, 2, 'Item_Price', 10, '2024-03-04 10:23:59.330220', '2024-03-04 10:23:59.330220', b'0');
INSERT INTO `permission` (`id`, `parent_id`, `level`, `permission_code`, `sort`, `create_at`, `update_at`, `is_delete`) VALUES (8348143697790013, 8348143697789980, 2, 'Charge', 11, '2024-03-04 10:23:59.330220', '2024-03-04 10:23:59.330220', b'0');
INSERT INTO `permission` (`id`, `parent_id`, `level`, `permission_code`, `sort`, `create_at`, `update_at`, `is_delete`) VALUES (8348143697790016, 8348143697789980, 2, 'Discount', 12, '2024-03-04 10:23:59.330221', '2024-03-04 10:23:59.330221', b'0');
INSERT INTO `permission` (`id`, `parent_id`, `level`, `permission_code`, `sort`, `create_at`, `update_at`, `is_delete`) VALUES (8348143697790019, 8348143697789980, 2, 'Tax_Exempt', 13, '2024-03-04 10:23:59.330221', '2024-03-04 10:23:59.330221', b'0');
INSERT INTO `permission` (`id`, `parent_id`, `level`, `permission_code`, `sort`, `create_at`, `update_at`, `is_delete`) VALUES (8348143697790022, 8348143697789980, 2, 'Add_Tip_Before_Payment', 14, '2024-03-04 10:23:59.330221', '2024-03-04 10:23:59.330221', b'0');
INSERT INTO `permission` (`id`, `parent_id`, `level`, `permission_code`, `sort`, `create_at`, `update_at`, `is_delete`) VALUES (8348143697790025, NULL, 1, 'Payment', 3, '2024-03-04 10:23:59.330222', '2024-03-04 10:23:59.330222', b'0');
INSERT INTO `permission` (`id`, `parent_id`, `level`, `permission_code`, `sort`, `create_at`, `update_at`, `is_delete`) VALUES (8348143697790028, 8348143697790025, 2, 'Open_Cash_Drawer', 1, '2024-03-04 10:23:59.330221', '2024-03-04 10:23:59.330221', b'0');
INSERT INTO `permission` (`id`, `parent_id`, `level`, `permission_code`, `sort`, `create_at`, `update_at`, `is_delete`) VALUES (8348143697790031, 8348143697790025, 2, 'Cash_Payment', 2, '2024-03-04 10:23:59.330221', '2024-03-04 10:23:59.330221', b'0');
INSERT INTO `permission` (`id`, `parent_id`, `level`, `permission_code`, `sort`, `create_at`, `update_at`, `is_delete`) VALUES (8348143697790034, 8348143697790025, 2, 'Credit_Card_Or_Digital_Payment', 3, '2024-03-04 10:23:59.330222', '2024-03-04 10:23:59.330222', b'0');
INSERT INTO `permission` (`id`, `parent_id`, `level`, `permission_code`, `sort`, `create_at`, `update_at`, `is_delete`) VALUES (8348143697790037, 8348143697790025, 2, 'Credit_Card_Payment_With_Tip', 4, '2024-03-04 10:23:59.330222', '2024-03-04 10:23:59.330222', b'0');
INSERT INTO `permission` (`id`, `parent_id`, `level`, `permission_code`, `sort`, `create_at`, `update_at`, `is_delete`) VALUES (8348143697790040, 8348143697790025, 2, 'Void_Cash_Payment', 5, '2024-03-04 10:23:59.330222', '2024-03-04 10:23:59.330222', b'0');
INSERT INTO `permission` (`id`, `parent_id`, `level`, `permission_code`, `sort`, `create_at`, `update_at`, `is_delete`) VALUES (8348143697790043, 8348143697790025, 2, 'Void_Credit_Card_Payment', 6, '2024-03-04 10:23:59.330222', '2024-03-04 10:23:59.330222', b'0');
INSERT INTO `permission` (`id`, `parent_id`, `level`, `permission_code`, `sort`, `create_at`, `update_at`, `is_delete`) VALUES (8348143697790046, NULL, 1, 'Operations', 4, '2024-03-04 10:23:59.330224', '2024-03-04 10:23:59.330224', b'0');
INSERT INTO `permission` (`id`, `parent_id`, `level`, `permission_code`, `sort`, `create_at`, `update_at`, `is_delete`) VALUES (8348143697790049, 8348143697790046, 2, 'Log_Out', 1, '2024-03-04 10:23:59.330222', '2024-03-04 10:23:59.330222', b'0');
INSERT INTO `permission` (`id`, `parent_id`, `level`, `permission_code`, `sort`, `create_at`, `update_at`, `is_delete`) VALUES (8348143697790052, 8348143697790046, 2, 'Orders', 2, '2024-03-04 10:23:59.330222', '2024-03-04 10:23:59.330222', b'0');
INSERT INTO `permission` (`id`, `parent_id`, `level`, `permission_code`, `sort`, `create_at`, `update_at`, `is_delete`) VALUES (8348143697790055, 8348143697790046, 2, 'Reprint_Receipt', 3, '2024-03-04 10:23:59.330223', '2024-03-04 10:23:59.330223', b'0');
INSERT INTO `permission` (`id`, `parent_id`, `level`, `permission_code`, `sort`, `create_at`, `update_at`, `is_delete`) VALUES (8348143697790058, 8348143697790046, 2, 'All_Orders', 4, '2024-03-04 10:23:59.330223', '2024-03-04 10:23:59.330223', b'0');
INSERT INTO `permission` (`id`, `parent_id`, `level`, `permission_code`, `sort`, `create_at`, `update_at`, `is_delete`) VALUES (8348143697790061, 8348143697790046, 2, 'Show_All_Dishes', 5, '2024-03-04 10:23:59.330223', '2024-03-04 10:23:59.330223', b'0');
INSERT INTO `permission` (`id`, `parent_id`, `level`, `permission_code`, `sort`, `create_at`, `update_at`, `is_delete`) VALUES (8348143697790064, 8348143697790046, 2, 'View_History_Orders', 6, '2024-03-04 10:23:59.330223', '2024-03-04 10:23:59.330223', b'0');
INSERT INTO `permission` (`id`, `parent_id`, `level`, `permission_code`, `sort`, `create_at`, `update_at`, `is_delete`) VALUES (8348143697790067, 8348143697790046, 2, 'Cash_Reconciliation', 7, '2024-03-04 10:23:59.330223', '2024-03-04 10:23:59.330223', b'0');
INSERT INTO `permission` (`id`, `parent_id`, `level`, `permission_code`, `sort`, `create_at`, `update_at`, `is_delete`) VALUES (8348143697790070, 8348143697790046, 2, 'Credit_Card_Settlement', 8, '2024-03-04 10:23:59.330223', '2024-03-04 10:23:59.330223', b'0');
INSERT INTO `permission` (`id`, `parent_id`, `level`, `permission_code`, `sort`, `create_at`, `update_at`, `is_delete`) VALUES (8348143697790073, 8348143697790046, 2, 'Driver', 9, '2024-03-04 10:23:59.330224', '2024-03-04 10:23:59.330224', b'0');
INSERT INTO `permission` (`id`, `parent_id`, `level`, `permission_code`, `sort`, `create_at`, `update_at`, `is_delete`) VALUES (8348143697790076, NULL, 1, 'POS_Settings', 5, '2024-03-04 10:23:59.330224', '2024-03-04 10:23:59.330224', b'0');
INSERT INTO `permission` (`id`, `parent_id`, `level`, `permission_code`, `sort`, `create_at`, `update_at`, `is_delete`) VALUES (8348143697790079, 8348143697790076, 2, 'Store_Management', 1, '2024-03-04 10:23:59.330224', '2024-03-04 10:23:59.330224', b'0');
INSERT INTO `permission` (`id`, `parent_id`, `level`, `permission_code`, `sort`, `create_at`, `update_at`, `is_delete`) VALUES (8348143697790082, 8348143697790076, 2, 'Menu_Management', 2, '2024-03-04 10:23:59.330224', '2024-03-04 10:23:59.330224', b'0');
INSERT INTO `permission` (`id`, `parent_id`, `level`, `permission_code`, `sort`, `create_at`, `update_at`, `is_delete`) VALUES (8348143697790085, 8348143697790076, 2, 'Hardware_Management', 3, '2024-03-04 10:23:59.330224', '2024-03-04 10:23:59.330224', b'0');
INSERT INTO `permission` (`id`, `parent_id`, `level`, `permission_code`, `sort`, `create_at`, `update_at`, `is_delete`) VALUES (8348143697790088, 8348143697790076, 2, 'Employee_Management', 4, '2024-03-04 10:23:59.330224', '2024-03-04 10:23:59.330224', b'0');
INSERT INTO `permission` (`id`, `parent_id`, `level`, `permission_code`, `sort`, `create_at`, `update_at`, `is_delete`) VALUES (8348143697790091, NULL, 1, 'Reports', 6, '2024-03-04 10:23:59.330225', '2024-03-04 10:23:59.330225', b'0');
INSERT INTO `permission` (`id`, `parent_id`, `level`, `permission_code`, `sort`, `create_at`, `update_at`, `is_delete`) VALUES (8348143697790094, 8348143697790091, 2, 'Total_Report', 1, '2024-03-04 10:23:59.330225', '2024-03-04 10:23:59.330225', b'0');
COMMIT;

-- ----------------------------
-- Table structure for pre_set_price_adjustment
-- ----------------------------
DROP TABLE IF EXISTS `pre_set_price_adjustment`;
CREATE TABLE `pre_set_price_adjustment` (
  `id` bigint NOT NULL,
  `name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `merchant_id` bigint NOT NULL,
  `is_tax_free` bit(1) NOT NULL DEFAULT b'0',
  `type` tinyint unsigned NOT NULL,
  `charge_category` tinyint unsigned NOT NULL,
  `target` tinyint unsigned NOT NULL,
  `charge_rule` tinyint unsigned NOT NULL,
  `status` tinyint unsigned NOT NULL,
  `value` decimal(8,3) NOT NULL DEFAULT '0.000',
  `min_of_diners` int unsigned NOT NULL,
  `min_spending_amount` decimal(8,3) NOT NULL DEFAULT '0.000',
  `pattern` tinyint unsigned NOT NULL,
  `created_by` bigint NOT NULL,
  `canceled_by` bigint NOT NULL DEFAULT '0',
  `canceled_at` datetime(6) NOT NULL,
  `desc` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `sort` int NOT NULL DEFAULT '0',
  `is_delete` bit(1) NOT NULL DEFAULT b'0',
  `create_at` datetime(6) NOT NULL,
  `update_at` datetime(6) NOT NULL,
  `order_types` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '[]',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `IX_pre_set_price_adjustment_charge_category` (`charge_category`) USING BTREE,
  KEY `IX_pre_set_price_adjustment_merchant_id` (`merchant_id`) USING BTREE,
  KEY `IX_pre_set_price_adjustment_target` (`target`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of pre_set_price_adjustment
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for printer
-- ----------------------------
DROP TABLE IF EXISTS `printer`;
CREATE TABLE `printer` (
  `id` bigint NOT NULL,
  `company_id` bigint NOT NULL,
  `merchant_id` bigint NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `host` int unsigned NOT NULL,
  `interface` int unsigned NOT NULL,
  `host_address` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `code` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `language_preference` int unsigned NOT NULL,
  `primary_language` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `secondary_language` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `type` int unsigned NOT NULL,
  `status` tinyint unsigned NOT NULL,
  `is_delete` bit(1) NOT NULL DEFAULT b'0',
  `create_at` datetime(6) NOT NULL,
  `update_at` datetime(6) NOT NULL,
  `device_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '',
  `printer_model` tinyint unsigned NOT NULL DEFAULT '0',
  `port` int NOT NULL,
  `v_id` bigint NOT NULL,
  `p_id` bigint NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `IX_printer_company_id_merchant_id` (`company_id`,`merchant_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of printer
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for printer_product
-- ----------------------------
DROP TABLE IF EXISTS `printer_product`;
CREATE TABLE `printer_product` (
  `id` bigint NOT NULL,
  `printer_id` bigint NOT NULL,
  `product_id` bigint NOT NULL,
  `company_id` bigint NOT NULL,
  `merchant_id` bigint NOT NULL,
  `create_at` datetime(6) NOT NULL,
  `update_at` datetime(6) NOT NULL,
  `is_delete` bit(1) NOT NULL DEFAULT b'0',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `IX_printer_product_product_id_printer_id_company_id_merchant_id` (`product_id`,`printer_id`,`company_id`,`merchant_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of printer_product
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for product
-- ----------------------------
DROP TABLE IF EXISTS `product`;
CREATE TABLE `product` (
  `id` bigint NOT NULL,
  `company_id` bigint NOT NULL,
  `merchant_id` bigint NOT NULL,
  `price` decimal(8,2) NOT NULL DEFAULT '0.00',
  `stock` int unsigned NOT NULL DEFAULT '0',
  `color` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '#FFFFFF',
  `is_independent_sale` bit(1) NOT NULL DEFAULT b'1',
  `type` int unsigned NOT NULL DEFAULT '0',
  `status` tinyint unsigned NOT NULL DEFAULT '0',
  `sort` int unsigned NOT NULL DEFAULT '0',
  `is_delete` bit(1) NOT NULL DEFAULT b'0',
  `create_at` datetime(6) NOT NULL,
  `update_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `IX_product_company_id_merchant_id` (`company_id`,`merchant_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of product
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for product_modifier_binding
-- ----------------------------
DROP TABLE IF EXISTS `product_modifier_binding`;
CREATE TABLE `product_modifier_binding` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `modifier_group_id` bigint NOT NULL,
  `product_id` bigint NOT NULL,
  `sort` int unsigned NOT NULL DEFAULT '0',
  `create_at` datetime(6) NOT NULL,
  `update_at` datetime(6) NOT NULL,
  `merchant_id` bigint NOT NULL,
  `company_id` bigint NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `IX_product_modifier_binding_product_id` (`product_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of product_modifier_binding
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for region
-- ----------------------------
DROP TABLE IF EXISTS `region`;
CREATE TABLE `region` (
  `id` bigint NOT NULL,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `desc` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `company_id` bigint NOT NULL,
  `merchant_id` bigint NOT NULL,
  `is_delete` bit(1) NOT NULL DEFAULT b'0',
  `sort` int NOT NULL DEFAULT '0',
  `status` tinyint unsigned NOT NULL,
  `create_at` datetime(6) NOT NULL,
  `update_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `IX_region_company_id_merchant_id` (`company_id`,`merchant_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of region
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for role
-- ----------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role` (
  `id` bigint NOT NULL,
  `company_id` bigint NOT NULL,
  `merchant_id` bigint NOT NULL,
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `description` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `create_at` datetime(6) NOT NULL,
  `update_at` datetime(6) NOT NULL,
  `is_delete` bit(1) NOT NULL,
  `is_default` bit(1) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of role
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for role_permission
-- ----------------------------
DROP TABLE IF EXISTS `role_permission`;
CREATE TABLE `role_permission` (
  `id` bigint NOT NULL,
  `company_id` bigint NOT NULL,
  `merchant_id` bigint NOT NULL,
  `role_id` bigint NOT NULL,
  `permission_id` bigint NOT NULL,
  `create_at` datetime(6) NOT NULL,
  `update_at` datetime(6) NOT NULL,
  `is_delete` bit(1) NOT NULL DEFAULT b'0',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of role_permission
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for schemaversions
-- ----------------------------
DROP TABLE IF EXISTS `schemaversions`;
CREATE TABLE `schemaversions` (
  `schemaversionid` int NOT NULL AUTO_INCREMENT,
  `scriptname` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `applied` timestamp NOT NULL,
  PRIMARY KEY (`schemaversionid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of schemaversions
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for setting_template
-- ----------------------------
DROP TABLE IF EXISTS `setting_template`;
CREATE TABLE `setting_template` (
  `id` bigint NOT NULL,
  `system_type` tinyint unsigned DEFAULT NULL,
  `template_enum` bigint DEFAULT NULL,
  `short_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `desc` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `options` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `options_type` tinyint unsigned DEFAULT NULL,
  `default_value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `is_delegated_usage` bit(1) NOT NULL DEFAULT b'0',
  `is_delete` bit(1) NOT NULL DEFAULT b'0',
  `create_at` datetime(6) NOT NULL,
  `update_at` datetime(6) NOT NULL,
  `is_active` bit(1) NOT NULL DEFAULT b'1',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of setting_template
-- ----------------------------
BEGIN;
INSERT INTO `setting_template` (`id`, `system_type`, `template_enum`, `short_name`, `desc`, `options`, `options_type`, `default_value`, `is_delegated_usage`, `is_delete`, `create_at`, `update_at`, `is_active`) VALUES (8450152450098560, 2, 1000, 'Skip table selection', '跳过选桌', 'false', 0, 'false', b'0', b'0', '0001-01-01 00:00:00.000000', '2024-03-24 05:31:47.275114', b'1');
INSERT INTO `setting_template` (`id`, `system_type`, `template_enum`, `short_name`, `desc`, `options`, `options_type`, `default_value`, `is_delegated_usage`, `is_delete`, `create_at`, `update_at`, `is_active`) VALUES (8450152450098579, 2, 1001, 'Skip number selection', '跳过人数', 'false', 0, 'false', b'0', b'0', '0001-01-01 00:00:00.000000', '2024-03-24 05:32:24.530866', b'1');
INSERT INTO `setting_template` (`id`, `system_type`, `template_enum`, `short_name`, `desc`, `options`, `options_type`, `default_value`, `is_delegated_usage`, `is_delete`, `create_at`, `update_at`, `is_active`) VALUES (8450152450098599, 2, 2000, 'Max. Guests Per Order', '每单最多客人数量', '200', 1, '200', b'0', b'0', '0001-01-01 00:00:00.000000', '2024-03-24 05:32:53.136833', b'1');
INSERT INTO `setting_template` (`id`, `system_type`, `template_enum`, `short_name`, `desc`, `options`, `options_type`, `default_value`, `is_delegated_usage`, `is_delete`, `create_at`, `update_at`, `is_active`) VALUES (8450152450098637, 2, 2002, 'mergeDisplay', '相同菜合并展示', 'false', 0, 'false', b'0', b'0', '0001-01-01 00:00:00.000000', '2024-03-24 05:34:11.260709', b'1');
INSERT INTO `setting_template` (`id`, `system_type`, `template_enum`, `short_name`, `desc`, `options`, `options_type`, `default_value`, `is_delegated_usage`, `is_delete`, `create_at`, `update_at`, `is_active`) VALUES (8450152450098656, 2, 2001, 'splitDisplay', '相同菜拆分展示', 'true', 0, 'true', b'0', b'0', '0001-01-01 00:00:00.000000', '2024-03-24 05:34:30.944188', b'1');
INSERT INTO `setting_template` (`id`, `system_type`, `template_enum`, `short_name`, `desc`, `options`, `options_type`, `default_value`, `is_delegated_usage`, `is_delete`, `create_at`, `update_at`, `is_active`) VALUES (8453794552808453, 2, 2003, 'sendDeletionInformationToTheKitchen', '是否向厨房发送删单信息', 'true', 0, 'true', b'0', b'0', '0001-01-01 00:00:00.000000', '2024-03-24 05:34:52.622839', b'1');
INSERT INTO `setting_template` (`id`, `system_type`, `template_enum`, `short_name`, `desc`, `options`, `options_type`, `default_value`, `is_delegated_usage`, `is_delete`, `create_at`, `update_at`, `is_active`) VALUES (8453794552808472, 2, 2004, 'deletionInformationIsRequired', '删单原因必填', 'true', 0, 'true', b'0', b'0', '0001-01-01 00:00:00.000000', '2024-03-24 05:35:16.340824', b'1');
INSERT INTO `setting_template` (`id`, `system_type`, `template_enum`, `short_name`, `desc`, `options`, `options_type`, `default_value`, `is_delegated_usage`, `is_delete`, `create_at`, `update_at`, `is_active`) VALUES (8453794552808491, 2, 2005, 'deleteReason', '删单原因', '[\"Food Allergy\",\"Foreign Objects in Food \",\"Servers Mistake\",\"Waited Too Long\",\"Foodis Undercooked  \",\"Improperly Prepared  7、Orders Arriving Not as Described\"]', 102, '[\"Food Allergy\",\"Foreign Objects in Food \",\"Servers Mistake\",\"Waited Too Long\",\"Foodis Undercooked  \",\"Improperly Prepared  7、Orders Arriving Not as Described\"]', b'0', b'0', '0001-01-01 00:00:00.000000', '2024-03-24 05:35:43.379353', b'1');
INSERT INTO `setting_template` (`id`, `system_type`, `template_enum`, `short_name`, `desc`, `options`, `options_type`, `default_value`, `is_delegated_usage`, `is_delete`, `create_at`, `update_at`, `is_active`) VALUES (8453794552808510, 2, 3000, 'Dine in', '按时段展示菜单 - 堂食', 'false', 0, 'false', b'0', b'0', '0001-01-01 00:00:00.000000', '2024-03-24 05:38:12.250265', b'1');
INSERT INTO `setting_template` (`id`, `system_type`, `template_enum`, `short_name`, `desc`, `options`, `options_type`, `default_value`, `is_delegated_usage`, `is_delete`, `create_at`, `update_at`, `is_active`) VALUES (8453794552808529, 2, 3001, 'To Go', '按时段展示菜单 - 等取餐', 'true', 0, 'true', b'0', b'0', '0001-01-01 00:00:00.000000', '2024-03-24 05:38:35.089007', b'1');
INSERT INTO `setting_template` (`id`, `system_type`, `template_enum`, `short_name`, `desc`, `options`, `options_type`, `default_value`, `is_delegated_usage`, `is_delete`, `create_at`, `update_at`, `is_active`) VALUES (8453794552808548, 2, 3002, 'Pickup', '按时段展示菜单 - 来取', 'false', 0, 'false', b'0', b'0', '0001-01-01 00:00:00.000000', '2024-03-24 05:38:58.338574', b'1');
INSERT INTO `setting_template` (`id`, `system_type`, `template_enum`, `short_name`, `desc`, `options`, `options_type`, `default_value`, `is_delegated_usage`, `is_delete`, `create_at`, `update_at`, `is_active`) VALUES (8453794552808567, 2, 3003, 'Delivery', '按时段展示菜单 - 外送', 'false', 0, 'false', b'0', b'0', '0001-01-01 00:00:00.000000', '2024-03-24 05:39:09.525645', b'1');
INSERT INTO `setting_template` (`id`, `system_type`, `template_enum`, `short_name`, `desc`, `options`, `options_type`, `default_value`, `is_delegated_usage`, `is_delete`, `create_at`, `update_at`, `is_active`) VALUES (8453794552808586, 2, 4000, 'Tax calculated on discounted price', '根据折扣后计税', 'true', 0, 'true', b'0', b'0', '0001-01-01 00:00:00.000000', '2024-03-24 05:39:52.629377', b'1');
INSERT INTO `setting_template` (`id`, `system_type`, `template_enum`, `short_name`, `desc`, `options`, `options_type`, `default_value`, `is_delegated_usage`, `is_delete`, `create_at`, `update_at`, `is_active`) VALUES (8453794552808622, 2, 5000, 'Collecting tips through POS', '通过刷卡机收取小费', 'false', 0, 'false', b'0', b'0', '0001-01-01 00:00:00.000000', '2024-03-24 05:40:08.074283', b'1');
INSERT INTO `setting_template` (`id`, `system_type`, `template_enum`, `short_name`, `desc`, `options`, `options_type`, `default_value`, `is_delegated_usage`, `is_delete`, `create_at`, `update_at`, `is_active`) VALUES (8453794552808641, 2, 5001, 'Tip Pre-set', '建议小费百分比金额', '[15,18,20]', 100, '[15,18,20]', b'0', b'0', '0001-01-01 00:00:00.000000', '2024-03-24 05:40:22.476455', b'1');
INSERT INTO `setting_template` (`id`, `system_type`, `template_enum`, `short_name`, `desc`, `options`, `options_type`, `default_value`, `is_delegated_usage`, `is_delete`, `create_at`, `update_at`, `is_active`) VALUES (8453794552873989, 2, 6000, 'Default Global Preference Price', '默认全局偏好价格', '[1,2,3,4,5]', 101, '[1,2,3,4,5]', b'0', b'0', '0001-01-01 00:00:00.000000', '2024-03-24 05:40:41.312277', b'1');
INSERT INTO `setting_template` (`id`, `system_type`, `template_enum`, `short_name`, `desc`, `options`, `options_type`, `default_value`, `is_delegated_usage`, `is_delete`, `create_at`, `update_at`, `is_active`) VALUES (8453794552874008, 2, 7000, 'Select printer before printing', '打印前选择打印机', 'false', 0, 'false', b'0', b'0', '0001-01-01 00:00:00.000000', '2024-03-24 05:41:10.245297', b'1');
INSERT INTO `setting_template` (`id`, `system_type`, `template_enum`, `short_name`, `desc`, `options`, `options_type`, `default_value`, `is_delegated_usage`, `is_delete`, `create_at`, `update_at`, `is_active`) VALUES (8453794552874027, 2, 7001, 'Free Dishes', '收据排版 - 打印价格为0的菜', 'true', 0, 'true', b'0', b'0', '0001-01-01 00:00:00.000000', '2024-03-24 05:41:34.662341', b'1');
INSERT INTO `setting_template` (`id`, `system_type`, `template_enum`, `short_name`, `desc`, `options`, `options_type`, `default_value`, `is_delegated_usage`, `is_delete`, `create_at`, `update_at`, `is_active`) VALUES (8453794552874046, 2, 7002, 'Free Option', '收据排版 - 打印价格为0的规格', 'true', 0, 'true', b'0', b'0', '0001-01-01 00:00:00.000000', '2024-03-24 05:42:03.807131', b'1');
INSERT INTO `setting_template` (`id`, `system_type`, `template_enum`, `short_name`, `desc`, `options`, `options_type`, `default_value`, `is_delegated_usage`, `is_delete`, `create_at`, `update_at`, `is_active`) VALUES (8453794552874065, 2, 7003, 'Free Preference', '收据排版 - 打印价格为0的偏好', 'false', 0, 'false', b'0', b'0', '0001-01-01 00:00:00.000000', '2024-03-24 05:42:30.928547', b'1');
INSERT INTO `setting_template` (`id`, `system_type`, `template_enum`, `short_name`, `desc`, `options`, `options_type`, `default_value`, `is_delegated_usage`, `is_delete`, `create_at`, `update_at`, `is_active`) VALUES (8453794552874084, 2, 7004, 'Customer Note', '显示客人备注', 'false', 0, 'false', b'0', b'0', '0001-01-01 00:00:00.000000', '2024-03-24 05:42:56.519588', b'1');
INSERT INTO `setting_template` (`id`, `system_type`, `template_enum`, `short_name`, `desc`, `options`, `options_type`, `default_value`, `is_delegated_usage`, `is_delete`, `create_at`, `update_at`, `is_active`) VALUES (8453794552874103, 2, 7005, 'Divide Line', '显示分割线', 'false', 0, 'false', b'0', b'0', '0001-01-01 00:00:00.000000', '2024-03-24 05:43:13.312456', b'1');
INSERT INTO `setting_template` (`id`, `system_type`, `template_enum`, `short_name`, `desc`, `options`, `options_type`, `default_value`, `is_delegated_usage`, `is_delete`, `create_at`, `update_at`, `is_active`) VALUES (8453794552874122, 2, 7006, 'Preference/Discount/Charge Price', '打印偏好/打折/加收价格', 'true', 0, 'true', b'0', b'0', '0001-01-01 00:00:00.000000', '2024-03-24 05:43:29.246405', b'1');
INSERT INTO `setting_template` (`id`, `system_type`, `template_enum`, `short_name`, `desc`, `options`, `options_type`, `default_value`, `is_delegated_usage`, `is_delete`, `create_at`, `update_at`, `is_active`) VALUES (8453794552874141, 2, 7007, 'Combine Same Dish', '合并相同菜', 'false', 0, 'false', b'0', b'0', '0001-01-01 00:00:00.000000', '2024-03-24 05:43:45.900555', b'1');
INSERT INTO `setting_template` (`id`, `system_type`, `template_enum`, `short_name`, `desc`, `options`, `options_type`, `default_value`, `is_delegated_usage`, `is_delete`, `create_at`, `update_at`, `is_active`) VALUES (8453794552874160, 2, 7008, 'Combine Same Option', '合并菜的相同規格', 'false', 0, 'false', b'0', b'0', '0001-01-01 00:00:00.000000', '2024-03-24 05:44:13.322882', b'1');
INSERT INTO `setting_template` (`id`, `system_type`, `template_enum`, `short_name`, `desc`, `options`, `options_type`, `default_value`, `is_delegated_usage`, `is_delete`, `create_at`, `update_at`, `is_active`) VALUES (8453794552874179, 2, 7009, 'Pre-tax', '稅前計算小費金額', 'true', 0, 'true', b'0', b'0', '0001-01-01 00:00:00.000000', '2024-03-24 05:44:27.555002', b'1');
INSERT INTO `setting_template` (`id`, `system_type`, `template_enum`, `short_name`, `desc`, `options`, `options_type`, `default_value`, `is_delegated_usage`, `is_delete`, `create_at`, `update_at`, `is_active`) VALUES (8453794552874198, 2, 7010, 'Pre-discount', '折扣前計算小費金額', 'false', 0, 'false', b'0', b'0', '0001-01-01 00:00:00.000000', '2024-03-24 05:44:40.802006', b'1');
INSERT INTO `setting_template` (`id`, `system_type`, `template_enum`, `short_name`, `desc`, `options`, `options_type`, `default_value`, `is_delegated_usage`, `is_delete`, `create_at`, `update_at`, `is_active`) VALUES (8453794552874218, 2, 7011, 'Tip Pre-set', '建議小費金額百分比', '[15,18,20]', 100, '[15,18,20]', b'0', b'0', '0001-01-01 00:00:00.000000', '2024-03-24 05:44:55.340220', b'1');
INSERT INTO `setting_template` (`id`, `system_type`, `template_enum`, `short_name`, `desc`, `options`, `options_type`, `default_value`, `is_delegated_usage`, `is_delete`, `create_at`, `update_at`, `is_active`) VALUES (8453794552874237, 2, 8000, 'AutomaticallyLogOutAfterEachOperation', '完成每次操作后帐号自动登出', 'false', 0, 'false', b'0', b'0', '0001-01-01 00:00:00.000000', '2024-03-24 05:45:05.484128', b'1');
INSERT INTO `setting_template` (`id`, `system_type`, `template_enum`, `short_name`, `desc`, `options`, `options_type`, `default_value`, `is_delegated_usage`, `is_delete`, `create_at`, `update_at`, `is_active`) VALUES (8454561414775873, 2, 0, 'Record remote event Id', '用于记录本地拉线上数据，记录事件的ID', '0', 1, '0', b'0', b'0', '0001-01-01 00:00:00.000000', '2024-03-24 05:45:17.578299', b'1');
COMMIT;

-- ----------------------------
-- Table structure for setting_template_enum
-- ----------------------------
DROP TABLE IF EXISTS `setting_template_enum`;
CREATE TABLE `setting_template_enum` (
  `id` bigint NOT NULL,
  `short_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `desc` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `template_enum` bigint NOT NULL,
  `is_delete` bit(1) NOT NULL DEFAULT b'0',
  `create_at` datetime(6) NOT NULL,
  `update_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of setting_template_enum
-- ----------------------------
BEGIN;
INSERT INTO `setting_template_enum` (`id`, `short_name`, `desc`, `template_enum`, `is_delete`, `create_at`, `update_at`) VALUES (8450152450098209, 'skipTableSelection', '跳过选桌', 1000, b'0', '2024-03-23 00:52:14.987880', '2024-03-24 07:56:08.171703');
INSERT INTO `setting_template_enum` (`id`, `short_name`, `desc`, `template_enum`, `is_delete`, `create_at`, `update_at`) VALUES (8450152450098210, 'skipNumberSelection', '跳过人数', 1001, b'0', '2024-03-23 00:53:51.391803', '2024-03-24 07:56:14.198091');
INSERT INTO `setting_template_enum` (`id`, `short_name`, `desc`, `template_enum`, `is_delete`, `create_at`, `update_at`) VALUES (8450152450098211, 'maxGuestsPerOrder', '每单最多客人数量', 2000, b'0', '2024-03-23 00:54:07.131940', '2024-03-24 07:56:19.699157');
INSERT INTO `setting_template_enum` (`id`, `short_name`, `desc`, `template_enum`, `is_delete`, `create_at`, `update_at`) VALUES (8450152450098212, 'splitDisplay', '相同菜拆分展示', 2001, b'0', '2024-03-23 00:54:23.628983', '2024-03-24 07:56:25.039775');
INSERT INTO `setting_template_enum` (`id`, `short_name`, `desc`, `template_enum`, `is_delete`, `create_at`, `update_at`) VALUES (8450152450098213, 'mergeDisplay', '相同菜合并展示', 2002, b'0', '2024-03-23 00:54:44.038851', '2024-03-24 07:56:30.825665');
INSERT INTO `setting_template_enum` (`id`, `short_name`, `desc`, `template_enum`, `is_delete`, `create_at`, `update_at`) VALUES (8450152450098214, 'sendDeletionInformationToTheKitchen', '是否向厨房发送删单信息', 2003, b'0', '2024-03-23 00:55:04.961102', '2024-03-24 07:56:37.773639');
INSERT INTO `setting_template_enum` (`id`, `short_name`, `desc`, `template_enum`, `is_delete`, `create_at`, `update_at`) VALUES (8450152450098215, 'deletionInformationIsRequired', '删单原因必填', 2004, b'0', '2024-03-23 00:55:20.853179', '2024-03-24 07:56:43.970909');
INSERT INTO `setting_template_enum` (`id`, `short_name`, `desc`, `template_enum`, `is_delete`, `create_at`, `update_at`) VALUES (8450152450098216, 'deleteReason', '删单原因', 2005, b'0', '2024-03-23 00:55:43.485164', '2024-03-24 07:56:48.784933');
INSERT INTO `setting_template_enum` (`id`, `short_name`, `desc`, `template_enum`, `is_delete`, `create_at`, `update_at`) VALUES (8450152450098217, 'dineInMenuByTimeSlot', '按时段展示菜单 - 堂食', 3000, b'0', '2024-03-23 00:56:39.792342', '2024-03-24 07:56:54.548333');
INSERT INTO `setting_template_enum` (`id`, `short_name`, `desc`, `template_enum`, `is_delete`, `create_at`, `update_at`) VALUES (8450152450098218, 'toGoMenuByTimeSlot', '按时段展示菜单 - 等取餐', 3001, b'0', '2024-03-23 00:56:54.071748', '2024-03-24 07:57:00.388725');
INSERT INTO `setting_template_enum` (`id`, `short_name`, `desc`, `template_enum`, `is_delete`, `create_at`, `update_at`) VALUES (8450152450098219, 'pickupMenuByTimeSlot', '按时段展示菜单 - 来取', 3002, b'0', '2024-03-23 00:58:09.537293', '2024-03-24 07:57:10.444536');
INSERT INTO `setting_template_enum` (`id`, `short_name`, `desc`, `template_enum`, `is_delete`, `create_at`, `update_at`) VALUES (8450152450098220, 'deliveryMenuByTimeSlot', '按时段展示菜单 - 外送', 3003, b'0', '2024-03-23 00:58:26.200130', '2024-03-24 07:57:15.839205');
INSERT INTO `setting_template_enum` (`id`, `short_name`, `desc`, `template_enum`, `is_delete`, `create_at`, `update_at`) VALUES (8450152450098221, 'taxCalculatedOnDiscountedPrice', '根据折扣后计税', 4000, b'0', '2024-03-23 00:58:43.924803', '2024-03-24 07:57:20.871190');
INSERT INTO `setting_template_enum` (`id`, `short_name`, `desc`, `template_enum`, `is_delete`, `create_at`, `update_at`) VALUES (8450152450098222, 'Collecting tips through POS', '通过刷卡机收取小费', 5000, b'0', '2024-03-23 00:59:03.567673', '2024-03-24 07:57:26.582571');
INSERT INTO `setting_template_enum` (`id`, `short_name`, `desc`, `template_enum`, `is_delete`, `create_at`, `update_at`) VALUES (8450152450098223, 'paymentTipPreSet', '建议小费百分比金额', 5001, b'0', '2024-03-23 00:59:20.045561', '2024-03-24 07:57:31.964860');
INSERT INTO `setting_template_enum` (`id`, `short_name`, `desc`, `template_enum`, `is_delete`, `create_at`, `update_at`) VALUES (8450152450098224, 'defaultGlobalPreferencePrice', '默认全局偏好价格', 6000, b'0', '2024-03-23 00:59:45.654372', '2024-03-24 07:57:40.843000');
INSERT INTO `setting_template_enum` (`id`, `short_name`, `desc`, `template_enum`, `is_delete`, `create_at`, `update_at`) VALUES (8450152450098225, 'selectPrinterBeforePrinting', '打印前选择打印机', 7000, b'0', '2024-03-23 01:00:00.346014', '2024-03-24 07:57:46.624295');
INSERT INTO `setting_template_enum` (`id`, `short_name`, `desc`, `template_enum`, `is_delete`, `create_at`, `update_at`) VALUES (8450152450098226, 'freeDishesReceiptFormatting', '收据排版 - 打印价格为0的菜', 7001, b'0', '2024-03-23 01:01:34.042441', '2024-03-24 07:57:53.139716');
INSERT INTO `setting_template_enum` (`id`, `short_name`, `desc`, `template_enum`, `is_delete`, `create_at`, `update_at`) VALUES (8450152450098227, 'freeOptionReceiptFormatting', '收据排版 - 打印价格为0的规格', 7002, b'0', '2024-03-23 01:03:28.487810', '2024-03-24 07:57:59.124223');
INSERT INTO `setting_template_enum` (`id`, `short_name`, `desc`, `template_enum`, `is_delete`, `create_at`, `update_at`) VALUES (8450152450098228, 'freePreferenceReceiptFormatting', '收据排版 - 打印价格为0的偏好', 7003, b'0', '2024-03-23 01:04:00.165107', '2024-03-24 07:58:05.678038');
INSERT INTO `setting_template_enum` (`id`, `short_name`, `desc`, `template_enum`, `is_delete`, `create_at`, `update_at`) VALUES (8450152450098229, 'customerNoteReceiptFormatting', '收据排版 - 显示客人备注', 7004, b'0', '2024-03-23 01:04:45.334520', '2024-03-24 07:58:13.542046');
INSERT INTO `setting_template_enum` (`id`, `short_name`, `desc`, `template_enum`, `is_delete`, `create_at`, `update_at`) VALUES (8450152450098230, 'divideLineReceiptFormatting', '收据排版 - 显示分割线', 7005, b'0', '2024-03-23 01:05:18.931951', '2024-03-24 07:58:18.794943');
INSERT INTO `setting_template_enum` (`id`, `short_name`, `desc`, `template_enum`, `is_delete`, `create_at`, `update_at`) VALUES (8450152450098231, 'Preference/Discount/Charge Price', '收据排版 - 打印偏好/打折/加收价格', 7006, b'0', '2024-03-23 01:05:40.903870', '2024-03-24 07:58:25.175079');
INSERT INTO `setting_template_enum` (`id`, `short_name`, `desc`, `template_enum`, `is_delete`, `create_at`, `update_at`) VALUES (8450152450098232, 'combineSameDishReceiptFormatting', '收据排版 - 合并相同菜', 7007, b'0', '2024-03-23 01:05:59.951398', '2024-03-24 07:58:31.685989');
INSERT INTO `setting_template_enum` (`id`, `short_name`, `desc`, `template_enum`, `is_delete`, `create_at`, `update_at`) VALUES (8450152450098233, 'combineSameOptionReceiptFormatting', '收据排版 - 合并菜的相同规格', 7008, b'0', '2024-03-23 01:06:23.370168', '2024-03-24 07:58:38.113971');
INSERT INTO `setting_template_enum` (`id`, `short_name`, `desc`, `template_enum`, `is_delete`, `create_at`, `update_at`) VALUES (8450152450098234, 'preTaxTipsCalculationRules', '税前计算小费金额', 7009, b'0', '2024-03-23 01:06:47.525958', '2024-03-24 07:58:45.879629');
INSERT INTO `setting_template_enum` (`id`, `short_name`, `desc`, `template_enum`, `is_delete`, `create_at`, `update_at`) VALUES (8450152450098235, 'preDiscountTipsCalculationRules', '折扣前计算小费金额', 7010, b'0', '2024-03-23 01:07:08.858313', '2024-03-24 07:58:51.756928');
INSERT INTO `setting_template_enum` (`id`, `short_name`, `desc`, `template_enum`, `is_delete`, `create_at`, `update_at`) VALUES (8450152450098236, 'AutomaticallyLogOutAfterEachOperation', '完成每次操作后帐号自动登出', 8000, b'0', '2024-03-23 01:07:35.681026', '2024-03-24 07:58:57.082078');
INSERT INTO `setting_template_enum` (`id`, `short_name`, `desc`, `template_enum`, `is_delete`, `create_at`, `update_at`) VALUES (8453794552874217, 'receiptTipPreSet', '建议小费金额百分比', 7011, b'0', '2024-03-23 05:20:51.519049', '2024-03-24 07:59:04.562399');
INSERT INTO `setting_template_enum` (`id`, `short_name`, `desc`, `template_enum`, `is_delete`, `create_at`, `update_at`) VALUES (8454561414775872, 'Record Local Sync Remote Event Id', '用于记录本地拉线上数据，记录事件的ID', 0, b'0', '2024-03-23 06:35:26.785353', '2024-03-24 07:59:11.520349');
COMMIT;

-- ----------------------------
-- Table structure for setting_values
-- ----------------------------
DROP TABLE IF EXISTS `setting_values`;
CREATE TABLE `setting_values` (
  `id` bigint NOT NULL,
  `company_id` bigint NOT NULL,
  `merchant_id` bigint NOT NULL,
  `template_id` bigint NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `system_type` tinyint NOT NULL,
  `value` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `value_type` tinyint NOT NULL,
  `template_enum` bigint NOT NULL,
  `is_delete` bit(1) NOT NULL DEFAULT b'0',
  `create_at` datetime(6) NOT NULL,
  `update_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of setting_values
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for system_account
-- ----------------------------
DROP TABLE IF EXISTS `system_account`;
CREATE TABLE `system_account` (
  `id` bigint NOT NULL,
  `AccountId` bigint NOT NULL,
  `is_active` bit(1) NOT NULL DEFAULT b'1',
  `is_delete` bit(1) NOT NULL DEFAULT b'1',
  `create_at` datetime(6) NOT NULL,
  `update_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `IX_system_account_AccountId` (`AccountId`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of system_account
-- ----------------------------
BEGIN;
INSERT INTO `system_account` (`id`, `AccountId`, `is_active`, `is_delete`, `create_at`, `update_at`) VALUES (495221185937479, 495221185937470, b'1', b'0', '0001-01-01 00:00:00.000000', '0001-01-01 00:00:00.000000');
COMMIT;

-- ----------------------------
-- Table structure for table
-- ----------------------------
DROP TABLE IF EXISTS `table`;
CREATE TABLE `table` (
  `id` bigint NOT NULL,
  `name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `region_id` bigint NOT NULL,
  `company_id` bigint NOT NULL,
  `merchant_id` bigint NOT NULL,
  `width` double NOT NULL,
  `height` double NOT NULL,
  `x_pos` double NOT NULL,
  `y_pos` double NOT NULL,
  `guests` tinyint unsigned NOT NULL DEFAULT '0',
  `type` tinyint unsigned NOT NULL,
  `status` tinyint unsigned NOT NULL,
  `is_delete` bit(1) NOT NULL DEFAULT b'0',
  `create_at` datetime(6) NOT NULL,
  `update_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `IX_table_company_id_merchant_id` (`company_id`,`merchant_id`) USING BTREE,
  KEY `IX_table_region_id` (`region_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of table
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for tax
-- ----------------------------
DROP TABLE IF EXISTS `tax`;
CREATE TABLE `tax` (
  `id` bigint NOT NULL,
  `merchant_id` bigint NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `is_percentage` bit(1) NOT NULL DEFAULT b'1',
  `value` decimal(6,3) NOT NULL DEFAULT '0.000',
  `is_delete` bit(1) NOT NULL DEFAULT b'0',
  `create_at` datetime(6) NOT NULL,
  `update_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `IX_tax_merchant_id` (`merchant_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of tax
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for tax_relation
-- ----------------------------
DROP TABLE IF EXISTS `tax_relation`;
CREATE TABLE `tax_relation` (
  `id` bigint NOT NULL,
  `merchant_id` bigint NOT NULL,
  `associated_id` bigint NOT NULL,
  `associated_type` tinyint NOT NULL,
  `tax_id` bigint NOT NULL,
  `create_at` datetime(6) NOT NULL,
  `update_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `IX_tax_relation_merchant_id_associated_id_associated_type` (`merchant_id`,`associated_id`,`associated_type`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of tax_relation
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for terminal
-- ----------------------------
DROP TABLE IF EXISTS `terminal`;
CREATE TABLE `terminal` (
  `id` bigint NOT NULL,
  `merchant_id` bigint NOT NULL,
  `terminal_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `device_type` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `brand` tinyint unsigned NOT NULL,
  `is_available` bit(1) NOT NULL,
  `is_delete` bit(1) NOT NULL DEFAULT b'0',
  `create_at` datetime(6) NOT NULL,
  `update_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `IX_terminal_merchant_id` (`merchant_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of terminal
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for time_period
-- ----------------------------
DROP TABLE IF EXISTS `time_period`;
CREATE TABLE `time_period` (
  `id` bigint NOT NULL,
  `name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `desc` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `company_id` bigint NOT NULL,
  `merchant_id` bigint NOT NULL,
  `day_of_weeks` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `start_time` time(6) NOT NULL,
  `end_time` time(6) NOT NULL,
  `is_delete` bit(1) NOT NULL DEFAULT b'0',
  `create_at` datetime(6) NOT NULL,
  `update_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `IX_time_period_company_id_merchant_id` (`company_id`,`merchant_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of time_period
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for time_period_relation
-- ----------------------------
DROP TABLE IF EXISTS `time_period_relation`;
CREATE TABLE `time_period_relation` (
  `id` bigint NOT NULL,
  `time_period_id` bigint NOT NULL,
  `associated_id` bigint NOT NULL,
  `associated_type` tinyint unsigned NOT NULL,
  `create_at` datetime(6) NOT NULL,
  `update_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `IX_time_period_relation_associated_id_associated_type` (`associated_id`,`associated_type`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of time_period_relation
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for waiting_send_kitchen
-- ----------------------------
DROP TABLE IF EXISTS `waiting_send_kitchen`;
CREATE TABLE `waiting_send_kitchen` (
  `id` bigint NOT NULL,
  `company_id` bigint NOT NULL,
  `merchant_id` bigint NOT NULL,
  `order_id` bigint NOT NULL,
  `order_item_id` bigint NOT NULL,
  `send_kitchen_time` datetime(6) NOT NULL,
  `create_at` datetime(6) NOT NULL,
  `update_at` datetime(6) NOT NULL,
  `device_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `wait_seconds` int NOT NULL DEFAULT '0',
  `is_delete` bit(1) NOT NULL DEFAULT b'0',
  `type` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `IX_waiting_send_kitchen_order_id` (`order_id`) USING BTREE,
  KEY `IX_waiting_send_kitchen_order_item_id` (`order_item_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of waiting_send_kitchen
-- ----------------------------
BEGIN;
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
