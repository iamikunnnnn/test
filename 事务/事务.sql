-- 开始一个购物事务
START TRANSACTION;  -- 或 BEGIN

# 1.检查商品库存
# 重要注意点:一定要给库存添加锁机制 使用UPDATE
# FOR UPDATE 会在查询的行上放置排他锁，防止其他事务对这些行进行更新或删除操作。在提交或回滚后才会解锁排他锁
SELECT products.stock FROM products WHERE product_id =1 FOR UPDATE ;

# 2. 扣减库存
UPDATE products SET stock = stock-1
WHERE product_id = 1 AND stock>=1;

# 3.创建订单
INSERT INTO orders(user_id, order_time, total_amount, status)
VALUE(1,NOW(),5000.00,1);

# 4.添加订单明细表
# SET @last_order_id = LAST_INSERT_ID() # 可将LAST_INSERT_ID()的返回值赋值给@last_order_id
INSERT INTO order_detail(order_id, product_id, product_name, product_price, quantity)
VALUE (LAST_INSERT_ID(),1,'华为手机',5000.00,1);

COMMIT;  -- 确认执行
SELECT '订单创建成功' AS result;

-- 检查受影响的行,Affected rows 决定是提交还是回滚
-- 基本的查询 这里的 IF ELSE 是不可使用的,直接提交即可
# IF ROW_COUNT()>0 THEN
#     COMMIT;  -- 确认执行
#     SELECT '订单创建成功' AS result;
# ELSE
#     ROLLBACK; -- 取消所有操作
#     SELECT '库存不足,订单创建失败' AS result;
# END IF