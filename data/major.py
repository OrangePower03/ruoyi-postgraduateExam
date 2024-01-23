import time
import requests


class Major:
    data: dict = {
        'majorCode': str,
        'majorName': str,
        'majorType': int,
    }

    def __init__(self, majorCode: str, majorName: str, majorType: str) -> None:
        self.data['majorCode'] = majorCode
        self.data['majorName'] = majorName
        if majorType == '学术型硕士':
            self.data['majorType'] = 1
        elif majorType == '专业型硕士':
            self.data['majorType'] = 2


url = 'http://localhost:8080/user/major'
path = 'resources/major.txt'
file = open(path, 'r', encoding='GBK')
headers = {
    'user-agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/117.0.0.0 Safari/537.36',
    'Content-type': 'application/json;charset=UTF-8',
}


def initData() -> Major or None:
    line = file.readline()
    s: [str] = line.split(",")
    if len(s) == 1:
        return None
    return Major(s[0], s[1], s[2])


def request(m: Major):
    response = requests.post(url, headers=headers, json=m.data)
    if response.ok:
        print('添加成功')
    else:
        print(m.data.get('majorName') + '添加失败')
        print('你是不是没有登admin获取到token的头')
        exit(1)


# 记得去获取admin的token头，没有就会报没有权限的错误，把token加在最前面的那个 Authorization
# 这个添加的比较麻烦，建议找cq问一下。要给那个wx_major表重新搞一下才行
if __name__ == '__main__':
    with open('./resources/Authorization.txt', 'r', encoding='UTF-8') as f:
        headers['Authorization'] = 'Bearer ' + f.read()
    while True:
        major = initData()
        if major is not None:
            if major.data['majorCode'] != 'NULL':
                request(major)
            time.sleep(0.1)
        else:
            break
    file.close()

