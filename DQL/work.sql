# 1.查询每个班级身高最高的学生信息
# - 要求显示班级名称、学生姓名、身高
# - 按班级名称排序
SELECT students.id,classes.name,students.name,height FROM students
INNER JOIN classes ON students.cls_id=classes.id
INNER JOIN (SELECT cls_id,MAX(height) AS '最高身高' FROM students GROUP BY cls_id)AS cls_max_height
## 一个保证班级正确,班级对应的情况下再取选择身高为最高身高的人
ON cls_max_height.cls_id = students.cls_id AND students.height = cls_max_height.最高身高
ORDER BY students.id;

# 2.查询教师带班数量统计
# - 显示教师姓名、带班数量
# - 只显示带班数量大于等于1的教师
# - 按带班数量降序排列
SELECT teachers.id,
       teachers.name,
       COUNT(classes.id) AS 带班数量
FROM teachers
JOIN classes ON teachers.id = classes.teacher_id
GROUP BY teachers.id, teachers.name
ORDER BY 带班数量 DESC;   -- 按带班数量降序排列

# 3.查询学生年龄分布情况
# - 按12岁为一个年龄段分组统计
# - 1-12        少年
# - 13-24    青少年
# - 25-36    青年
# - 37-48    中年
# - 49-60    中老年
# - 显示年龄段、学生人数、占总人数百分比

SELECT COUNT(*) AS '学生人数',
    CASE
        WHEN students.age BETWEEN 1 AND  12 THEN '少年'
        WHEN students.age BETWEEN 13 AND  24  THEN '青少年'
        WHEN students.age BETWEEN 25 AND  36  THEN '青年'
        WHEN students.age BETWEEN 37 AND  48  THEN '中年'
        WHEN students.age BETWEEN 49 AND  60  THEN '中老年'
        ELSE '其他'
    END AS 年龄段,
    # OVER() 表示在所有分组结果的基础上，再把 COUNT(*) 加总，但并不进行聚合，保留在每个分组行上)。
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(), 2) AS 占比百分比,
    SUM(COUNT(*)) OVER()

FROM students
GROUP BY 年龄段;

# 4.查询班级间的身高差异
# - 计算每个班级的最高、最低和平均身高
# - 计算全校平均身高
# - 显示班级身高与全校平均身高的差值

SELECT
    cls_id AS 班级,
    MAX(height) AS 最高身高,
    MIN(height) AS 最低身高,
    AVG(height) AS 平均身高,
    AVG(AVG(height)) OVER(),
    ROUND(AVG(height) - AVG(AVG(height)) OVER(), 2) AS 与全校平均身高差
FROM students
GROUP BY cls_id;

# 5.查询没有学生的班级及其班主任信息
# - 使用LEFT JOIN和IS NULL实现
# - 再使用NOT EXISTS实现一次
# - 比较两种方法的执行计划

SELECT classes.id,classes.name,teachers.id,teachers.name
FROM teachers
LEFT JOIN classes ON classes.teacher_id = teachers.id
LEFT JOIN students ON classes.id = students.cls_id
WHERE classes.id IS NULL;


SELECT *
FROM teachers
LEFT JOIN classes ON classes.teacher_id = teachers.id
LEFT JOIN students ON classes.id = students.cls_id
WHERE NOT EXISTS(SELECT 1 FROM classes WHERE classes.teacher_id = teachers.id)



