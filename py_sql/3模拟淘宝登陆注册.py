import pymysql

'''
数据库的帮助手册
'''


class MysqlHelper():
    def __init__(self, host, user, password, database, port=3306, charset="utf8"):
        self.host = host
        self.user = user
        self.password = password
        self.database = database
        self.port = port
        self.charset = charset

    def connect(self):
        self.connection = pymysql.connect(host=self.host,
                                          user=self.user,
                                          password=self.password,
                                          database=self.database,
                                          port=self.port,
                                          charset=self.charset)
        self.cursor = self.connection.cursor()

    def close(self):
        self.cursor.close()
        self.connection.close()

    # 在登录注册中，可能涉及到的SQL操作有哪些？
    def insert(self, sql, params=None):
        count = None
        try:
            self.connect()  # 连接
            count = self.cursor.execute(sql, params)  # 执行SQL语句，返回受影响记录行数
            self.connection.commit()  # 提交
            self.close()  # 关闭
        except Exception as e:
            print(e)
        return count  # 这里的count为受影响的记录的行数

    def fetch_one(self, sql, params=None):
        count = None
        try:
            self.connect()  # 连接
            self.cursor.execute(sql, params)  # 执行SQL语句
            count = self.cursor.fetchone()  # 获取一条记录，# 注意这里的返回值count是一行记录，例如（1，'张三'，1234），
            self.close()  # 关闭
        except Exception as e:
            print(e)
        return count


'''
定义用户类，用户会执行 注册 和 登录 功能
'''


class Person():
    # 注册
    def register(self):
        name = input("请输入用户名：")
        password = input("请输入密码：")
        # 点击注册按钮，发送数据 到 数据库
        helper = MysqlHelper(host='localhost', user='root', password='iamikun', database='firstdb')
        # 注意这里的count为受影响的记录的行数，与login不同
        count = helper.insert("insert into tb_users (username,password) values (%s,%s)",
                              [name, password])
        # 检测是否注册成功
        if count > 0:
            print("注册成功")
        else:
            print("注册失败,请重新注册")

    # 登录
    def login(self):
        name = input("请输入用户名：")
        password = input("请输入密码：")
        # 点击登录按钮，从数据库中 获取 数据
        helper = MysqlHelper(host='localhost', user='root', password='iamikun', database='firstdb')
        # 注意这里的返回值count是一行记录，例如（1，'张三'，1234），我们只要判断id是否>0，来判断是否登陆成功，所以用下面count[0]
        count = helper.fetch_one("select count(*) from tb_users where username=%s and password=%s",
                                 [name, password])
        # print(count)

        if count[0] > 0:
            print("登录成功")
        else:
            print("登录失败,请重新登录")


if __name__ == "__main__":
    while True:
        print("======淘宝页面======")
        print("1. 注册")
        print("2. 登录")
        print("0. 退出")
        choice = input("请输入你要进行的操作：")
        user = Person()
        if choice == "1":
            user.register()
        elif choice == "2":
            user.login()
        elif choice == "0":
            break
        else:
            print("请等待版本更新....")
