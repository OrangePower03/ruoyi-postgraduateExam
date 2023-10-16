import time

import requests

EOF = -1
url = 'http://localhost:8080/user/school'
headers = {
    'user-agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/117.0.0.0 Safari/537.36',
    'Content-type': 'application/json;charset=UTF-8',
}


class School:
    data = {
        "schoolName": "",
        "schoolArea": 0,
        "schoolType": 0,
        "schoolLevels": 0,
        "schoolWebsite": "",
        "schoolRecruit": ""
    }

    def __init__(self, schoolName, schoolArea, schoolType, schoolLevels, schoolWebsite, schoolRecruit):
        self.data["schoolName"] = schoolName
        self.data["schoolArea"] = area[schoolArea]
        self.data["schoolType"] = type[schoolType]
        self.data["schoolLevels"] = levels[schoolLevels]
        self.data["schoolWebsite"] = schoolWebsite
        self.data["schoolRecruit"] = schoolRecruit


area: dict[str, int] = {
    '北京': 1,
    '天津': 2,
    '河北': 3,
    '山西': 4,
    '辽宁': 5,
    '吉林': 6,
    '黑龙江': 7,
    '上海': 8,
    '江苏': 9,
    '浙江': 10,
    '安徽': 11,
    '福建': 12,
    '江西': 13,
    '山东': 14,
    '河南': 15,
    '湖北': 16,
    '湖南': 17,
    '广东': 18,
    '重庆': 19,
    '四川': 20,
    '陕西': 21,
    '内蒙古': 22,
    '广西': 23,
    '海南': 24,
    '贵州': 25,
    '云南': 26,
    '西藏': 27,
    '甘肃': 28,
    '青海': 29,
    '宁夏': 30,
    '新疆': 31,
    '香港': EOF,
    '澳门': EOF,
}

type: dict[str, int] = {
    '是': 1, '否': 2
}

levels: dict[str, int] = {
    '985，211，双一流': 1,
    '211，双一流': 2,
    '211': 3,
    '双一流': 4,
    '普通院校': 5,
}

path = "resources/school.txt"
file = open(path,'r',encoding='GBK')


def request(school: School):
    if school.data.get("schoolArea") == EOF:
        print('香港澳门跳过')
    else:
        response = requests.post(url, headers=headers, json=school.data)
        if response.ok:
            print('添加成功')
        else:
            print(school.data.get('schoolName')+'添加失败')
            print('你是不是没有登admin获取到token的头')
            exit(1)


def initData() -> School or None:
    line = file.readline()
    s: [str] = line.split(",")
    if len(s) == 1:
        return None
    return School(s[0], s[1], s[3], s[2], s[4], s[5])


# 记得去获取admin的token头，没有就会报没有权限的错误，把token加在最前面的那个 Authorization
if __name__ == '__main__':
    with open('./resources/Authorization.txt', 'r', encoding='UTF-8') as f:
        headers['Authorization'] = 'Bearer ' + f.read()
    while True:
        school = initData()
        if school is None:
            break
        request(school)
        time.sleep(0.1)
    file.close()
