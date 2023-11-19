import requests
import time


def get_page_data(page_num):
    headers = {
        'user-agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/119.0.0.0 Safari/537.36 Edg/119.0.0.0',
    }
    url = 'https://api.kaoyan.cn/pc/special/specialList'
    json_data = {
        "page": page_num,
        "limit": 20,
        "degree_type": "",
        "level1": "",
        "level2": "",
        "special_name": ""
    }
    response = requests.post(url=url, headers=headers, json=json_data)
    return response.json()

def get_data_num():
    response = get_page_data(1)
    data_num_total = response['data']['total']
    num = data_num_total /20
    if num %10 == 0:
        return num
    else:
        return int(num+1)

def get_data():
    data_list1 =[]
    data_num_total = get_data_num()


    for j in range(1,data_num_total+1):
        response = get_page_data(j)
        code_sch = response['data']['data']
        for i in code_sch:
            tmp=[]
            code_num = i['code']
            if code_num =='':
                tmp.append('NULL')
            else:
                tmp.append(code_num)
            special_name = i['special_name']
            tmp.append(special_name)
            degree_name = i['degree_name']
            tmp.append(degree_name)
            data_list1.append(tmp)
    with open('output1.txt', 'w') as f:
        for i in data_list1:
            for j in i:
                f.write(j + ',')
            f.write('\n')
# print(requests.json()['data']['total'])
# print(requests.json()['data']['data'])

if __name__ == '__main__':
   get_data()