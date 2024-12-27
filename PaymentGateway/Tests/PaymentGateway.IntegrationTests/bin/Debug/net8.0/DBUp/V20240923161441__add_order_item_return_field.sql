BEGIN;
ALTER TABLE `order_item_return`
    ADD COLUMN `return_amount` decimal(8, 2) NOT NULL;
COMMIT;