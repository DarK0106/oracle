-- ex02_select.sql
-- select <- 가장 사용 빈도 수가 많음, 엄청 중요함

/*
    SELECT 문
    - DML, DQL
    - 특정 테이블로부터 원하는 데이터를 가져온다.
    - OO절 -> 각각의 기능이 있음
    
    [WITH <Sub Query>]
    SELECT column_list
    FROM table_name
    [WHERE search_condition]
    [GROUP BY group_by_expression]
    [HAVING search_condition]
    [ORDER BY order_expression [ASC|DESC]];

    SELECT column_list -- 원하는 컬럼을 지정해서 그 컬럼만 가져와라 (ex.난 학생들의 국어 점수만 보고 싶다) 
    FROM table_name    -- 데이터 소스. 어떤 테이블로부터 데이터를 가져와라
    
    각 절의 순서(매우중요)
    1. FROM
    2. SELECT
    
*/

SELECT
    regdate
FROM
    tbltype;

SELECT
    regdate
FROM
    tbltype;

SELECT
    regdate    -- 그런 다음 이거  
FROM
    tbltype; -- 이거 먼저 실행


SELECT
    txt
FROM
    tbltype;

SELECT
    *
FROM
    tabs; -- tabs -> tables, 시스템 테이블이라고 함

-- EMPLOYEES 구조?
desc employees;

SELECT
    *        -- * <- 와일드카드, 모든 컬럼
FROM
    employees;

SELECT
    last_name,
    first_name,
    phone_number
FROM
    employees;

SELECT
    *
FROM
    tblcountry;

SELECT
    *
FROM
    tblcomedian;

SELECT
    *
FROM
    tbldiary;

SELECT
    *
FROM
    tblinsa;

SELECT
    *
FROM
    tblmen;

SELECT
    *
FROM
    tblwomen;

SELECT
    *
FROM
    tbltodo;

SELECT
    *
FROM
    tblhousekeeping;

SELECT
    *            -- * <- 모든 컬럼
FROM
    tblcountry;

SELECT
    name         -- 내가 원하는 컬럼인 name
FROM
    tblcountry;

SELECT
    name,
    capital -- name, capital 만 보겠다, 다중 컬럼
FROM
    tblcountry;

-- 다중 컬럼 할때 순서는 마음대로 써도 됨 name, capital 이나 capital, name 해도 ㄱㅊ

SELECT
    name,
    name    -- 같은 컬럼 여러번 가져오는것도 가능 근데 쓸데가없음
FROM
    tblcountry;

SELECT
    name,
    length(name)    -- 함수 length() 사용
FROM
    tblcountry;

-- select 질의 <- 쿼리를 날린다고함 -> select는 항상 결과를 반환함 -> 결과값도 항상 테이블이다 
-- -> 나온 테이블을 결과 테이블(Result Table)이라고 함, 결과 셋(Result Set) 이라고도 함

-- 에러?
SELECT
    *
FROM
    tblcountr; -- ORA -00942:테이블 또는 뷰가 존재하지 않습니다

SELECT
    nam
FROM
    tblcountry; -- ORA -00904: "NAM": 부적합한 식별자