## Python 제어구문 

> 제어구문은 흐름을 제어합니다. 일반적으로 위에서 아래로 진행이 되는데, 제어구문을 실행하면 분기가 발생하거나 반복이 발생합니다.

* **for, while문**은 반복을 발생시키기 때문에 반복문이라고 합니다.  for문은 반복횟수를 알 때, while은 반복 횟수를 모를때 사용합니다.

* range(start, stop, step)의 구조를 갖고 있습니다.

  

  * ```python
    for i in range(1, 10, 2) :
        print(i)
    ```

  * ```python
    var = ['사과', '바나나', '딸기']
    for 과일 in var :
        print(과일)
    ```

  * ```python
    count = 1
    while count <= 5:
       print(count)
       count += 1
    print("현재 count 값은 %s 입니다.", %count)
    ```

* 반복문에는 **break**와 **continue**가 있습니다. 둘다 반복문의 실행 흐름을 제어하기 위해 사용되는 키워드입니다.

  * **break** : 반복문을 완전히 종료하고, 다음 실행할 코드로 넘어갑니다.

    * ```python
      for i in range(1, 11):
          if i % 5 == 0:
              print("첫 5의 배수:", i)
              break
      ```

  * **continue** : 현재 반복되는 구간을 건너뛰고, 다음 반복을 진행합니다.

    * ```python
      for i in range(1, 11):
          if i % 2 == 0:
              continue
          print("홀수 :", i)
      ```

  * **enumerate** : 순서가 있는 자료형의 값을 인덱스와 함께 전달(열거)해줍니다.

    * ```python
      for num, s in enumerate(score):
          num = num + 1
          
          if s > 60:
            print('%d번 수강생은 수료입니다.' %num)
          else :
            print('%d번 수강생은 미수료입니다.' %num)
      ```

      

* **if문** : 조건의 질문이 True인 경우와 False인 경우에 따라 서로 다른 코드가 실행되도록 합니다. 

* 만약 여러개의 조건을 검사하여 서로 다른 코드를 실행하려면, **elif문**이나 **else**를 사용할 수 있습니다.

  * ```python
    age = 20
    
    if age >= 18:
       print('성입입니다.')
    else:
       print('미성년자입니다.')
    ```

    