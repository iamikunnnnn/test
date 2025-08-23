
import pymysql

# 1. 拨号连接
connection = pymysql.connect(
    host='localhost',  # 仓库地址
    user='root',       # 仓库管理员
    password='iamikun',   # 管理员密码
    database='book_system',   # 指定仓库
    port=3306,         # 仓库门牌号
    charset='utf8'     # 沟通语言
)

# 2. 获取游标
cursor = connection.cursor()


# 3. 发送指令
count =cursor.execute(
"""
CREATE TABLE IF NOT EXISTS users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(20) NOT NULL UNIQUE,
    password VARCHAR(20) NOT NULL
);

"""
)

# 4. 提交
connection.commit()
print("创建淘宝用户表成功")

# 5. 关闭数据库
cursor.close()
connection.close()