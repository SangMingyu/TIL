## Matplotlib

> 시각화를 돕는 패키지

* 전체적인 구성은 Pandas에서 시각화하는 것과 비슷하게 진행되나 세부적으로 조금씩 다름



### 선 그래프

* ```python
  #실습으로 진행
  #예시
  import pandas as pd
  url = 'https://raw.githubusercontent.com/rusita-ai/pyData/master/PII.csv' 
  #실습은 PII.csv 파일로 진행
  DF = pd.read_csv(url)
  
  import matplotlib.pyplot as plt
  plt.figure(figsize = (10, 7)) # plt. 이런식으로 지정해서 사용합니다.
  plt.plot(DF.Height,           # plt.plot이 디폴트로 라인 그래프를 나타냅니다.
           linewidth = 1,
           color = 'r',
           marker = '>',
           linestyle = '--')
  plt.title('Line Graph', size = 30) # 그래프의 제목을 나타냅니다.
  plt.xlabel('Index', size = 20) # X축의 내용을 나타냅니다.
  plt.ylabel('Height', size = 20) # Y축의 내용을 나타냅니다.
  plt.grid(True) # 그래프의 배경에 실선으로 칸을 나눠줍니다.
  plt.show()
  ```



### 막대 그래프

* ```python
  #예시
  plt.figure(figsize = (10, 7))
  plt.bar(DF.index,  # index의 뒤에 +0 ~ 1 사이의 값을 줌으로써 막대를 이동시킬 수 있습니다.
          DF.Height, 
          width = 0.4,  # 막대의 두께를 나타냅니다.
          color = 'y',
          edgecolor = 'b') # 막대 테두리 색을 나타냅니다.
  plt.show()
  
  # 막대 그래프는 하나만 그릴 수 있는데 두번 그리고 싶으면 똑같은 구문을 복사해서 만들면 됩니다.
  ```

* ```python
  # 막대 그래프 두 개 그리는 예시
  plt.figure(figsize = (10, 7))
  plt.bar(DF.index, DF['Height'], 
          width = 0.3, label = 'Height')
  plt.bar(DF.index + 0.3, DF['Weight'], 
          width = 0.3, label = 'Weight')
  plt.legend() # 범례를 나타내 줍니다.
  plt.show()
  ```

* ```python
  # 'barh' 예시
  plt.figure(figsize = (7, 10))
  plt.barh(DF.index, 
           width = DF['Height'], height = 0.3,
           label = 'Height')
  plt.barh(DF.index + 0.3, 
           width = DF['Weight'], height = 0.3, 
           label = 'Weight')
  plt.legend()
  plt.show()
  ```



### 히스토그램

* ```python
  plt.figure(figsize = (10, 7))
  plt.hist(DF.Height, 
           bins = 5,
           alpha = 0.5, density = False) #density는 밀도를 의미합니다. 
                                         #True로 설정시 합이 1이 되도록 확률 값으로 표시합니다.
  plt.show()
  ```



### 상자 그래프

> 상자 그래프를 사용하는 이유 중 하나는 이상치를 확인하기 위함입니다.
>
> > 상자 그래프에서 상자의 길이의 1.5배 이상을 넘어간 값은 이상치로 간주합니다.

* ```python
  # 혈액형별 키 분포 예시
  plt.figure(figsize = (10, 7))
  plt.boxplot([DF.loc[DF['BloodType'] == 'A', 'Height'],
               DF.loc[DF['BloodType'] == 'B', 'Height'],
               DF.loc[DF['BloodType'] == 'O', 'Height'],
               DF.loc[DF['BloodType'] == 'AB', 'Height']],
               labels = ['A', 'B', 'O', 'AB'],
              patch_artist = True, 
              showmeans = True) #평균을 보여줍니다.
  plt.show()
  ```



### 산점도 

* ```python
  plt.figure(figsize = (10, 7))
  plt.scatter(DF.Height, 
              DF.Weight, 
              marker='*',
              s = 100,
              c = '#d62728')
  plt.show()
  ```



### 파이 그래프

* ```python
  plt.figure(figsize = (10, 10))
  plt.pie(DF.BloodType.value_counts(),
          labels = DF.BloodType.value_counts().index,
          autopct = '%.1f%%',
          explode = [0.0, 0.0, 0.0, 0.05], # 결과값끼리의 간격 (피자 생각하면 편합니다.)
          startangle = 90) # 주는 값에 따라 그래프의 스타팅 포인트가 달라집니다.
  plt.show()
  ```



### Figure 와 Axes 개념 정리

> 간단히 이야기하면 Figure는 바깥, 그 안에 Axes, Axes의 안에 Axis가 있는 개념입니다.

* 색을 입혀 범위를 확인하고 개념을 정리 

* ```python
  #Figure 확인
  import matplotlib.pyplot as plt
  
  plt.figure(figsize = (3, 3), facecolor = 'tan')
  plt.title('Figure')
  plt.xticks([])
  plt.yticks([])
  plt.plot()
  
  plt.show()
  #출력 결과 바깥쪽에 색이 입혀지는 것을 확인
  ```

* ```python
  #Axes 확인
  ax = plt.axes(facecolor = 'g')
  
  ax.figure.set_size_inches(3, 3)
  ax.set_title('Axes')
  ax.set_xticks([])
  ax.set_yticks([])
  
  plt.show()
  #출력 결과 안쪽에 색이 입혀지는 것을 확인
  ```



#### 1 x 2 subplot

* subplot을 생성하여 두 개의 결과를 한 눈에 확인 가능

* ```python
  # subplot을 통해 figure와 axes를 따로 지정해 줄 수 있습니다.
  # axes는 하나의 figure에 두 개 이상이 들어갈 수 있습니다.
  fig, ax = plt.subplots(nrows = 1, ncols = 2, figsize = (6, 3), facecolor = 'tan')
  # nrows는 행, ncols는 열
  ax[0].plot()
  ax[0].set_facecolor('tomato')
  ax[0].set_title('Axes_1')
  ax[0].set_xticks([])
  ax[0].set_yticks([])
  
  ax[1].plot()
  ax[1].set_facecolor('royalblue')
  ax[1].set_title('Axes_2')
  ax[1].set_xticks([])
  ax[1].set_yticks([])
  # 두 개 이상의 axes를 지정하고 싶으면 각각의 주소(위치)를 지정해주어야 합니다.
  # 위의 ax[0], ax[1], ax[1, 0], ax[0, 1] 이런식으로 지정합니다.
  plt.show()
  ```

#### 2 x 1 subplot

* ```python
  fig, ax = plt.subplots(nrows = 2, ncols = 1, figsize = (3, 6), facecolor = 'tan')
  
  ax[0].plot()
  ax[0].set_facecolor('limegreen')
  ax[0].set_title('Axes_1')
  ax[0].set_xticks([])
  ax[0].set_yticks([])
  
  ax[1].plot()
  ax[1].set_facecolor('plum')
  ax[1].set_title('Axes_2')
  ax[1].set_xticks([])
  ax[1].set_yticks([])
  
  plt.show()
  
  # 출력 결과 옆으로 나열하는 것이 아닌 위 아래로 나열된 형태로 출력 됩니다.
  ```



#### 2 x 2 subplot

* ```python
  fig, ax = plt.subplots(nrows = 2, ncols = 2, figsize = (6, 6), facecolor = 'tan')
  
  ax[0, 0].plot()
  ax[0, 0].set_facecolor('tomato')
  ax[0, 0].set_title('Axes_1')
  ax[0, 0].set_xticks([])
  ax[0, 0].set_yticks([])
  
  ax[0, 1].plot()
  ax[0, 1].set_facecolor('royalblue')
  ax[0, 1].set_title('Axes_2')
  ax[0, 1].set_xticks([])
  ax[0, 1].set_yticks([])
  
  ax[1, 0].plot()
  ax[1, 0].set_facecolor('limegreen')
  ax[1, 0].set_title('Axes_3')
  ax[1, 0].set_xticks([])
  ax[1, 0].set_yticks([])
  
  ax[1, 1].plot()
  ax[1, 1].set_facecolor('plum')
  ax[1, 1].set_title('Axes_4')
  ax[1, 1].set_xticks([])
  ax[1, 1].set_yticks([])
  
  plt.show()
  ```



#### Multiple Plots

* ```python
  fig, ax = plt.subplots(nrows = 2, ncols = 2, figsize = (15, 10))
  
  ax[0, 0].bar(DF.index, DF['Height'], width = 0.3, label = 'Height')
  ax[0, 0].bar(DF.index + 0.3, DF['Weight'], width = 0.3, label = 'Weight')
  
  ax[0, 1].boxplot([DF.loc[DF['BloodType'] == 'A', 'Height'],
                    DF.loc[DF['BloodType'] == 'B', 'Height'],
                    DF.loc[DF['BloodType'] == 'O', 'Height'],
                    DF.loc[DF['BloodType'] == 'AB', 'Height']],
                    labels = ['A', 'B', 'O', 'AB'], patch_artist = True, 
                   showmeans = True)
                   
  ax[1, 0].scatter(DF.Height, DF.Weight, 
                   marker='*', s = 100, c = '#d62728')
                   
  ax[1, 1].pie(DF.BloodType.value_counts(),
               labels = DF.BloodType.value_counts().index,
               autopct = '%.1f%%', startangle = 90,
               explode = [0.0, 0.0, 0.0, 0.05])
               
  ax[0, 0].legend()
  
  ax[0, 0].set_title('Bar Plot')
  ax[0, 1].set_title('Box Plot')
  ax[1, 0].set_title('Scatter Plot')
  ax[1, 1].set_title('Pie Plot')
  
  ax[0, 0].set_xlabel('Height & Weight')
  ax[0, 1].set_xlabel('Blood Type')
  ax[1, 0].set_xlabel('Height')
  ax[1, 1].set_xlabel('')
  
  ax[0, 0].set_ylabel('Frequency')
  ax[0, 1].set_ylabel('Height')
  ax[1, 0].set_ylabel('Weight')
  ax[1, 1].set_ylabel('')
  
  plt.show()
  ```

  