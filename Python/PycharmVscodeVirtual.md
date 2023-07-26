## 가상환경 생성

> PyCharm과 Vs code에서 가상환경을 생성하는 방법을 정리하였습니다.



### PyCharm 

* GitHub에 Repositorie 하나를 생성한 뒤, 생성한 Repositorie의 주소를 복사합니다.
* 바탕화면에 생성한다는 기준으로 바탕화면에 오른쪽 마우스를 클릭해 **open git bash here** 을 클릭해줍니다.
* `git clone Repositorie주소`를 입력해줍시다

* 바탕화면에 복사된 폴더를 오른쪽 마우스로 클릭합니다.
* **Open Folder as PyCharm**을 눌러서 PyCharm으로 폴더를 열어줍시다.

* 우측 상단의 **Settings**에 들어갑니다.

* 여러 탭중에 **Project : Repositorie폴더이름**으로 되어있는 탭을 눌러 하위 탭에 **Python Interpreter**탭에 들어가줍니다.
* 오른쪽 상단의 **Add Interpreter**를 눌러 **Add Local Interpreter...** 눌러줍니다.
* 뜨는 창에서 OK를 누르고 apply 눌러 적용후 맨처음 화면으로 나오면 됩니다.
* 왼쪽 탭에 **venv** 폴더가 생성이 되었으면 가상환경 생성이 완료 되었습니다.



### PyCharm 가상환경 접속

* 터미널을 열어줍니다.

* `which python`으로 python 경로를 확인해봅시다.
  * `which python` : 현재 설치된 Python의 경로 확인
* 가상환경에 접속된 상태라면 **Repositorie이름/venv/Scripts/python**이렇게 뜰 것이고 접속이 안된 상태라면 일반 윈도우 로컬파일에 경로가 잡힐 것 입니다.
* 접속을 위해 `source venv/Scripts/activate`를 입력해줍시다.
  * `source venv/Scripts/activate` : 가상환경에 접속하는 명령어

* 다시 `which python`을 입력해 제대로 가상환경에 들어가졌는지 확인하면 됩니다.





### VS Code

* 바탕화면에 생성한다는 기준으로 바탕화면에 오른쪽 마우스를 클릭해 **open git bash here** 을 클릭해줍니다. 
* `git clone Repositorie주소`를 입력해줍니다.
* `cd Repositorie주소` 명령어로 폴더안으로 들어가줍니다.
* `code .` 명령어를 사용하여 현재 위치에서 VS code를 실행 해줍시다.
* 처음 가상환경을 세팅한다면 `pip install virtualenv`를 입력하여 버츄얼env를 설치 해줘야합니다.
* `virtualenv venv`로 가상환경을 생성해줍니다.
* `source venv/Scripts/activate` 명령어를 사용하여 가상환경에 접속해줍니다.
* `which python`을 통해 제대로 가상환경에 접속됐는지 확인해봅시다.





* **가상환경에 무사히 접속했다면 pip install django numpy pandas matplotlib seaborn scikit-learn streamlit jupyterlab plotly 등등 필수 라이브러리를 설치해봅시다**

