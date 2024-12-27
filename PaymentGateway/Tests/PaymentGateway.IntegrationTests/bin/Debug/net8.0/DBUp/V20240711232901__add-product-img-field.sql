BEGIN;
alter table `product`
    add COLUMN `img` varchar(255) NOT NULL default '';
COMMIT;