import pymysql

# 1. 连接
connection = pymysql.connect(
    host='localhost',
    user='root',
    password='iamikun',
    database='firstdb',
    port=3306,
    charset='utf8' # 这行可以不写，不写就会自动使用默认的charset
)

# 2. 获取游标
cursor = connection.cursor()

# 3.发送指令  (可以只用一对引号单行写SQL，但是三引号的块字符串多行写比较舒服)
cursor.execute("""
SELECT * FROM users 
INNER JOIN orders 
ON users.user_id = orders.user_id 
WHERE username IN (%s,%s);
""",["张三","李四"]) # %s进行占位，这里会把张三填入%s

# 4. 获得结果
result = cursor.fetchall()
print(result)

# 5. 关闭连接
cursor.close()