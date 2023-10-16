# -*- coding: GBK -*-
import time
import requests


ms: dict = {}
url = 'http://localhost:8080/user/dscore'
path = 'resources/dScore.txt'
file = open(path, 'r', encoding='UTF-8')
headers = {
    'user-agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/117.0.0.0 Safari/537.36',
    'Content-type': 'application/json;charset=UTF-8',
}


class Score:
    data: dict = {
        'scoreYear': int,
        'scoreAll': int,
        'scoreEnglish': int,
        'scorePolitics': int,
        'scoreMath': int,
        'scoreMajor': int,
        'majorId': int,
        'areaType': int
    }

    def __init__(self, s: [str]):
        self.data['scoreYear'] = s[0]
        majorId = ms.get(s[1])
        if majorId is not None:
            self.data['majorId'] = majorId
        self.data['scoreAll'] = s[2]
        self.data['scoreEnglish'] = s[3]
        self.data['scorePolitics'] = s[4]
        self.data['scoreMath'] = s[5]
        self.data['scoreMajor'] = s[6]
        if s[7] == 'A��\n':
            self.data['areaType'] = 1
        elif s[7] == 'B��\n':
            self.data['areaType'] = 2


def initData() -> Score or None:
    line = file.readline()
    s: [str] = line.split("��")
    if len(s) == 1:
        return None
    return Score(s)


def request(m: Score):
    response = requests.post(url, headers=headers, json=m.data)
    if response.ok:
        print('��ӳɹ�')
    else:
        print('���ǲ���û�е�admin��ȡ��token��ͷ')
        exit(1)


# ��ȥ��һ�����ݿ⣬md����������ӳ���ֲ���idֵ���ϣ���֪������ô�������ݵģ����ӻ������޷�ʹ��
# use jsjds;
# alter table wx_dscore modify column score_id int auto_increment
if __name__ == '__main__':
    with open('./resources/Authorization.txt', 'r', encoding='UTF-8') as f:
        headers['Authorization'] = 'Bearer ' + f.read()
    with open('resources/temp/majorDatabase.txt', 'r', encoding='GBK') as f:
        while True:
            s: [str] = f.readline().split(',')
            if len(s) == 1:
                break
            ms[s[1].strip()] = s[0]

    while True:
        s = initData()
        if s is None:
            break
        request(s)

    file.close()
