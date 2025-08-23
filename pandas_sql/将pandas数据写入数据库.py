import pandas as pd
import pymysql

df = pd.read_csv('data.csv')
# 将数据存入数据库
conn = pymysql.connect(host='localhost', user='root', password="iamikun", database='firstdb', charset='utf8')
# 2. 获取游标
cursor = conn.cursor()

# 3. 创建表
cursor.execute(
    """
CREATE TABLE IF NOT EXISTS pandas_data (
    id INT PRIMARY KEY AUTO_INCREMENT,  -- 设置自增，下面就不用操作了
    name VARCHAR(50) NOT NULL,
    age INT NOT NULL,
    nationality VARCHAR(50) NOT NULL,
    education VARCHAR(50) NOT NULL,
    gender VARCHAR(10) NOT NULL
);
"""
)

# 4. 循环遍历df然后insert插入数据表中
sql = """
INSERT INTO pandas_data (name, age, nationality,education, gender)
VALUES (%s, %s, %s, %s, %s)

# - 年龄(age) >= 20 的所有数据
"""
sql1 = """
SELECT name,age FROM pandas_data WHERE age>20; 
"""

# - 列举出所有的国家(Native country),及其数量
sql2 = """
SELECT DISTINCT nationality,COUNT(*) FROM pandas_data GROUP BY nationality;
"""

# - 年龄(age) >= 22,且显示的所有男性的年龄(age)大于女性的平均年龄(age)
sql3 = """SELECT *
FROM (
    SELECT *
    FROM pandas_data
    WHERE gender = '女' AND age>=22
) AS filtered_pd
UNION ALL
    SELECT * FROM pandas_data WHERE age>=22 AND gender='男'AND
    age>(SELECT AVG(age) AS 平均年龄 FROM pandas_data WHERE gender='女' GROUP BY pandas_data.gender)

# - 只显示教育长度(education)数量最多,年龄(age)>=22 的数据
"""
sql4 = """SELECT * FROM pandas_data WHERE age>=22 AND 
education=
(SELECT t.education
FROM (
    SELECT education, COUNT(*) AS cnt,
           MAX(COUNT(*)) OVER() AS max_cnt
    FROM pandas_data
    GROUP BY education
) AS t
WHERE cnt = max_cnt
);
"""

sqls = [sql1, sql2, sql3, sql4]
results = []
for sql in sqls:
    count = cursor.execute(sql)
    result = cursor.fetchall()
    results.append(f"{result}")
    print(pd.DataFrame(result))
# print(pd.DataFrame(results))
# iterrows表示按行遍历，返回行索引和行数据，类似于单列的item()
# for _, row in df.iterrows():
#     print(row)
    # cursor.execute(sql, [row['name'], row['age'], row['nationality'], row['education'], row['gender'], row["name"],row["age"]])
    # cursor.execute(sql,row.to_list()[1:]) # 排除id，其余转为表格

# 4. 提交
conn.commit()
print("创建淘宝用户表成功")

# 5. 关闭数据库
cursor.close()
conn.close()
