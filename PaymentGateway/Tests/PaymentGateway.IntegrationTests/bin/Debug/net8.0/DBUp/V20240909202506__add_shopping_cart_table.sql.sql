-- 如果 'shopping_cart' 表存在，则先删除
DROP TABLE IF EXISTS `shopping_cart`;
-- 创建 'shopping_cart' 表
CREATE TABLE `shopping_cart`
(
    `id`          BIGINT      NOT NULL COMMENT '购物车的唯一标识',

    `merchant_id` BIGINT      NOT NULL COMMENT '商户的唯一标识',

    `user_id`     varchar(36) NOT NULL COMMENT '用户的唯一标识',

    `create_at`   DATETIME(6) NOT NULL COMMENT '记录的创建时间',

    `update_at`   DATETIME(6) NOT NULL COMMENT '记录的最后更新时间',

    -- 定义主键并使用 BTREE 索引
    PRIMARY KEY (`id`) USING BTREE,

    -- 创建组合索引，基于 user_id 和 merchant_id
    KEY           `IX_user_id_merchant_id` (`user_id`, `merchant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='购物车表，用于存储每个用户的购物车信息';

-- 如果 'shopping_cart_detail' 表存在，则先删除
DROP TABLE IF EXISTS `shopping_cart_detail`;
-- 创建 'shopping_cart_detail' 表
CREATE TABLE `shopping_cart_detail`
(
    `id`          BIGINT NOT NULL COMMENT '购物车详情的唯一标识',

    `cart_id`     BIGINT NOT NULL COMMENT '对应的购物车唯一标识',

    `detail`      LONGTEXT NOT NULL COMMENT '包含整个订单信息的字符串',

    `row_version` BIGINT NOT NULL DEFAULT '0',

    `create_at`   DATETIME(6) NOT NULL COMMENT '记录的创建时间',

    `update_at`   DATETIME(6) NOT NULL COMMENT '记录的最后更新时间',

    -- 定义主键并使用 BTREE 索引
    PRIMARY KEY (`id`) USING BTREE,

    -- 创建索引，基于 shopping_cart_id
    KEY           `IX_cart_id` (`cart_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='购物车详情表，用于存储与购物车相关的订单信息';
