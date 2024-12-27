BEGIN;
alter table `order_item`
    add `category_name` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL;

alter table `order_item`
    add `menu_name` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL;
COMMIT;