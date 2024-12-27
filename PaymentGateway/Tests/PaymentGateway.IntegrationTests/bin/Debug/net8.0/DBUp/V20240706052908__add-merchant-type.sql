BEGIN;
alter table `merchant`
    add COLUMN `type` bit(1) NOT NULL DEFAULT b'0';
COMMIT;