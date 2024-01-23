# -*- encoding: GBK -*-
from utils import mysql


if __name__ == '__main__':
    mysql = mysql.Mysql()
    with open('./resources/rk.txt', 'r', encoding='GBK') as f:
        while True:
            ss = f.readline().split(",")
            if len(ss) != 1:
                schoolName = ss[0].strip()
                RK = ss[1].strip()
                if RK == 'null':
                    RK = 0
                sql =f"""update wx_school set RK = {RK} where school_name = '{schoolName}'"""
                mysql.update(sql)
            else:
                break
        mysql.commit()

    with open('./resources/qs.txt', 'r', encoding='GBK') as f:
        while True:
            ss = f.readline().split(",")
            if len(ss) != 1:
                schoolName = ss[0].strip()
                QS = ss[1].strip()
                if QS == 'null':
                    QS = 0
                sql =f"""update wx_school set QS = {QS} where school_name = '{schoolName}'"""
                mysql.update(sql)
            else:
                break
        mysql.commit()

    mysql.close()

