import pymysql


class Mysql:
    connection = None
    cursor = None

    def __init__(self, host='127.0.0.1', user='root', password='123123', database='jsjds'):
        self.connection = pymysql.connect(
            host=host,          # 数据库主机
            user=user,          # 数据库用户名
            password=password,  # 数据库密码
            database=database,  # 数据库名称
            port=3306,
            charset='utf8'
        )
        self.cursor = self.connection.cursor()

    def insert(self, sql, data):
        self.cursor.execute(sql, data)
        self.connection.commit()

    def insertSql(self, sql):
        self.cursor.execute(sql)
        self.connection.commit()

    def close(self):
        self.cursor.close()
        self.connection.close()

    def selectOne(self, sql) -> str or None:
        self.cursor.execute(sql)
        result = self.cursor.fetchone()
        if result is None:
            return '-1'
        return result[0]

    def update(self, sql):
        self.cursor.execute(sql)
        self.connection.commit()

    def commit(self):
        self.connection.commit()



