BEGIN;
alter table `subscription_report`
    add `send_email_update_at` datetime(6) DEFAULT NULL;
COMMIT;