BEGIN;
ALTER TABLE `order_item`
    ADD COLUMN `points_price` int unsigned NOT NULL DEFAULT '0';

ALTER TABLE `order`
    ADD COLUMN `total_point_amount` int unsigned NOT NULL DEFAULT '0';
COMMIT;