-- 练习：实现一个完整的图书借阅创建事务，包含：
-- 1. 检查库存
-- 2. 扣减库存
-- 3. 创建订单
-- 4. 添加订单明细
-- 5. 根据结果提交或回滚
-- （参考上面的购物事务示例，尝试自己实现）

START TRANSACTION;

# 找到id为1的书的库存并在事务期间上锁
SELECT books.stock
FROM books WHERE book_id = 1 FOR UPDATE ;

UPDATE books SET stock = stock-1
WHERE book_id = 1 AND stock>= 1;

INSERT INTO borrow_records( reader_id, book_id, borrow_time, status)
VALUE (10,8,NOW(),0);

COMMIT ;
SELECT '借阅成功' AS result








