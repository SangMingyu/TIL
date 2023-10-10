USE mydata;

SELECT COUNT(*) FROM dataset2;
SELECT * FROM dataset2;

-- a) DIVISION NAME 평균 평점
SELECT 
	`Division Name`,
    AVG(RATING) AVG_RATE
FROM dataset2
GROUP BY 1
ORDER BY 2 DESC;

-- b) Department별 평균 평점
SELECT 
	`Department Name`,
    AVG(RATING) AVG_RATE
FROM dataset2
GROUP BY 1
ORDER BY 2 DESC;

-- Trend의 평점 3점 이하 리뷰
SELECT *
FROM dataset2
WHERE `department name` = 'Trend'
AND RATING <= 3;

-- 구간을 그룹으로 나누어서 집계하는 방법
-- CASE WHEN
SELECT
	CASE WHEN AGE BETWEEN 0 AND 9 THEN '0009'
		WHEN AGE BETWEEN 10 AND 19 THEN '1019'
        WHEN AGE BETWEEN 20 AND 29 THEN '2029'
        WHEN AGE BETWEEN 30 AND 39 THEN '3039'
        WHEN AGE BETWEEN 40 AND 49 THEN '4049'
        WHEN AGE BETWEEN 50 AND 59 THEN '5059'
        WHEN AGE BETWEEN 60 AND 69 THEN '6069'
        WHEN AGE BETWEEN 70 AND 79 THEN '7079'
        WHEN AGE BETWEEN 80 AND 89 THEN '8089'
        WHEN AGE BETWEEN 90 AND 99 THEN '9099' END AGEBAND,
	AGE
FROM dataset2
WHERE `Department name` = 'Trend'
AND rating <= 3;

-- FLOOR 메서드 사용
SELECT 
	FLOOR(AGE/10) * 10 AS AGEBAND,
    AGE
FROM dataset2
WHERE `department name` = 'Trend'
AND rating <= 3;

-- 결과
SELECT 
	FLOOR(AGE/10) * 10 AS AGEBAND,
    COUNT(*) CNT
FROM dataset2
WHERE `department name` = 'Trend'
AND rating <= 3
GROUP BY 1
ORDER BY 2 DESC;

-- Department별 연령별 리뷰 수
SELECT 
	FLOOR(AGE/10) * 10 AS AGEBAND,
    COUNT(*) CNT
FROM dataset2
WHERE `department name` = 'Trend'
GROUP BY 1
ORDER BY 2 DESC;

-- 50대 3점 이하 Trend 리뷰를 살펴보기
SELECT *
FROM dataset2
WHERE `Department name` = 'Trend'
AND rating <= 3
AND AGE BETWEEN 50 AND 59
LIMIT 10;

-- p.134
-- 평점이 낮은 상품의 주요 Complain
-- Department Name, Clothing Name별 평균 평점 계산
SELECT
	`Department Name`,
    `Clothing ID`,
    AVG(rating) AS AVG_RATE
FROM dataset2
GROUP BY 1, 2;

-- Department 내에서 평균 평점을 기준으로 순위를 매긴다.
-- ROW_NUMBER()
SELECT *,
	ROW_NUMBER() OVER(PARTITION BY `Department Name` ORDER BY AVG_RATE) RNK
FROM (
	SELECT
		`Department Name`,
		`Clothing ID`,
		AVG(rating) AS AVG_RATE
	FROM dataset2
	GROUP BY 1, 2
) A;

-- 1~10위 데이터 조회
-- 평균 평점이 낮은 데이터를 추출 하기 위해서 (상위 10개)
SELECT *
FROM (
	SELECT *,
		ROW_NUMBER() OVER(PARTITION BY `Department Name` ORDER BY AVG_RATE) RNK
	FROM (
		SELECT
			`Department Name`,
			`Clothing ID`,
			AVG(rating) AS AVG_RATE
		FROM dataset2
		GROUP BY 1, 2
	) A
) A
WHERE RNK <= 10;

-- Clothing ID만 추출한 뒤, 각 부서별 리뷰 텍스트를 추출
-- 임시 테이블 생성
CREATE TEMPORARY TABLE stat AS
SELECT *
FROM (
	SELECT *,
		ROW_NUMBER() OVER(PARTITION BY `Department Name` ORDER BY AVG_RATE) RNK
	FROM (
		SELECT
			`Department Name`,
			`Clothing ID`,
			AVG(rating) AS AVG_RATE
		FROM dataset2
		GROUP BY 1, 2
	) A
) A
WHERE RNK <= 10;

SELECT * FROM stat;
-- 부서명 : Bottoms
-- Clothing ID : 18, 588, 1039, 1058
SELECT * FROM dataset2;

SELECT
	`Department Name`,
	`Clothing ID`,
	`Review Text`
FROM dataset2
WHERE `Department Name` = 'Bottoms'
    AND `Clothing ID` IN (18, 588, 1039, 1058);

SELECT
	`Department Name`,
	`Clothing ID`,
	`Review Text`
FROM dataset2
WHERE `Clothing ID` IN(SELECT `Clothing ID`
					   FROM stat
					   WHERE `Department name` = 'Bottoms')
ORDER BY `Clothing ID`;

-- p.139
-- 연령별 worst department
-- 각 연령대별로 가장 낮은 점수를 준 Department를 구하고,
-- 해당 Department의 할인 쿠폰을 발송한다.
-- 연령별로 가장 낮은 점수를 준 Department를 구한다
-- 연령별로 가장 낮은 점수를 준 Department에 혜택을 준다.

SELECT
	`department name`,
    FLOOR(AGE/10) * 10 AGEBAND,
    AVG(RATING) AS AVG_RATING
FROM dataset2
GROUP BY 1, 2
HAVING AGEBAND = 10;

SELECT *,
	ROW_NUMBER() OVER(PARTITION BY AGEBAND ORDER BY AVG_RATING) RNK
FROM (
	SELECT
		`department name`,
		FLOOR(AGE/10) * 10 AGEBAND,
		AVG(RATING) AS AVG_RATING
	FROM dataset2
	GROUP BY 1, 2
) A;

SELECT *
FROM (
	SELECT *,
		ROW_NUMBER() OVER(PARTITION BY AGEBAND ORDER BY AVG_RATING) RNK
	FROM (
		SELECT
			`department name`,
			FLOOR(AGE/10) * 10 AGEBAND,
			AVG(RATING) AS AVG_RATING
		FROM dataset2
		GROUP BY 1, 2
	) A
) A
WHERE RNK = 1;

-- 교재 p.143, Review Text를 분석 해보자!
SELECT 
	`REVIEW TEXT`,
    CASE WHEN `REVIEW TEXT` LIKE '%SIZE%' THEN 1 ELSE 0 END SIZE_YN
FROM dataset2;

-- SIZE가 있는 REVIEW TEXT 합계
SELECT 
    SUM(CASE WHEN `REVIEW TEXT` LIKE '%SIZE%' THEN 1 ELSE 0 END) N_SIZE,
    COUNT(*) AS N_TOTAL,
    SUM(CASE WHEN `REVIEW TEXT` LIKE '%SIZE%' THEN 1 ELSE 0 END) / COUNT(*) AS Rate
FROM dataset2;

SELECT 
	A.*,
    ROUND(N_SIZE / N_TOTAL, 2) AS RATE
FROM (
	SELECT 
		SUM(CASE WHEN `REVIEW TEXT` LIKE '%SIZE%' THEN 1 ELSE 0 END) N_SIZE,
		COUNT(*) AS N_TOTAL
	FROM dataset2
) A ;

-- p.146 그림 5-20
SELECT
	`department name`,
	SUM(CASE WHEN `REVIEW TEXT` LIKE '%SIZE%' THEN 1 ELSE 0 END) N_SIZE,
    SUM(CASE WHEN `REVIEW TEXT` LIKE '%LARGE%' THEN 1 ELSE 0 END) N_LARGE,
    SUM(CASE WHEN `REVIEW TEXT` LIKE '%LOOSE%' THEN 1 ELSE 0 END) N_LOOSE,
    SUM(CASE WHEN `REVIEW TEXT` LIKE '%SMALL%' THEN 1 ELSE 0 END) N_SMALL,
    SUM(CASE WHEN `REVIEW TEXT` LIKE '%TIGHT%' THEN 1 ELSE 0 END) N_TIGHT,
    SUM(1) N_TOTAL
FROM dataset2
GROUP BY 1;

-- 146p
SELECT
	FLOOR(AGE/10) * 10 AGEBAND,
	`department name`,
	SUM(CASE WHEN `REVIEW TEXT` LIKE '%SIZE%' THEN 1 ELSE 0 END) N_SIZE,
    SUM(CASE WHEN `REVIEW TEXT` LIKE '%LARGE%' THEN 1 ELSE 0 END) N_LARGE,
    SUM(CASE WHEN `REVIEW TEXT` LIKE '%LOOSE%' THEN 1 ELSE 0 END) N_LOOSE,
    SUM(CASE WHEN `REVIEW TEXT` LIKE '%SMALL%' THEN 1 ELSE 0 END) N_SMALL,
    SUM(CASE WHEN `REVIEW TEXT` LIKE '%TIGHT%' THEN 1 ELSE 0 END) N_TIGHT,
    SUM(1) N_TOTAL
FROM dataset2
WHERE `department name` = 'Dresses'
GROUP BY 1, 2
ORDER BY 1, 2;

-- 위 결괏값을 모두 비율로 변환
SELECT
	FLOOR(AGE/10) * 10 AGEBAND,
	`department name`,
	SUM(CASE WHEN `REVIEW TEXT` LIKE '%SIZE%' THEN 1 ELSE 0 END) / SUM(1)  N_SIZE,
    SUM(CASE WHEN `REVIEW TEXT` LIKE '%LARGE%' THEN 1 ELSE 0 END) / SUM(1)  N_LARGE,
    SUM(CASE WHEN `REVIEW TEXT` LIKE '%LOOSE%' THEN 1 ELSE 0 END) / SUM(1)  N_LOOSE,
    SUM(CASE WHEN `REVIEW TEXT` LIKE '%SMALL%' THEN 1 ELSE 0 END) / SUM(1)  N_SMALL,
    SUM(CASE WHEN `REVIEW TEXT` LIKE '%TIGHT%' THEN 1 ELSE 0 END) / SUM(1)  N_TIGHT,
    SUM(1) N_TOTAL
FROM dataset2
GROUP BY 1, 2
ORDER BY 1, 2;

-- Clothing ID별 SIZE REVIEW 
-- 각 제품 분석
SELECT
	`Clothing ID`,
    SUM(CASE WHEN `REVIEW TEXT` LIKE '%SIZE%' THEN 1 ELSE 0 END) AS N_SIZE
FROM dataset2
GROUP BY 1;

-- Size 타입 추가
SELECT
	`Clothing ID`,
	SUM(CASE WHEN `REVIEW TEXT` LIKE '%SIZE%' THEN 1 ELSE 0 END) / SUM(1)  N_SIZE,
    SUM(CASE WHEN `REVIEW TEXT` LIKE '%LARGE%' THEN 1 ELSE 0 END) / SUM(1)  N_LARGE,
    SUM(CASE WHEN `REVIEW TEXT` LIKE '%LOOSE%' THEN 1 ELSE 0 END) / SUM(1)  N_LOOSE,
    SUM(CASE WHEN `REVIEW TEXT` LIKE '%SMALL%' THEN 1 ELSE 0 END) / SUM(1)  N_SMALL,
    SUM(CASE WHEN `REVIEW TEXT` LIKE '%TIGHT%' THEN 1 ELSE 0 END) / SUM(1)  N_TIGHT,
    SUM(1) N_TOTAL
FROM dataset2
WHERE `department name` = 'Bottoms'
GROUP BY 1;

CREATE TABLE size_stat_as
SELECT
	`Clothing ID`,
	SUM(CASE WHEN `REVIEW TEXT` LIKE '%SIZE%' THEN 1 ELSE 0 END) / SUM(1) AS N_SIZE_T,
    SUM(CASE WHEN `REVIEW TEXT` LIKE '%LARGE%' THEN 1 ELSE 0 END) / SUM(1) AS N_LARGE,
    SUM(CASE WHEN `REVIEW TEXT` LIKE '%LOOSE%' THEN 1 ELSE 0 END) / SUM(1) AS N_LOOSE,
    SUM(CASE WHEN `REVIEW TEXT` LIKE '%SMALL%' THEN 1 ELSE 0 END) / SUM(1) AS N_SMALL,
    SUM(CASE WHEN `REVIEW TEXT` LIKE '%TIGHT%' THEN 1 ELSE 0 END) / SUM(1) AS N_TIGHT,
    SUM(1) N_TOTAL
FROM dataset2
GROUP BY 1;

SELECT * FROM size_stat_as;
    