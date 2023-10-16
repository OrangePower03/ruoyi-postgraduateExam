import requests
from utils import mysql

path = './resources/school_major.txt'
file = open(path, 'r', encoding='GBK')
headers = {
    'user-agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/117.0.0.0 Safari/537.36',
    'Content-type': 'application/json;charset=UTF-8',
}

major_id = dict()
def getMajorList() -> dict or None:
    url = 'http://localhost/dev-api/user/major/slist'
    response = requests.get(url, headers=headers)
    if response.ok:

        majorList: [dict] = response.json()['rows']
        for d in majorList:
            major_id[d['majorName']] = d['majorId']
        return major_id
    else:
        return None

department_id = dict()
def getDepartmentList() -> dict or None:
    url = 'http://localhost/dev-api/user/department/departmentList'
    response = requests.get(url,headers=headers)
    if response.ok:
        departments: [dict] = response.json()['rows']
        for d in departments:
            school_department = f"{d['schoolName']} {d['departmentName']}"
            department_id[school_department] = d['departmentId']
        return department_id
    else:
        return None


if __name__ == '__main__':
    with open('./resources/Authorization.txt', 'r', encoding='UTF-8') as f:
        headers['Authorization'] = 'Bearer ' + f.read()
    majors: dict or None = getMajorList()
    departments: dict or None = getDepartmentList()
    collect = ''
    connection = mysql.Mysql('127.0.0.1', 'root', '123123', 'jsjds')
    while True:
        s = file.readline().split(',')
        if len(s) == 1:
            break
        elif len(s) == 2:
            collect = s[0]
        else:
            majorId = majors.get(s[1])
            departmentId = departments.get(f"{s[3]} {collect}")
            if majorId and departmentId:
                # print(f"专业id：{majorId},学校学院id：{departmentId}")
                sql = """insert into wx_mcd(major_id,department_id) values(%s,%s)"""
                data = (majorId, departmentId)
                connection.insertSql(sql, data)

    connection.close()
    file.close()
