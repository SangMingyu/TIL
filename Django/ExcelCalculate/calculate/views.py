from django.shortcuts import render
from django.http import HttpResponse
import pandas as pd
from numpy import mean

# Create your views here.

def calculate(request):
    file = request.FILES['fileInput']
    print("# 사용자가 등록한 파일의 이름: ", file)
    df = pd.read_excel(file, sheet_name="Sheet1", header=0)
    #print(df.head())

    # grade별 value 리스트 만들기
    grade_dic = {} # 빈 딕셔너리 생성
    total_row_num = len(df.index)
    #print(total_row_num)

    for i in range(total_row_num):
        data = df.loc[i, :]
        if not data.grade in grade_dic.keys():
            grade_dic[data.grade] = [data.value]
        else:
            grade_dic[data.grade].append(data.value)
    #print(grade_dic)

    grade_calculate_dic = {}
    for key in grade_dic.keys():
        grade_calculate_dic[key] = {}
        grade_calculate_dic[key]['min'] = min(grade_dic[key]) # 각 grade별 최소값 ex )grade 1의 최소값
        grade_calculate_dic[key]['max'] = max(grade_dic[key]) # 각 grade별 최대값
        grade_calculate_dic[key]['avg'] = float(sum(grade_dic[key])) / len(grade_dic[key])
        
    #print(grade_calculate_dic)

    # 결과 출력
    grade_list = list(grade_calculate_dic.keys())
    #print("")
    #print(grade_list)
    grade_list.sort()
    #print(grade_list)
    for key in grade_list:
        print("# grade: ", key)
        print("min:", grade_calculate_dic[key]['min'], end="")
        print("/ max:", grade_calculate_dic[key]['max'], end="")
        print("/ avg:", grade_calculate_dic[key]['avg'], end="\n\n")
    
    # 이메일 주소 도메인별 인원 구하기
    email_domain_dic = {}
    for i in range(total_row_num):
        data = df.loc[i, :]
        #print(data.email)
        email_domain = data['email'].split("@")[1] # 새로운 변수
        if not email_domain in email_domain_dic.keys():
            email_domain_dic[email_domain] = 1 # 새로운 도메인이 나타나면 1 숫자 부여
        else:
            email_domain_dic[email_domain] += 1 # 기존 도메인이 또 나타나면 +1 숫자 추가 (Count)
    
    print("## Email 도메인별 사용 인원")
    for key in email_domain_dic.keys():
        print("#", key, ":", email_domain_dic[key], "명")

    
    #  위 코드가 맘에 안듬 ---> pandas 문법으로 변환해서 2개 Tasks를 완료

    grade_df = df.groupby('grade')['value'].agg(["min", "max", "mean"]).reset_index().rename(columns = {"mean" : "avg"})
    print(grade_df)
    print("")
    df['domain'] = df['email'].apply(lambda x : x.split("@")[1])
    email_df = df.groupby('domain')['value'].agg("count").sort_values(ascending=False).reset_index()
    print(email_df)
    
    return HttpResponse("calculate, calculate function!")