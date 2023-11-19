import requests
import time

def get_sch(page,size):
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
    time.sleep(0.5)
    return response.json()

#爬取各个学校的id和名字
def get_id_sch_data(json):
    tmp =[]
    data_list = json['data']['data']
    for i in data_list:
        tmp1=[]
        sch_name = i['school_name']
        # 取出学校id方便后面拿地址
        sch_id = i['school_id']
        tmp1.append(sch_name)
        tmp1.append(sch_id)
        if tmp1:
            tmp.append(tmp1)
    return tmp

#爬取数据有多少页
def get_sch_total_data(sch_id):
    headers = {
        'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/119.0.0.0 Safari/537.36 Edg/119.0.0.0'
    }
    url = 'https://static.kaoyan.cn/json/score/2023/{}/0/1.json'.format(sch_id)
    response = requests.get(url=url, headers=headers)
    if response.status_code == 200:
        data = response.json()["data"]["count"]
        num_page = int(data)/10
        if isinstance(num_page,int):
            num_page =num_page
            return num_page
        else:
            num_page=int(num_page)+1
            return num_page
def get_sch_total_data_2022(sch_id):
    headers = {
        'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/119.0.0.0 Safari/537.36 Edg/119.0.0.0'
    }
    url = 'https://static.kaoyan.cn/json/score/2022/{}/0/1.json'.format(sch_id)
    response = requests.get(url=url, headers=headers)
    if response.status_code == 200:
        data = response.json()["data"]["count"]
        num_page = int(data)/10
        if isinstance(num_page,int):
            num_page =num_page
            return num_page
        else:
            num_page=int(num_page)+1
            return num_page


#爬取不同年份的数据
def get_sch_score(year,sch_id,page):
    headers = {
        'User-Agent':'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/119.0.0.0 Safari/537.36 Edg/119.0.0.0'
    }
    url = 'https://static.kaoyan.cn/json/score/{}/{}/0/{}.json'.format(year,sch_id,page)
    time.sleep(0.5)

    try:
        response = requests.get(url=url,headers=headers)
        data=response.json()["data"]["item"]

        return data
    except:
        return None

def test():
    print(get_sch_score(2023,140,1))

def main():

    json = get_sch(1, 10)
    total_num = json['data']['total']

    page_size = 10
    # 计算需要爬多少页
    sch_num = int(total_num) / page_size
    if isinstance(sch_num, int):
        sch_num = sch_num
    else:
        sch_num = int(sch_num) + 1
    dic = dict.fromkeys(range(1, sch_num+1), 'null')
    for i in range(1,sch_num+1):
        sch_json = get_sch(i,page_size)
        page_sch_id=get_id_sch_data(sch_json)
        dic.update({i:page_sch_id})

    tmp_2023 = []
    tmp_2022 = []
    for i in range(1,len(dic)+1):
        sch_id_datas = dic[i]#双列表
        for j in sch_id_datas:
            page_2023=get_sch_total_data(j[1])
            page_2022=get_sch_total_data_2022(j[1])
            if page_2023:
                #爬取2023年的
                for p_num in range(1,page_2023+1):
                    data = get_sch_score(2023,j[1],p_num)#一个列表，数据为字典
                    if data:
                        for final_data in data:
                                tmp=[]
                                year = 2023
                                code = final_data['special_code']
                                special_name = final_data['special_name']
                                degree_type_name = final_data['degree_type_name']
                                sch_name =j[0]
                                ed_istt = 'NULL'
                                total_score = final_data['total']
                                english = final_data['english']
                                politics = final_data['politics']
                                special_one = final_data['special_one']
                                special_two = final_data['special_two']
                                tmp.append(year)
                                tmp.append(code)
                                tmp.append(special_name)
                                tmp.append(degree_type_name)
                                tmp.append(sch_name)
                                tmp.append(ed_istt)
                                tmp.append(total_score)
                                tmp.append(english)
                                tmp.append(politics)
                                tmp.append(special_one)
                                tmp.append(special_two)
                                tmp_2023.append(tmp)
            #爬取2022的
            if page_2022:
                for p_num in range(1,page_2022+1):
                    data = get_sch_score(2022,j[1],p_num)#一个列表，数据为字典
                    if data:
                        for final_data in data:
                                tmp=[]
                                year = 2022
                                code = final_data['special_code']
                                special_name = final_data['special_name']
                                degree_type_name = final_data['degree_type_name']
                                sch_name =j[0]
                                ed_istt = 'NULL'
                                total_score = final_data['total']
                                english = final_data['english']
                                politics = final_data['politics']
                                special_one = final_data['special_one']
                                special_two = final_data['special_two']
                                tmp.append(year)
                                tmp.append(code)
                                tmp.append(special_name)
                                tmp.append(degree_type_name)
                                tmp.append(sch_name)
                                tmp.append(ed_istt)
                                tmp.append(total_score)
                                tmp.append(english)
                                tmp.append(politics)
                                tmp.append(special_one)
                                tmp.append(special_two)
                                tmp_2022.append(tmp)


    with open('data_2023.txt','w') as f:
        for i in tmp_2023:
                for j in i:
                    f.write(str(j))
                    f.write(',')
                f.write('\n')

    with open('data_2022.txt','w') as f:
        for i in tmp_2022:
                for j in i:
                    f.write(str(j))
                    f.write(',')
                f.write('\n')


    # page_num = get_sch_total_data(140)
    # for i in range(1,page_num+1):
    #     print(get_sch_score(2022,140,i))
    #     print(get_sch_score(2023,140,i))
    # a = get_sch(1,10)
    # b=get_id_sch_data(a)
    # print(b)
    # print(get_sch_score(2023,1013))
    # print(get_sch_total_data(140))


if __name__ == '__main__':
    main()
