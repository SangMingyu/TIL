## 함수
import random
def binSearch(ary, fData) :
    global count
    pos = -1
    start = 0
    end = len(ary)-1
    while (start <= end) :
        count += 1
        mid = (start+end)//2
        if (ary[mid] == fData) :
            pos = mid
            break
        elif (ary[mid] < fData) :
            start = mid + 1
        else :
            end = mid - 1
    return pos

## 변수
dataAry = [random.randint(0, 1000000000) for _ in range(1000000)]
dataAry.sort()
findData = random.choice(dataAry)
# findData = 91
count = 0
## 메인
print('배열-->', dataAry[:10])
position = binSearch(dataAry, findData)
if (position == -1) :
    print(findData, '없어요..')
else :
    print(findData, '가', position, '위치에 있어요', count, '번')