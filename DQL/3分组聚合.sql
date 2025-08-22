# ========================================聚合===================================================
# 统计学生总数
SELECT COUNT(*) FROM students;

# 取列名
SELECT COUNT(*) AS '学生总人数' FROM students;

# 计算学生的平均身高
SELECT AVG(height) AS '平均身高' FROM students;

#==========================================分组聚合===================================================
# (分组聚合时SELECT里的值必须是*聚合函数*或者*用于分组的列*,有别的列会报错)
# (**分组聚合的目的就是根据分组的结果进行聚合函数，如对每个组求均值**)
# 计算学生表中每个班级的平均身高
SELECT cls_id,AVG(height) AS '平均身高' FROM students
GROUP BY cls_id;

#--------------------OVER的使用(窗口函数)-----------------------
# (over() 就表示用聚合函数计算,但不进行分组(groupby)的压缩,结果只会加一列数据)
SELECT cls_id,AVG(height) OVER() AS '平均身高' FROM students;

# OVER 例2
# 如果跟在groupby+聚合后面,比如下面的例子成为了第一列id,第二列height(每个班的平均身高),
# 此时我再加一个MAX(AVG(height)) OVER(),就表示组之间的最大值算好了另起一列,每一列都是组之间的最大值
# **可以对某个组算很多个统计值,比如最大值最小值,然后通过OVER的方式二次运算,比如算最大值和最小值的差**
SELECT cls_id,AVG(height) AS '平均身高' ,MAX(AVG(height)) OVER() FROM students
group by cls_id;

# OVER 例3
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
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(), 2) AS 占比百分比
FROM students
GROUP BY 年龄段;

# 显示学生表中每个班级的最大年龄的学生姓名和对应的年龄--------------------(报错，修正版见4连接查询)
SELECT students.cls_id,MAX(students.age) AS '最大年龄',students.name  FROM students
GROUP BY students.cls_id;


