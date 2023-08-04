# -*- coding:utf-8 -*-

import requests
from bs4 import BeautifulSoup
import pandas as pd

def createDF(result_list):
    result_df = pd.DataFrame({"title" : result_list})
    return result_df


def crawler(soup):
    
    #print(soup) # 여기까지는 전달 잘됨
    tbody = soup.find("tbody")
    result = []
    for a in tbody.find_all("p", class_="title"): # find_all의 반환값 형태는 리스트다!
        result.append(a.get_text().replace('\n', ''))
    
    return result
    

def main():

    custom_header = {
        
        'user-agent' : 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/115.0.0.0 Safari/537.36'
    }

    url = "https://music.bugs.co.kr/chart"
    req = requests.get(url, headers = custom_header)
    soup = BeautifulSoup(req.text, "html.parser")
    result = crawler(soup)
    df = createDF(result)
    print(df)
    df.to_csv("result.csv", index=False)


if __name__ == "__main__":
    main()