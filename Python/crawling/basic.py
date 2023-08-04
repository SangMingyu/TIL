# -*- coding:utf-8 -*-
from bs4 import BeautifulSoup

def main():
    # index.html을 불러와서 BeautifulSoup 객체 초기화
    # 웹에서 응답을 할 때, HTML, XML, JSON, 그 외 여러가지 방식들이 존재 
    soup = BeautifulSoup(open("html/index.html", encoding="utf-8"), "html.parser")
    
    #print(type(soup))
    #print(soup.title)
    #print(soup.title.string)
    #print(soup.find("p").get_text())
    #print(soup.find('div', class_='fakecampus')) 이거랑 밑에꺼 
    #print(soup.find(class_='fakecampus').get_text()) 이 두 개는 내가 짠 코드
    fake_str = soup.find('div', class_ = "fakecampus").find_all('p')
    print(fake_str[2].get_text())

if __name__ == "__main__":
    main()