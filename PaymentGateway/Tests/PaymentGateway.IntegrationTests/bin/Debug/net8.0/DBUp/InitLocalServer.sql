/*
 Navicat Premium Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 80029 (8.0.29)
 Source Host           : localhost:3306
 Source Schema         : easypos_local

 Target Server Type    : MySQL
 Target Server Version : 80029 (8.0.29)
 File Encoding         : 65001

 Date: 27/03/2024 23:02:00
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

SET FOREIGN_KEY_CHECKS = 1;
