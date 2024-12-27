BEGIN;

ALTER TABLE `order_query`
    ADD `member_id` VARCHAR(50) NOT NULL DEFAULT '' COMMENT '订单的会员标识';

CREATE INDEX idx_member_id ON `order_query` (`member_id`);

COMMIT;