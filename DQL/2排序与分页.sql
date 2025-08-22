# SELECT 列名 FROM 表名
# [WHERE 条件]
# [ORDER BY 列名 [ASC|DESC]]
# [LIMIT 偏移量, 行数];

# ================================================排序========================================================
# [ORDER BY 列名 [ASC|DESC]]
# 以身高进行默认排序【升序】
SELECT * FROM students
ORDER BY height;

# ASC升序
SELECT * FROM  students
ORDER BY height ASC;

# DESC降序
# 单列条件降序
SELECT * FROM students
ORDER BY height DESC ;

# 多列条件降序,以下结果为先按照height排序，若height相同，则相同的几行按照cls_id排序。
SELECT * FROM students
ORDER BY height,cls_id DESC ;

# =================================================分页========================================================
# [LIMIT 偏移量, 行数];

# --------------------一个参数两个值-----------------------
# （可以只用这一个方法，后面的都可以用这种方法实现）
# 2表示从第2+1行开始查询，5表示要查询的量，如果查询完了还没到5行直接显示。
SELECT * FROM students
LIMIT 2,5;

# ---------------一个参数一个值--------------------------
# LIMIT只有一个值:3,表示查询1班年龄最大的前三名学生，LIMIT的参数只有一个时只表示行数，等价于LIMIT 0,3
SELECT * FROM students
WHERE cls_id = 1
ORDER BY age DESC

LIMIT 3;

# -------------------------两个参数两个值--------------------------------
# 分页查询学生信息
SELECT students.id AS '学号',students.name AS '姓名',students.age AS'年龄', classes.name AS '班级',teachers.name AS '班主任'
FROM teachers
JOIN classes
JOIN students

# 3个一页,偏移6个表示翻过去两页,取第三页 .效果等效于LIMIT 6 3
LIMIT 3 OFFSET 6 # .效果等效于LIMIT 6 3