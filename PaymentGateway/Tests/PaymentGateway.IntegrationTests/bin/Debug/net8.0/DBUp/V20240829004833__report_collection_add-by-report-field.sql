BEGIN;
alter table `report_collection`
    add `by_order_sales_report` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
    add `by_payment_report` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
    add `by_date_report` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL;

COMMIT;