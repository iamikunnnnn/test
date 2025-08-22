-- 创建一个"用户购买行为分析"视图，包含：
-- 用户ID、用户名、订单数、购买商品种类数、总消费金额
-- （参考上面的视图示例，尝试自己实现）

CREATE VIEW view_purchase_analysis AS (
SELECT  users.user_id,users.username,订单表统计.订单数
FROM users
    LEFT JOIN (SELECT user_id,COUNT(*) AS '订单数' FROM orders GROUP BY user_id) AS 订单表统计
    ON  users.user_id = 订单表统计.user_id
                                      )
.............todo