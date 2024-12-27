BEGIN;
alter table `subscription_report`
    add `timezone_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'America/Los_Angeles';
COMMIT;