## Seaborn

> 시각화
>
> > 실습 파일은 앞선 실습과 같이 PII.csv파일을 사용하였습니다.

* 일반적으로 Seaborn을 쓸 때, matplotlib을 같이 사용합니다.

* seaborn은 보통 `import as`를 `sns`로 하며, `seaborn.lineplot(옵션)` 이렇게 사용합니다.
* seaborn에는 파이그래프가 없어서 파이그래프를 그리려면 pandas나 matpoltlib을 이용해야 합니다.



### 선 그래프

* ```python
  #선 그래프 예시
  import pandas as pd
  import seaborn as sns
  import matplotlib.pyplot as plt
  
  url = 'https://raw.githubusercontent.com/rusita-ai/pyData/master/PII.csv'
  DF = pd.read_csv(url)
  
  plt.figure(figsize = (10, 7))
  sns.lineplot(x = DF.index, 
               y = DF.Height,
               linewidth = 1,
               color = 'r',
               marker = '>',
               linestyle = '--')
  plt.title('Line Graph', size = 30)
  plt.xlabel('Index', size = 20)
  plt.ylabel('Height', size = 20)
  plt.grid(True)
  plt.show()
  ```



### 막대 그래프

* 막대 그래프를 그릴 때, 명목형 데이터와 연속형 데이터의 그래프를 그리는 함수가 따로 있습니다.

  * 명목형 데이터 : `.countplot()` , 연속형 데이터 : `.barplot()`

* ``` python
  #연속형 데이터의 예시
  plt.figure(figsize = (10, 7))
  sns.barplot(data = DF,
              x = DF.index, 
              y = 'Height')
  plt.show()
  ```

* ```python
  #명목형 데이터의 예시
  plt.figure(figsize = (10, 7))
  sns.countplot(data = DF,
                x = 'BloodType',
                hue = 'Gender') # 값의 결과를 값끼리 분리해서 출력합니다.
                                # ex) Gender 출력시 남, 여를 나눠서 보여줍니다.
  plt.show()
  ```

* ```python
  #barh 예시
  plt.figure(figsize = (7, 10))
  sns.countplot(data = DF,
                y = 'BloodType',
                hue = 'Gender')
  plt.show()
  
  #seaborn은 barh가 없고 x축으로 그리냐 y축으로 그리냐의 옵션으로 지정해 그립니다.
  ```



### 히스토그램

* ```python
  #히스토그램 예시
  plt.figure(figsize = (10, 7))
  sns.histplot(data = DF,
               x = 'Height',
               bins = 5, 
               alpha = 0.3)
  plt.show()
  ```



### 상자 그래프

* ```python
  #상자 그래프 예시
  plt.figure(figsize = (10, 7))
  sns.boxplot(data = DF,
              x = 'BloodType', 
              y = 'Height', #상자 그래프를 그릴때 x축, y축만 지정해주면 자동으로 옵션이 맞춰집니다.
              order = ['A', 'B', 'O', 'AB']) #order로 그래프에 출력되는 순서를 변경 가능합니다.
  plt.show()
  ```



### 산점도

* ```python
  #산점도 예시
  plt.figure(figsize = (10, 7))
  sns.scatterplot(data = DF,
                  x = 'Height', 
                  y = 'Weight', 
                  s = 50)
  plt.show()
  ```





### 그래프 여러개 그리기

```python
#Multiple Plots 예시 
fig, ax = plt.subplots(nrows = 2, ncols = 2, figsize = (15, 10))

sns.barplot(data = DF, x = 'Grade', y = 'Age',
            hue = 'Gender', ci = None, ax = ax[0, 0]) 
            #matplotlib과는 다르게 옵션을 지정할 때 ax에 대한 값을 지정해줍니다.
sns.histplot(data = DF, x = 'Weight',
             bins = 6, alpha = 0.3, ax = ax[0, 1])
             
sns.boxplot(data = DF, x = 'BloodType', y = 'Height',
            order = ['A', 'B', 'O', 'AB'], ax = ax[1, 0])
            
sns.scatterplot(data = DF, x = 'Height', y = 'Weight', 
                hue = 'Grade', style = 'BloodType', s = 50, ax = ax[1, 1])
                
# 'best', 'upper right', 'upper left', 'lower left', 'lower right'
# 'right', 'center left', 'center right', 'lower center', 'upper center', 'center'
ax[0, 0].legend(labels = ['Male','Female'], loc = 'upper left', title = 'Gender')
 # 범례 나타내기
ax[0, 0].set_title('Bar Plot')
ax[0, 1].set_title('Histogram')
ax[1, 0].set_title('Box Plot')
ax[1, 1].set_title('Scatter Plot')

ax[0, 0].set_xlabel('Grade')
ax[0, 1].set_xlabel('Weight')
ax[1, 0].set_xlabel('Blood Type')
ax[1, 1].set_xlabel('Height')

ax[0, 0].set_ylabel('Age Mean')
ax[0, 1].set_ylabel('Frequency')
ax[1, 0].set_ylabel('Height')
ax[1, 1].set_ylabel('Weight')

plt.show()
```

