import requests
from bs4 import BeautifulSoup
import re
# url='https://yz.chsi.com.cn/zyk/specialityDetail.do?zymc=工业工程与管理&zydm=125603&ccdm=30&cckey=20&ssdm=&method=distribution#zyk-zyfb'


# print(tmp_zhuansuo)
# print(tmp_xuesuo)

def get_zuansuo(pj_name,code):
    url='https://yz.chsi.com.cn/zyk/specialityDetail.do?zymc={}&zydm={}&ccdm=30&cckey=20&ssdm=&method=distribution#zyk-zyfb'.format(pj_name,code)
    response = requests.get(url)
    re_li = '<li title="(.*?)">.*?</li>'
    if response.status_code ==200:
        soup = BeautifulSoup(response.text,'html.parser')
        news_links = soup.find_all('ul',class_='clearfix')
        data = re.findall(re_li,str(news_links),re.S)
        return data

def get_xuesuo(pj_name,code):
    url ='https://yz.chsi.com.cn/zyk/specialityDetail.do?zymc={}&zydm={}&ssdm=&method=distribution&ccdm=&cckey=10'.format(pj_name,code)
    response = requests.get(url)
    re_li = '<li title="(.*?)">.*?</li>'
    if response.status_code == 200:
        soup = BeautifulSoup(response.text, 'html.parser')
        news_links = soup.find_all('ul', class_='clearfix')
        data = re.findall(re_li, str(news_links), re.S)
        return data


def main():
    data_all =[]
    tmp_xuesuo = []
    tmp_zhuansuo = []
    file = open('output1.txt', 'r')
    file_data = file.readlines()
    for i in file_data:
        tmp_list = i.split(',')
        if tmp_list[0] == 'NULL':
            continue
        else:
            tmp_list = tmp_list[0:3]
            if tmp_list[2] == '学术型硕士':
                tmp_xuesuo.append(tmp_list)
            else:
                tmp_zhuansuo.append(tmp_list)

    #获取数据合成要的数据
    for i in tmp_zhuansuo:
        sch_data=get_zuansuo(i[1],i[0])
        if sch_data:
            for j in sch_data:
                a=[]
                a.append(i[0])
                a.append(i[1])
                a.append('NULL')
                a.append(j)
                a.append('专硕')
                data_all.append(a)
    for i in tmp_xuesuo:
        sch_data=get_xuesuo(i[1],i[0])
        if sch_data:
            for j in sch_data:
                a=[]
                a.append(i[0])
                a.append(i[1])
                a.append('NULL')
                a.append(j)
                a.append('学硕')
                data_all.append(a)
    with open('sch_mn_pj.txt', 'w') as f:
        for i in data_all:
            for j in i:
                f.write(j + ',')
            f.write('\n')

if __name__ == '__main__':
    main()
# response = requests.get(url)
# print(response.text)

# get_zuansuo('应用统计','025200')
# print(get_xuesuo('哲学','010100'))
