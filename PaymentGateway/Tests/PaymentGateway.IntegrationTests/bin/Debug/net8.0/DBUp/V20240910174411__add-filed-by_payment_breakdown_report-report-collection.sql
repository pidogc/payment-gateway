BEGIN;
alter table `report_collection`
    add `by_payment_breakdown_report` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL;
COMMIT;