import pymysql

# 1. 拨号连接
connection = pymysql.connect(
    host='localhost',  # 仓库地址
    user='root',       # 仓库管理员
    password='1234',   # 管理员密码
    database='hqyj',   # 指定仓库
    port=3306,         # 仓库门牌号
    charset='utf8'     # 沟通语言
)

# 2. 获取游标
cursor = connection.cursor()

# 3. 发送指令
cursor.execute("SELECT * FROM users;")
# cursor.execute("SELECT * FROM users WHERE user_name=%s;", ["张三"])
# cursor.execute("SELECT * FROM users WHERE user_name=%(name)s;", {"name":"张三"})

# 4. 听回复
print(cursor.fetchall())  # 获取所有结果

# 5. 挂电话（务必记得！）
cursor.close()
connection.close()