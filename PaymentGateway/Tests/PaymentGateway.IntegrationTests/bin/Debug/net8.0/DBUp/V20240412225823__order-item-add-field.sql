BEGIN;
alter table `order_item`
    add `charge_amount` decimal(12, 2) NOT NULL DEFAULT 0.00;

alter table `order_item`
    add `discount_amount` decimal(12, 2) NOT NULL DEFAULT 0.00;
COMMIT;