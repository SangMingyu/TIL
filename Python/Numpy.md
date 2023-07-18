## Numpy

> 수학 및 과학적 연산을 쉽고 빠르게 하기위한 패키지
>
> > 기본적으로 숫자 연산(산술 연산)에 최적화 되어 있습니다. 

* `pip install numpy`를 통해 설치하여 사용하거나 `import`를 사용해 불러와 사용합니다.



#### 기본적인 용어 설명

* **Array** : 배열이라고 해석합니다. 수학의 행렬이라고 생각하면 편합니다. Python의 리스트 구조를 사용해서 Array를 캐스팅하게 되며 타입이 Array로 바뀝니다.

* 1차원의 Array를**Vector**, 2차원의 Array를 **Matrix**,3차원의 Array는 그냥 **Array**라고 부릅니다.

  

### 함수

* `.Shape` : 행렬의 크기를 알려줍니다. 

  * ```python
    import numpy as np
    AR = np.array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12])
    AR.shape
    ```

* `.reshape(축, 행, 열)` : 차원을 생성하거나 바꿔줍니다.

  * ```python
    import numpy as np
    AR2 = AR.reshape(3, 4)
    print(AR2)
    ```

  * ```python
    import numpy as np
    AR3 = AR.reshape(3, 2, 2)
    print(AR3)
    ```

    * `.reshape(-1, 1)`이렇게 -1을 넣으면 다른 값에 자동으로 맞춰달라는 의미입니다.

* `.flatten()` : 일자로 값을 나열해줍니다.

  * ```python
    import numpy as np
    AR3 = AR.reshape(3, 2, 2)
    AR3.flatten()
    ```

    

* `.arange` : 연속된 값을 생성해줍니다. for문의 range처럼 쓰이지만 range는 리스트를, arange는 array를 생성합니다.

  * ```python
    import numpy as np
    np.arange(10)
    ```

  * ```python
    import numpy as np
    np.arange(1, 10, 2)
    ```

    * `.reshape()`를 적용하여 축,행,열을 지정하여 생성할 수 있습니다.



#### 특별한 형태의 Array 생성

* 0과 1로만 구성된 Array

  * `.zeros`를 사용하게되면 0으로만 구성된 Array가 생성이 됩니다.

    * ```python
      import numpy as np
      np.zeros(9)
      ```

  * `.ones`를 사용하게되면 1로만 구성된 Array가 생성이 됩니다.

    * ```python
      import numpy as np
      np.ones(9)
      ```

    * ```python
      import numpy as np
      np.ones([4, 3])
      ```

  * 산술연산을 적용하여 출력하고싶은 숫자로 구성된 행렬을 생성할 수 있습니다.

    * ```python
      import numpy as np
      np.zeros([3, 4]) + 9
      ```

  * `.eye`를 통해 단위행렬의 생성도 가능합니다.

    * ```python
      import numpy as np
      np.eye(3)
      ```



#### 난수 Array 생성

* `np.random.rand(축, 행, 열)`을 이용해 실수 난수를 생성이 가능합니다.

* 주어진 정수 범위에서 난수를 생성하는 법

  * ex ) 1 ~ 44 사이 , 복원 추출

    * ```python
      np.random.randint(1, 45, size = (5, 6))
      ```

* `np.random.seed( )`를 사용해 의사난수의 생성 초기값을 지정할 수 있습니다. 그로 인해 항상 같은 난수가 생성됩니다

  * ex ) 로또 번호 생성기

    * ```python
      np.random.seed(2045)
      
      np.random.choice(np.arange(1, 46), size = (5 ,6), replace = False)
      ```

* `.shuffle()` : 원소들을 랜덤하게 섞어줍니다.

  * ```python
    TA = np.arange(1, 10)
    np.random.shuffle(TA)
    ```



### Array 연산

* Array는 각각의 행과 열의 값을 매칭하여 연산을 수행합니다.

  * ```python
    A1 = np.array([85, 93, 75, 97, 69])
    
    A2 = np.array([91, 90, 85, 97, 89])
    
    A1 + A2
    A2 - A1
    A1 * A2
    A2 / A1
    A1 * 3
    A1 ** 2
    ```

  

### 통계량 연산

* `.sum()` : 총합

  * ```python
    A1.sum()
    ```

* `.mean()` : 평균

  * ```python
    A2.mean()
    ```

* `.var` : 분산

  * ```python
    A2.var()
    ```

* `.std()` : 표준 편차

  * ```python
    A2.std()
    ```

* `min()` : 최소값

  * ```python
    A2.min()
    ```

* 각 열의 최소값을 알고싶으면 `(axis = 0)`을 뒤에 붙여주고 각 행의 최소값을 알고싶으면 `(axis = 1)`을 넣어줍니다.

  * ```python
    A3 = np.array([[85, 93, 75],
                   [90, 84, 97],
                   [99, 91, 80]])
    
    A3.min(axis = 0) -> 각 열의 최소값
    
    A3.min(axis = 1) -> 각 행의 최소값
    ```

* `.max()` : 최대값

  * ```python
    A2.max()
    ```

  * 각 열이나 행의 최대값은 위에 최소값과 똑같이 `(axis = )`을 넣어주면 됩니다.

* `.cumsum()` : 누적 합

  * ```python
    A1.cumsum()
    ```

* `.cumprod()` : 누적 곱

  * ```python
    A1.cumprod()
    ```



### Matrix 연산

> Matrix 연산은 행렬곱으로 계산합니다.

* `.dot`으로 행렬곱을 실행합니다.

  * ```python
    M1 = np.array([2, 4, 6, 8]).reshape(2, 2)
    M2 = np.array([3, 5, 7, 9]).reshape(2, 2)
    
    M1.dot(M2)
    
    np.dot(M2, M1)
    ```

* `.transpose()`로 전치행렬을 할 수 있습니다. 

  >전치행렬 : 행과 열의 위치를 바꾼 형태로 나타나는 것

  * ```python
    np.transpose(M1)
    
    M2.transpose()
    
    M2.T
    
    -> 모두 전치행렬을 실행합니다.
    ```

    