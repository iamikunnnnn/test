# SELECT 列名 FROM 表名 [WHERE 条件];

# FROM 的本质其实是**获取**某个表，有了这个表可以SELECT这个表的任何列并且进行任何操作，如果要进行别的表的操作就连接别的表来获取另一个表

# =========================================基本查询================================================
# '*'表示所有,查询所有学生的所有信息
SELECT * FROM students;

# 查询所有学生的名字
SELECT name FROM students;

# 查询所有学生的名字和年龄
SELECT name,age FROM students;

# ===========================================条件查询==============================================

# ------------比较--------------------
SELECT * FROM students
WHERE age >18;

# -----------逻辑---------------------
SELECT * FROM students
WHERE height>160 AND gender='女';

# -----------------------模糊匹配,LIKE/NOT LIKE表示不匹配（用的是简化版的通配符模式匹配）------------------------------
# %	匹配任意长度（包括 0 个）的任意字符
# _	匹配任意单个字符
# [] 匹配括号内指定范围的一个字符，例如[0-9]只要能匹配范围内任意字符即可，[^0-9]表示不匹配范围内任意字符
SELECT * FROM students
WHERE name LIKE '周%';

# 范围1
SELECT * FROM students
WHERE id IN (1,3,5);

# 范围2
SELECT * FROM students
WHERE height BETWEEN 160 AND 180;

# 空值判断，非空为IS NOT NULL
SELECT * FROM students
WHERE height IS NULL ;


# --------------------------分支语句CASE,类似if else--------------------

# 查询教师及其负责班级的学生人数
SELECT teachers.name AS '教师名',
       count_table.班级人数 AS '班级人数',
       classes.id AS '教室id',
       classes.name AS '教室名',
    CASE
        WHEN count_table.班级人数 >= 30 THEN '大班'
        WHEN count_table.班级人数 BETWEEN 15 AND 29 THEN '中班'  # #(CASE中WHEN的内部的逻辑可用BETWEEN AND)-----
        WHEN count_table.班级人数 < 15  THEN '小班'
        ELSE '未知'
    END                         AS 班型
# 获取teacher表，用于获取教师名，且可通过教师id与班级表连接
FROM teachers
# 根据班级id连接class，获取class表，此时获得了每个老师所带的班级，现在就差人数了
LEFT JOIN classes ON teachers.id = classes.teacher_id
    # 创建一个统计班级人数的临时表
    LEFT JOIN(
    SELECT COUNT(*) AS '班级人数',students.cls_id
    FROM students
    GROUP BY students.cls_id)AS count_table
    # 根据班级id将人数统计结果并入总表
    ON classes.id=count_table.cls_id;