import requests
import pandas as pd
import time

def get_data(page,size):
    headers = {
        'user-agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/117.0.0.0 Safari/537.36',
    }
    #网页一共106页
    json_data = {
        'page': page,  # 这是page第几页
        'limit': size,  # 这是size每页爬多少
        'province_id': '',
        'type': '',
        'feature': '',
        'school_name': '',
    }
    url = 'https://api.kaoyan.cn/pc/school/schoolList'
    response = requests.post(url=url, headers=headers, json=json_data)
    time.sleep(1)
    return response.json()

def wash_data(json):
    data= []
    data_list = json['data']['data']
    for i in data_list:
        tmp = []
        sch_name = i['school_name']
        sch_address = i['province_name']
        sch_211 = i['is_211']
        sch_985 = i['is_985']
        sch_syl = i['syl']
        sch_zihuaxian = i['is_zihuaxian']
        if sch_211 == 1 and sch_985 == 1 and sch_syl == 1:
            rank = '985,211,双一流'
        elif sch_211 == 1 and sch_985 == 2 and sch_syl == 1:
            rank = '211,双一流'
        elif sch_211 == 1 and sch_985 == 2 and sch_syl == 2:
            rank = '211'
        elif sch_211 == 2 and sch_985 == 2 and sch_syl == 1:
            rank = '双一流'
        else:
            rank = '普通院校'
        #自划线
        if sch_zihuaxian == 1:
            zihuaxian = '是'
        else:
            zihuaxian = '否'

        #取出学校id方便后面拿地址
        sch_id = i['school_id']
        tmp.append(sch_name)
        tmp.append(sch_address)
        tmp.append(rank)
        tmp.append(zihuaxian)
        tmp.append(sch_id)
        data.append(tmp)
    return data



def get_sch_href(sch_id):
    headers = {
        'User-Agent':'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/119.0.0.0 Safari/537.36 Edg/119.0.2109.1'
    }
    url = 'https://static.kaoyan.cn/json/school/%s/info.json'%(sch_id)
    time.sleep(1)
    try:
        response = requests.get(url=url,headers=headers)
        data=response.json()["data"]["site"]
    # print(data)#dict
        return data
    except:
        return None



def main():
    fini_data =[]
    json = get_data(1,10)
    total_num = json['data']['total']

    page_size = 10
    #计算需要爬多少页
    num = int(total_num)/page_size
    if isinstance(num,int):
        num=num
    else:
        num=int(num)+1

    for i in range(1,num+1):
        json = get_data(i,page_size)

        data = wash_data(json)

        for j in data:
            href_data =get_sch_href(j[4])
            if href_data == None:
                continue
            official_website = href_data['school_site']
            kaoyan_web = href_data['zhaoban_site']
            j.append(official_website)
            j.append(kaoyan_web)
            # print(j)
            fini_data.append(j)
    for i in range(len(fini_data)):
        fini_data[i].pop(4)
        # print(fini_data[i])

    with open('output.txt','w') as f:
        for i in fini_data:
            for j in i:
                f.write(j+',')
            f.write('\n')






if __name__ == '__main__':
    main()

