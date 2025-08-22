# 1 查询1班身高前三的学生
SELECT students.cls_id,MAX(students.height)
FROM students
group by cls_id;

# 2 统计每个班级的女生认数
SELECT students.gender,COUNT(*)
FROM students
WHERE gender='女'
GROUP BY gender;

# 3 查询每个班级的学神认数及平均年龄
SELECT students.cls_id,classes.name AS '班级名字',COUNT(*) AS '学生人数',AVG(age) AS '平均年龄'
FROM students
LEFT JOIN classes ON classes.id=students.cls_id
group by students.cls_id;

# 4 查询身高超过班级平均身高的学生
## 选择需要的列
SELECT students.cls_id ,students.name,students.height,avg_height_table.平均身高
## 先获取学生表
FROM students
    ## 创建班级平均身高临时表
    INNER JOIN (
        SELECT students.cls_id,AVG(students.height) AS '平均身高'
        FROM students
        group by students.cls_id
) AS avg_height_table
ON avg_height_table.cls_id=students.cls_id # 基于班级id合并
WHERE students.height>avg_height_table.平均身高 # 筛选高于平均升高的
ORDER BY students.cls_id,students.height DESC ;

# 5 查询教师及其负责班级的学生人数
SELECT teachers.name AS '教师名',
       count_table.班级人数 AS '班级人数',
       classes.id AS '教室id',
       classes.name AS '教室名',
    CASE
        WHEN count_table.班级人数 >= 30 THEN '大班'
        WHEN count_table.班级人数 BETWEEN 15 AND 29 THEN '中班'
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

# 6 查询有学生的班级(EXISTS)
SELECT * FROM classes
# ** SELECT 1 ** 是一种习惯写法，表示表示是否有记录返回，意思就是WHERE满足时返回1
WHERE EXISTS( SELECT 1 FROM students WHERE students.cls_id = classes.id); # 外部查询已经获取了classes，这里可以直接用

# 7 查询没有担任班主任的教师(NOT EXISTS)
SELECT teachers.name FROM teachers
WHERE NOT EXISTS (SELECT 1 FROM classes WHERE classes.teacher_id = teachers.id);




# 8 分页查询学生信息
SELECT students.id AS '学号',students.name AS '姓名',students.age AS'年龄', classes.name AS '班级',teachers.name AS '班主任'
FROM teachers
JOIN classes
JOIN students
LIMIT 3 OFFSET 6

