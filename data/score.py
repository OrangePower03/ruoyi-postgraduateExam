# -*- encoding: GBK -*-
from utils import mysql


# 没啥用的东西，就一测试
def testPrint(score: [str]):
    year = score[0]
    all = score[6]
    english = score[7]
    politics = score[8]
    math = score[9]
    majorScore = score[10]
    print(year, end=' ')
    print(all, end=' ')
    print(english, end=' ')
    print(politics, end=' ')
    print(math, end=' ')
    print(majorScore)


# 因为有两组数据，所以得重复运行两次
def mainCode(file):
    connect: [tuple, int] = {}
    connection = mysql.Mysql(host='127.0.0.1', user='root', password='123123', database='jsjds')
    connection1 = mysql.Mysql(host='127.0.0.1', user='root', password='123123', database='jsjds')
    selectSql = """select * from wx_mcd"""
    connection.selectOne(selectSql)
    for c in connection.cursor:
        connectId = c[0]
        majorId = c[1]
        departmentId = c[2]
        schoolId: int
        selectSql = f"""select department_school_id from wx_department where department_id={departmentId}"""
        schoolId = int(connection1.selectOne(selectSql))
        connect[(majorId, schoolId)] = connectId

    connection2 = mysql.Mysql('127.0.0.1', 'root', '123123', 'jsjds')
    while True:
        score: [str] = file.readline().split(',')
        if len(score) == 1:
            break
        year = score[0]
        majorName = score[2]
        schoolName = score[4]
        all = score[6]
        english = score[7]
        politics = score[8]
        math = score[9]
        majorScore = score[10]
        # testPrint(score)
        selectSql = f"""select major_id from wx_major where major_name='{majorName}'"""
        majorId = int(connection2.selectOne(selectSql))
        selectSql = f"""select school_id from wx_school where school_name='{schoolName}'"""
        schoolId = int(connection2.selectOne(selectSql))
        # print(f"专业id：{majorId}，学校id：{schoolId}")
        connectId = connect.get((majorId, schoolId))
        if connectId is not None:
            # print(connectId)
            sql = f"""insert into wx_score(score_year,score_all,score_english,score_politics,score_math,score_major,connect_id)
                    values({year},{all},{english},{politics},{math},{majorScore},{connectId})"""
            connection2.insertSql(sql)

    file.close()
    connection.close()
    connection1.close()
    connection2.close()


if __name__ == '__main__':
    path = './resources/score/data_2022.txt'
    file = open(path, 'r', encoding='GBK')
    mainCode(file)
    path = './resources/score/data_2023.txt'
    file = open(path, 'r', encoding='GBK')
    mainCode(file)
