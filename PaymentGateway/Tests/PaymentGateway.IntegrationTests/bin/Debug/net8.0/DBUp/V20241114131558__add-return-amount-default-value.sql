BEGIN;
ALTER TABLE order_item_return
    ALTER COLUMN return_amount SET DEFAULT 0.00;
COMMIT;