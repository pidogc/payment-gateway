BEGIN;
ALTER TABLE `order_item`
    add COLUMN `img` varchar(255) NOT NULL default '';
COMMIT;