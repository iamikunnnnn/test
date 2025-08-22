-- 分析以下查询需要哪些索引
SELECT
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