## Pandas - Visualization

> 시각화

* `PII.csv` 파일을 예시 데이터 프레임으로 설정하였습니다.



### 1) 선 그래프

* `kind =` : 그래프의 종류 

* `style =` : 그래프속 선의 모양

* `linewidth =` : 선의 굵기

* `color = ' '` : 선의 색깔

* `figsize = ( , )` : 그래프의 넓이, 높이 사이즈 조절

* ```python
  #예시 
  import pandas as pd
  DF1 = pd.read_csv('PII.csv')
  DF1[['Height']].plot(kind = 'line',
                      style = '-',
                      linewidth = 2,
                      color = ''##FF0000',
                      grid = True,
                      figsize = (10, 7))
  ```

  

### 2) 막대 그래프

> 문자 데이터여도 가능합니다. 시각화의 함정에 주의 해야합니다.

* `width = 0 ~ 1 ` : 막대의 굵기

* `rot = 0~360 ` : 인덱스 이름이 출력될 때 각도 조정 ( 디폴트 값이 90도라 가독성이 떨어질 수가 있습니다. )

* `fontsize = ` : 인덱스 이름의 크기

* ```python
  #예시
  DF1[['Height', 'Weight']].plot(kind = 'bar', 
                                 width = 0.5,
                                 rot = 45,
                                 fontsize = 15,
                                 figsize = (10, 7))
  ```



### 3) 옆으로 누운 막대 그래프

* `kind = 'barh'` 지정만 해주면 됩니다.

* ```python
  #예시
  DF1[['Height', 'Weight']].plot(kind = 'barh', 
                                 rot = 45,
                                 color = ['#FA5800', '#A20025'],
                                 fontsize = 15,
                                 figsize = (7, 10))
  ```



### 4) 히스토그램

> 통계에서 연속형 데이터의 빈도분석을 하기위해 사용됩니다.

* `bins = ` : 구간(계급)의 개수입니다.

  * 구간 (계급) - 이 범위안에 값이 몇개가 들어있나?를 의미합니다.

* `alpha = 0 ~ 1` : 히스토그램의 투명도를 조절하능 기능입니다.

* ```python
  #예시
  DF1['Height'].plot(kind = 'hist', 
                     bins = 5, 
                     alpha = 0.5,
                     figsize = (10, 7))
  ```



### 5) 상자 그래프

> 연속형 데이터의 분포를 확인하는 용도로 사용됩니다.

* ```python
  #예시
  DF1['Height'].plot(kind = 'box',
                     figsize = (7, 9))
  ```

* 박스안에 ㅡ 이렇게 줄 그어져 있는 부분이 중앙값을 의미합니다.

* 박스의 윗 끝 부분은 75%, 아래 끝 부분은 25%를 의미합니다.



### 6) 산점도

* 키가 무조건 두 개가 있어야 합니다.

* 두 연속형 변수의 관계(정비례, 반비례, 양이나 음의 상관관계 등)를 확인할 수 있게 됩니다.

* `s = ` : 점의 크기를 조절합니다.

* ```python
  #예시
  DF1[['Height', 'Weight']].plot(kind = 'scatter', 
                                 x = 'Height', 
                                 y = 'Weight', 
                                 s = 50,
                                 figsize = (10, 7))
  ```



### 7) 파이 그래프

> 문자 데이터도 표현할 수 있습니다.

* 문자데이터를 `value_conuts()`를 사용함으로써 숫자 데이터 형태로 바꿔버립니다.

* ```python
  #예시
  DF1.BloodType.value_counts().plot(kind = 'pie',
                                    autopct = '%.1f%%', -> 퍼센테이지 표시 기능
                                    fontsize = 15,
                                    figsize = (10, 10))
  ```