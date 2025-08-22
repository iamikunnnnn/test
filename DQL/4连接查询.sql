# （连接可以嵌套多个，比如A连B，C连AB的结果，D连ABC的连接结果）

# ========================================内连接====================================================
#  (内连接是返回连接表中符合连接条件记录的连接查询。)
# **隐式内连接**
# 语法格式：
# SELECT  字段  FROM  表1
# INNER JOIN  表2
# ON  连接条件
# [WHERE 条件]

# **显式内连接**
# 语法格式：
# SELECT  字段
# FROM  表1,表2
# WHERE 表1.条件=表2.条件

#-----------------------------------普通内连接---------------------------------------
# 下面的逻辑是先内连接，按照ON 后面的条件，最后选择的是students.name 和classes.name两列。
# 只取两张表中的两列：之所以FROM students但是可以SELECT classes.name ，是因为下面INNER JOIN了classes，如果下面没有连接这样写就是错误的，
SELECT students.name AS '学生名',classes.name AS '课程名' FROM students
# 以 students 为主表，内连接 classes 表。
INNER JOIN classes
# 匹配规则：把学生表里的 cls_id 与班级表里的主键 id 相等作为关联条件。
ON students.cls_id = classes.id;

# -----------------------在在表内部聚合的临时表并最后join到原表--------------------------
# 先聚合再join主要用于两种情况：一是需要基于聚合结果进行过滤或关联时（如只要平均分>80的班级学生，或查找每组最值记录），二是多层聚合统计时（如先按部门聚合再按地区聚合）。
# 显示学生表中每个班级的最大年龄的学生姓名和对应的年龄（修正版）
SELECT students.cls_id,students.name,students.age AS '最大年龄',students.name  FROM students
    # INNER JOIN一个临时的表（各个班级的最大年龄）
    INNER JOIN (
    SELECT students.cls_id,MAX(age) AS '最大年龄' FROM students
    GROUP BY cls_id
) AS max_age_table
# id和年龄都要匹配，各个班级的最大年龄对应到原表的信息
ON students.cls_id = max_age_table.cls_id AND students.age = max_age_table.最大年龄;

#--------------------------join on 后直接groupby-----------------------
# （适用于不强制需要对聚合结果join的情况和单层聚合的情况）
# 查询每个班级的学生人数及平均年龄
SELECT students.cls_id,classes.name AS '班级名字',COUNT(*) AS '学生人数',AVG(age) AS '平均年龄'
FROM students
LEFT JOIN classes ON classes.id=students.cls_id
group by students.cls_id;

#---------------------非显式连接-------------------------
# 非显式内连接，与显式内连接效果一样，**不建议使用**，语义不如显式的清楚
# SELECT students.name AS '学生名' ,classes.name AS '班级名' FROM students,classes
# where students.cls_id = classes.id;

# ========================================外连接====================================================
#----------------左外连接----------------------
# 语法格式：(outer建议省略，LEFT JOIN即可)
# SELECT  字段  FROM  表1
# LEFT [outer]  JOIN  表2
# ON  连接条件
# [WHERE 条件];

# (左外连接是以左表为基表，返回左表中所有记录及连接表中符合条件的记录的外连接。)
SELECT teachers.name AS '教师名',  classes.name AS'所带班级'
FROM teachers
LEFT JOIN classes
ON teachers.id = classes.teacher_id;

#----------------右外连接----------------------
# （与左外连接相同，右外连接是以右表为基表，返回右表中所有记录及连接表中符合条件的记录的外连接。）
# 语法格式：
# SELECT  字段  FROM  表1
# RIGHT [outer] JOIN  表2
# ON  连接条件
# WHERE 条件
SELECT teachers.name AS '班级教师',  classes.name AS'班级名'
FROM teachers
# 以右表为基表
RIGHT JOIN classes
ON teachers.id = classes.teacher_id;

# (SQL还有一种全连接，但mysql不支持)

# ======================================子查询========================================
# -------------------------基本子查询-------------------------------
# 查询比刘德华高的同一个班的学生信息
SELECT * FROM students
WHERE
    height>(SELECT height FROM students WHERE name = '刘德华') AND
    cls_id=(SELECT cls_id FROM students WHERE name = '刘德华');

# -------------------------ANY/SOME 子查询--------------------------------
# （ANY/SOME：子查询返回一组值，主查询只需与其中任意一个值满足比较条件即可。）

# 查询身高高于 任意一个2班的学生身高的学生信息
SELECT cls_id ,name,height
FROM students
# 子查询返回了多个值，不能用基本的子查询，这里采用ANY
WHERE height > ANY (SELECT height FROM students WHERE cls_id=2);

#--------------------------ALL子查询--------------------------------------
# （ALL：子查询返回一组值，主查询必须满足与每一个值的比较条件。）

# 查询身高高于 所有2班的学生身高 的学生信息
SELECT cls_id ,name,height
FROM students
#
WHERE height > ALL (SELECT height FROM students WHERE cls_id=2);

# ------------------------- IN/NOT IN 子查询-------------------------------
# IN 等价于 “= ANY（子查询）”。 | NOT IN 等价于 “<> ALL（子查询）”（注意不是 “<> ANY”）。

# ------------------------- EXISTS/NOT EXISTS 子查询------------------------------
# 1.（EXISTS/NOT EXISTS相反 ，只要能在某个集合里“找到”/“找不到”至少一个满足条件的元素，就为真。）
# 2.（在子查询中，不返回值，只是判断子循环结果能不能找到, **在查询时会对每一行进行判断**）

# 3. EXISTS的**使用场景**：WHERE只能对表内操作，但EXISTS可以对外表进行判断并返回布尔值，布尔值给WHERE就没问题了

#（ 1.EXISTS可用于删除和创建的判断。）
# 删除指定表格，如果XXXX表存在
DROP TABLE IF EXISTS XXXX;

# 创建表格,如果aaa表不存在
CREATE TABLE IF NOT EXISTS aaa(
    id INT  PRIMARY KEY ,
    name VARCHAR(20)
);

# （2.EXISTS也可用于查询）
# 查询有学生的班级(EXISTS)
SELECT * FROM classes
# ** SELECT 1 ** 是一种习惯写法，表示表示是否有记录返回，意思就是WHERE满足时返回1
WHERE EXISTS( SELECT 1 FROM students WHERE students.cls_id = classes.id); # 外部查询已经获取了classes，这里可以直接用

# 查询没有担任班主任的教师(NOT EXISTS)   （（注意EXISTS实现了同时用两个的字段进行判断，这是单单WHERE做不到的，除非join））
SELECT teachers.name FROM teachers
WHERE NOT EXISTS (SELECT 1 FROM classes WHERE classes.teacher_id = teachers.id);


