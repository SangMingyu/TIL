USE classicmodels;

-- [SELECT]
SELECT customerNumber, phone FROM customers;

-- [COUNT] : 행의 갯수, 각 컬럼의 값의 갯수를 파악할 때 
SELECT COUNT(checknumber) FROM payments;
SELECT COUNT(*) FROM payments;

-- 테이블 정의서를 보고 테이블의 형태를 파악!
SELECT * FROM payments; -- 실무에서는 이 쿼르를 사용하면 사수한테 혼남!!
SELECT SUM(amount) FROM payments;

SELECT productname, productline
FROM products;

-- [특정 컬럼명 변경]
SELECT
 COUNT(productcode) AS n_products,
 COUNT(productcode) n_products,
 COUNT(productcode),
 COUNT(productcode) AS 갯수
FROM
 products;
 
 -- 교재 31p
 -- DISTINCT : 중복 제외하고 데이터 조회!
SELECT DISTINCT ordernumber
FROM orderdetails;
 
SELECT
	COUNT(ordernumber) AS 중복포함,
    COUNT(DISTINCT ordernumber) AS 중복제거
FROM orderdetails;

-- [WHERE] SQL문법에서 WHERE절을 익히는 것이 60%
-- Online 튜토리얼, WHERE 절 집중적으로 익히는 것 추천

-- [WHERE, BETWEEN]
SELECT *
FROM orderdetails
WHERE priceeach BETWEEN 30 AND 50;

-- [WHERE, 대소관계 연산자]
SELECT *
FROM orderdetails
WHERE priceeach < 30;

SELECT COUNT(*)
FROM orderdetails
WHERE priceeach < 30;

SELECT *
FROM payments
WHERE amount < 6666;

-- [WHERE, IN]
-- 주의할 점은 컬럼의 값이 "값1" 또는 "값2"인 데이터가 출력된다!
-- 서브쿼리 사용할 때 자주 사용되는 연산자
-- France 추가

SELECT 
	customernumber, country
FROM customers
WHERE country = 'USA' OR country = 'Canada' OR country = 'France';

SELECT 
	customernumber, country
FROM customers
WHERE country IN ('USA', 'Canada', 'France');

-- [WHERE, NOT IN]
SELECT 
	customernumber, country
FROM customers
WHERE country NOT IN ('USA', 'Canada', 'France');

-- [WHERE, IN NULL]

SELECT * FROM employees;

SELECT employeenumber
FROM employees
WHERE reportsto IS NULL;

SELECT employeenumber
FROM employees
WHERE reportsto IS NOT NULL;

SELECT 
	COUNT(employeenumber),
	COUNT(reportsto), -- NULL이 존재하면 COUNT 하지 않는다!
    COUNT(*)
FROM employees;

SELECT COUNT(reportsto) FROM employees;

-- [WHERE, LIKE '%TEXT%'] p.42
-- %는 문자를 의미한다. 부산 앞, 뒤로 어떤 문자가 와도 상관없다!
SELECT
	addressline1
FROM customers
WHERE addressline1 LIKE '%ST%';

SELECT
	addressline1
FROM customers
WHERE addressline1 LIKE '%ST.%';

SELECT
	addressline1
FROM customers
WHERE addressline1 LIKE '%ST.';

-- GROUP BY
SELECT
	country, -- 문자 컬럼
    city,    -- 문자 컬럼
    COUNT(customernumber) AS n_customers
FROM customers
GROUP BY country, city;

SELECT * FROM payments;
SELECT 
	customerNumber,
    checknumber,
    SUM(amount)
FROM payments
GROUP BY customerNumber, checknumber;

-- [CASE WHEN] : IF 조건문
-- p.46, USA 거주자의 수 계산, 그 비중을 구하자!
SELECT 
	SUM(CASE WHEN country = 'USA' THEN 1 ELSE 0 END) N_USA
FROM customers;

SELECT 
	country
	, CASE WHEN country = 'USA' THEN 1 ELSE 0 END N_USA
FROM customers;

-- 비율 같이 구해보면
SELECT 
	SUM(CASE WHEN country = 'USA' THEN 1 ELSE 0 END) N_USA,
    COUNT(*),
    SUM(CASE WHEN country = 'USA' THEN 1 ELSE 0 END) / COUNT(*) AS USA_PORTION
FROM customers;

-- [JOIN]
-- 실무에서는 ERD를 그림을 보면서, 어떻게 JOIN 할 것 인지 계획을 짬
SELECT
	A.orderNumber,
    B.country
FROM orders A
LEFT
JOIN customers B
ON A.customernumber = B.customernumber;

SELECT
	COUNT(*)
FROM orders A
LEFT
JOIN customers B
ON A.customernumber = B.customernumber
WHERE B.country = 'USA';

-- INNER JOIN
SELECT
	COUNT(*)
FROM orders A
INNER
JOIN customers B
ON A.customernumber = B.customernumber
WHERE B.country = 'USA';

-- FULL JOIN
-- A 테이블 갯수 1000개, B 테이블 100개 정도 된다며 상관 X
-- 실무에서는 1억개, 천만개 이러니 문제가 생김
SELECT
	*
FROM orders
FULL
JOIN customers
ON orders.customernumber = customers.customernumber;

-- 58p
-- 윈도우 함수 : RANK, DENSE_RANK, ROW_NUMBER
-- 중요함!
SELECT
	buyprice,
    ROW_NUMBER() OVER(ORDER BY buyprice) ROWNUMBER,
    RANK() OVER(ORDER BY buyprice) RNK,
    DENSE_RANK() OVER(ORDER BY buyprice) DENSERANK
FROM products;

-- p.61 PARTITION BY
SELECT
	productline,
	buyprice,
    ROW_NUMBER() OVER(PARTITION BY productline ORDER BY buyprice) ROWNUMBER,
    RANK() OVER(PARTITION BY productline ORDER BY buyprice) RNK,
    DENSE_RANK() OVER(PARTITION BY productline ORDER BY buyprice) DENSERANK
FROM products;

-- 62p
-- SubQuery : 매우매우매우매우 중요함!
-- 서브쿼리 : 쿼리 안에 또 다른 쿼리를 사용하는 것 (갯수는 무제한!)
SELECT
	(A(B(C)),
    (B)
FROM (A(B(C)))
WHERE col IN (D)
GROUP BY
HAVING (E)
ORDER BY (F)