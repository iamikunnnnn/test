import pandas as pd
import pymysql

df = pd.read_csv('data.csv')

# 将数据存入数据库
conn = pymysql.connect(host='localhost', user='root',password="iamikun", database='firstdb', charset='utf8')


# 2. 获取游标
cursor = conn.cursor()

# 3. 创建表
cursor.execute(
"""
CREATE TABLE pandas_data (
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
VALUES  (%s, %s, %s, %s, %s)
"""
# iterrows表示按行遍历，返回行索引和行数据，类似于单列的item()
for _, row in df.iterrows():
    print(row)
    # cursor.execute(sql, [row['name'],row['age'],row['nationality'],row['education'],row['gender']])
    cursor.execute(sql,row.to_list()[1:]) # 排除id，其余转为表格

# 4. 提交
conn.commit()
print("创建淘宝用户表成功")

# 5. 关闭数据库
cursor.close()
conn.close()