import pymysql



class MysqlHandler(object):
    def __init__(self,host,user,passwd,db,charset='utf8',port=3306):
        self.conn = None
        self.cursor = None
        self.host = host
        self.user = user
        self.passwd = passwd
        self.db = db
        self.charset = charset
        self.port = port

    def connect(self):
        self.conn = pymysql.connect(
            host=self.host,
            user=self.user,
            passwd=self.passwd,
            db=self.db,
            charset=self.charset,
            port=self.port
        )
        self.cursor = self.conn.cursor()

    def disconnect(self):
        self.conn.close()
        self.cursor.close()

    def execute_sql (self,sql,params=None):
        """
        用于sql操作
        :param sql: sql语句
        :param params:占位符需要填入的数据
        :return: 受影响的行数 , 查询结果
        """
        count = None
        try:
            self.connect()
            count = self.cursor.execute(sql,params)
            result = self.cursor.fetchall()
            self.disconnect()
            return count,result
        except Exception as e:
            print(e)

class BookSystem:
    def __init__(self):
        self.db = MysqlHandler(host='localhost', user='root', passwd='iamikun', db='book_system') # HAS-A关系
        self.login_status = None
    def user_register(self):
        username = input("请输入用户名：")
        password = input("请输入密码：")

        # 查询用户名是否存在重复,如果重复则说明用户已经注册过了
        count_query,result_query = self.db.execute_sql("select username from book_system.users WHERE username=%s",(username,))
        if result_query[0][0] == username:
            print("该账号已注册，请重试")
            return False

        # 执行插入操作
        count,result = self.db.execute_sql("insert into book_system.users (username,password) values (%s,%s)",
                              [username, password])
        # 检测是否注册成功
        if count > 0:
            print("注册成功")
        else:
            print("注册失败,请重新注册")

    # 登录
    def user_login(self):

        username = input("请输入用户名：")
        password = input("请输入密码：")

        # 执行查询操作
        count,result = self.db.execute_sql("select count(*) from book_system.users where username=%s and password=%s",
                                 [username, password])
        # print(count)

        if count> 0:
            print("登录成功")
            self.login_status=True
        else:
            print("登录失败,请重新登录")
    
    def borrow(self,username,book_name):
        if self.login_status is True:
            username,input("请输入用户名")
            book_name,input("请输入书名")

        else:
            print("还未登录，请登录")
            return