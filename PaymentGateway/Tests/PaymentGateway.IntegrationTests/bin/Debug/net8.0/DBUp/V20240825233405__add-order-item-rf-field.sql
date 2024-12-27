BEGIN;
alter table `order_item`
    add column `sales_unit_factor` decimal(8, 2) NOT NULL DEFAULT '1.00',
    add column `sales_unit_factor_list` varchar(1024) NOT NULL DEFAULT '[]',
    add column `sale_unit_type` tinyint NOT NULL DEFAULT 0;
COMMIT; 