BEGIN;
alter table `order`
    MODIFY `serial` bigint NOT NULL;
COMMIT;