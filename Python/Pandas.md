## Pandas

> Python에서 데이터를 다루는데 가장 널리 사용되는 라이브러리로 정형 데이터를 분석하고 다양하게 조작하는 작업을 할 수 있습니다.
>
> >그냥 Python의 Excel이라고 생각하면 이해하기 편합니다.

* 일반적으로 테이블이라고 부르는 구조를 Pandas에서는 **DataFrame** 이라고 합니다.
* Pandas를 사용할 때, `import pandas as pd`로 지정하는 것이 사실상 표준 형태로 자리 잡고 있습니다.
* 데이터 분석에서는 **.csv**파일을 많이 사용하게 되는데  Excel에서도 열리지만 csv파일을 Python으로 읽어들이는 역할을 Pandas가 수행합니다. 
  * `데이터프레임 = pd.read_csv('읽어올 파일명.csv')`
    * 이렇게 불러온 csv파일의 타입을 확인해보면 DataFrame이라는 타입으로 바뀐 것을 확인 할 수 있습니다.
    * `type(데이터프레임)` 출력결과 : `pandas.core.frame.DataFrame`
* 읽어들이는 것도 가능하지만 역으로 저장하는 것도 가능합니다.
  * `데이터프레임.to_csv('저장할파일명.csv', index = None)`
  * `데이터프레임[0:3].to_csv('저장할파일명.csv', index = None)` 이런식으로 일부분만 저장하는 것도 가능합니다.
  * **.csv**파일 말고도 **.excel**파일로도 저장이 가능하여 상황에 맞게 사용하면 됩니다.



### DataFrame Information

* `.info()` : 데이터프레임의 종합적인 정보를 알 수 있습니다.
* `.index` : 행의 정보에 대해 알 수 있습니다.
* `.columns` : 열의 정보에 대해 알 수 있습니다.
* `.values` : 내부의 값들(values)을 Array 형태로 확인 할 수 있습니다.



### Function

* `.head(출력하고싶은 행의 수)` : 위에서부터 ( ) 안에 지정한 숫자만큼의 행을 보여줍니다.
* `.tail(출력하고싶은 행의 수)` : 밑에서부터 () 안에 지정한 숫자만큼의 행을 보여줍니다.
* `.sort_values(by = '기준 columns', ascending = True)` : 기준으로 지정한 columns를 오름차순으로 정렬합니다. 

* `.sort_values(by = '기준 columns', ascending = False)` : 기준으로 지정한 columns를 내림차순으로 정렬합니다.

  * `sort_values`를 사용하며 `.head()` , `.tail()`등으로 원하는 만큼만 출력할 수도 있고 구문의 끝 부분에`inplace = True`를 지정하면 데이터 프레임에 다이렉트로 저장하는 것도 가능합니다.

* `.describe()` : 전체 숫자 데이터의 통계량을 보여줍니다.

  * ```python
    #결과로 나타나는 수치들
    count : 빈도분석
    mean : 평균
    std : 표준편차 분산
    min : 최소값
    max : 최대값 
    25% : 25%값
    50% : 중앙값
    75% : 75%값
    ```

* `.mean()` : 각 column의 평균을 보여줍니다.

* `.median()` : 각 column의 중앙값을 보여줍니다.

* `.var()` : 각 column의 분산을 보여줍니다.

* `.std()` : 각 column의 표준편차를 보여줍니다.

* `.min()`, `.max()` : 각 column의 최소값, 최대값을 보여줍니다.



### INdexing & Slicing

* Lable(Index) 변경을 하는 방법입니다.

  * ```python
    LABEL = ['변경', '하고', '싶은', '이름', '지정']
    
    데이터프레임.index = LABEL
    
    #출력해보면 인덱스의 이름이 순서대로 변경되어 있는 것을 확인할 수 있습니다.
    ```

* `.loc[행_label, 열_label]` : 리스트안에 지정한 행과 열에 조건에 해당하는 값을 불러옵니다.

  * 단순히 말해 리스트로 지정한 애의 값을 보여준다는 의미

* `.loc[행_label_시작 : 행_label_끝, 열_label_시작 : 열_label_끝]` : 지정한 시작행부터 끝행의 시작열의 끝열까지 보여줍니다.

  * ```python
    #예시
    DF.loc['No_1' : 'No_4', 'Age' : 'BloodType']
    
    #출력결과
            Age Grade Picture BloodType
    No_1    20    1      무       A
    No_2    23    3      무       O
    No_3    24    4      무       B
    No_4    24    2      유       B  
    ```

* `.iloc` : loc와 똑같은 방식이지만 인덱스 값을 기준으로 출력합니다.

* `.iloc[행_index, 열_index]` : 리스트 안에 지정한 인덱스에 맞는 행과 열에 해당하는 값을 불러옵니다.
* `.iloc[행_index_시작:행_index_끝, 열_index_시작:열_index_끝]` : 인덱스를 기준으로 지정한 범위의 결과를 출력해줍니다.



### Series

> Label Index를 가지는 1차원 구조로 일반적으로 동일한 데이터 타입으로 구성되어 있습니다.
>
> > Pandas의 데이터 프레임은 시리즈의 묶음이라고 이야기합니다. 
> >
> > 즉, 혼자있으면 시리즈 두 개 이상 붙어있으면 데이터 프레임이라고 합니다.

* `데이터프레임['column명']` : 하나의 column을 출력했으니 'column명'의 column 시리즈가 되겠죠?

  * `데이터프레임.column명` 이렇게도 출력이 가능합니다. (이게 더 편한거 같은 느낌)

* ```python
  type(데이터프레임['column명'])
  
  #출력결과
  pandas.core.series.Series #시리즈로 결과가 출력되는 걸 확인
  
  #만약
  type(데이터프레임[['column명', 'column명2']]) #이렇게 두개의 시리즈를 리스트로 묶어서 출력하면
  
  pandas.core.frame.DataFrame #데이터 프레임으로 결과가 출력
  ```

* **Function**은 데이터 프레임의 Function과 똑같이 사용 가능

  * 그러나 특수한 애들도 있음
  * `.idxmin()` : 시리즈 최솟값의 인덱스 주소를 반환
  * `idxmax()` : 시리즈 최댓값의 인덱스 주소를 반환
    *   **!인덱스 주소를 반환해주는 거임 주의!**
  * `.sort_values( ascending = )` 역시 적용 가능!

* **Indexing & Slicing**도 같은 방식이지만 시리즈의 인덱싱과 슬라이싱이기에 column이름을 붙여줘야 합니다.
  * `데이터프레임.column명.loc['궁금한애 인덱스값']` <- 이런식
  * `데이터프레임.column명.loc['시작 : 끝 ']` 
  * `데이터프레임.column명.iloc[궁금한애 인덱스값]`
    * ※ `.iloc` 생략가능! ex ) `데이터프레임.column[궁금한애 인덱스]`

