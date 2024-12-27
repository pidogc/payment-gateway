BEGIN;
alter table `merchant`
    add COLUMN `server_mode` bit(1) NOT NULL DEFAULT b'0';
COMMIT;