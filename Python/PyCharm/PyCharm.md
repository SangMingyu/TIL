## PyCharm 가상환경 설정

> Window 환경에서 PyCharm 가상환경 설정하는 방법



* **GitHub**에서 새로운 **Repositorie** 하나 만듭니다.
* **Repositorie** 링크를 복사합니다.

* **Git Bash**를 실행시켜 `git clone Repositorie링크` 명령어를 입력합니다.
* 생성된 폴더를 마우스 오른쪽 클릭한 뒤, **PyCharm**으로 열어줍니다.
* 우측 상단 세팅에 들어가 **Project : 폴더명**으로 구성된 탭을 눌러 하단에 **Python Interpreter**를 눌러줍니다.
* 우측 상단에 **Add Interpreter** -> **Add Local Interpreter...** 클릭한 뒤 다음 뜨는 창은 바로 OK 눌러주면 됩니다.
* 가상환경(venv)이 정상적으로 생성된 것을 확인 후 터미널 창을 띄워준 뒤, **git bash**를 열어줍니다.
* 그 뒤 명령어를 입력 해봅시다!
  * `which python` : 현재 설치된 Python의 경로 확인
  *  `source venv/Scripts/activate` : 가상환경에 접속하는 명령어
* 순서대로 입력한 뒤, 다시 which python을 입력해 정상적으로 가상환경에 접속되었는지 확인하면 끝입니다.



> 설치부터 시작해서 이미지가 포함된 환경 설정은 https://ssangmg.tistory.com/3에 작성 완료!

