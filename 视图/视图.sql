# ===============================================创建视图===================================
# 视图操作语句
# 语法格式：
# CREATE VIEW 视图名 AS  复杂查询语句
CREATE VIEW student_info_view AS (
SELECT students.name AS '学生名',
       students.id AS '学生id',
       classes.name AS '班级名',
       teachers.name AS '班主任'

FROM students
LEFT JOIN classes ON students.cls_id=classes.id
LEFT JOIN teachers ON teachers.id=classes.teacher_id
                                 );

-- 商品销售统计视图
CREATE VIEW v_product_sales AS
SELECT
    p.product_id,
    p.product_name,
    SUM(od.quantity) AS total_sold,
    SUM(od.quantity * od.product_price) AS total_revenue,
    p.stock
FROM
    products p
LEFT JOIN
    order_detail od ON p.product_id = od.product_id
GROUP BY
    p.product_id;

# ===================================================结合视图查询=========================================

#-------------用视图简化查询-----------------------------------
SELECT * FROM student_info_view WHERE 学生名='猪猪侠';

-- 查询热销商品
SELECT * FROM v_product_sales ORDER BY total_sold DESC LIMIT 5;

# ====================================================修改视图（增删改）==========================================

# ---------------给视图添加字段？-------------------------
# MYSQL中没有专门的ALTER VIEW的语句，如果想添加字段，先drop原视图，再创建新视图
# 删除视图
DROP VIEW IF EXISTS student_info_view;

# 在视图中添加年龄
CREATE VIEW student_info_view AS (
SELECT students.name AS '学生名',
       students.id AS '学生id',
       classes.name AS '班级名',
       teachers.name AS '班主任',
       students.age AS '年龄'

FROM students
LEFT JOIN classes ON students.cls_id=classes.id
LEFT JOIN teachers ON teachers.id=classes.teacher_id
                                 );

# -------------更新数据表，视图会自动更新----------------------

INSERT INTO orders (user_id, order_time, total_amount, status)
## NOW() 是时间函数
VALUES (2, NOW(), 199.00, 0);

# --------------更新视图---------------
# 视图更新有限制,只能基于单表,但一般不会主动更新视图数据

# ---------------
# 视图可以嵌套