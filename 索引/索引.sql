# ============================创建索引===================================
# （注意idx_column1_column2....这个是标准命名，一般都以这个为命名）
-- 创建索引
CREATE INDEX idx_name ON students(name);
-- 创建复合索引
CREATE INDEX idx_name_age ON students(name, age);
-- 创建唯一索引
CREATE UNIQUE INDEX idx_email ON users(tel);

# 还有一个特殊的唯一索引就是主键

# ==============================删除索引======================================
DROP INDEX idx_name ON students;

# ==============================查看索引==================================
SHOW INDEX FROM students;

# ---------------查看索引是否被使用------------
-- 分析一个复杂查询
# 在查询结果中,看type(表示访问类型),若出现ALL表示全表扫描,索引不起作用
# key表示使用到的索引,若为NUL表示没有用到索引
EXPLAIN SELECT
    u.username,
    o.order_id,
    o.order_time,
    od.product_name,
    od.quantity
FROM
    users u
JOIN
    orders o ON u.user_id = o.user_id
JOIN
    order_detail od ON o.order_id = od.order_id
WHERE
    u.user_id = 1
ORDER BY
    o.order_time DESC;

# -------------------------------------分析EXPLAIN 结果分析需要哪些索引----------------------------
    -- 分析以下查询需要哪些索引
EXPLAIN SELECT
    p.product_name,
    SUM(od.quantity) AS total_sold
FROM
    products p
JOIN
    order_detail od ON p.product_id = od.product_id
WHERE
    od.order_id IN (
        SELECT order_id FROM orders
        WHERE order_time BETWEEN '2023-01-01' AND '2023-12-31'
    )
GROUP BY
    p.product_id
ORDER BY
    total_sold DESC;

-- 创建你认为必要的索引


-- 定期分析表
ANALYZE TABLE orders;

# ===================索引的使用和索引设计原则见 视图知识点.md