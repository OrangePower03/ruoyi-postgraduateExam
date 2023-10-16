# -*- coding: GBK -*-
import requests
from utils import mysql

path = './resources/school_major.txt'
file = open(path, 'r', encoding='GBK')
headers = {
    'user-agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/117.0.0.0 Safari/537.36',
    'Content-type': 'application/json;charset=UTF-8',
}


def getSchoolList() -> dict or None:
    url = 'http://localhost/dev-api/user/school/schoolList'
    response = requests.get(url,headers=headers)
    if response.ok:
        school_id = dict()
        dictList: [dict] = response.json()['rows']
        for d in dictList:
            school_id[d['schoolName']] = d['schoolId']
        return school_id
    else:
        return None


if __name__ == '__main__':
    with open('./resources/Authorization.txt', 'r', encoding='UTF-8') as f:
        headers['Authorization'] = 'Bearer ' + f.read()
    schools: dict or None = getSchoolList()
    if schools is None:
        print('无法获取学校')
        exit(1)
    collect = ''
    url = 'http://localhost/dev-api/user/department'
    connection = mysql.Mysql('127.0.0.1', 'root', '123123', 'jsjds')
    while True:
        s = file.readline().split(',')
        if len(s) == 1:
            break
        elif len(s) == 2:
            collect = s[0]
        else:
            if schools.get(s[3]) is not None:
                # json = {
                #     'departmentName': collect,
                #     'departmentSchoolId': schools.get(s[3])
                # }
                # requests.post(url, headers=headers, json=json)太慢了
                sql = """insert into wx_department(department_name,department_school_id) values(%s,%s)"""
                data = (collect, schools.get(s[3]))
                connection.insertSql(sql, data)

    connection.close()
    file.close()
