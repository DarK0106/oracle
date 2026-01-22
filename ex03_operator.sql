-- ex03_operator.sql

/*

    연산자, Operator
    
    1. 산술 연산자 + - * / <- 여긴 나머지 연산자 없음, 함수로 제공이 됨(mod())
        
    2. 문자열 연산자(concat)
    ||(문자열 더하기)
    
    3. 비교 연산자
    >, >=, <, <=
    = (자바에서의 ==), <>(자바에서의 !=)
    논리값 반환 -> boolean(참, 거짓)을 반환해야하는데, 오라클엔 boolean 없음 -> 표현이 불가능함
    내부적으로는 쓸 수 있는데 사람한테는 못보여줌
    비교 연산자는 절대로 컬럼 리스트에서 쓸 수 없다
    조건절에서는 사용 가능
        
    *모든 연산자는 피연산자로 null을 가질 수 없다 
    10 + 0 = 10
    10 + null = 연산 불가능
    
    4. 논리 연산자
    and(&&) or(||) not(!)
    컬럼 리스트에서 사용 불가
    조건절에서 사용 가능
    
    5. 대입 연산자
    =
    ex. 컬럼 = 값
    update 문에서만 사용
    복합 대입 연산자는 없다
    
    6. 3항 연산자
    없다
    제어문 자체가 없기 때문
    
    7. 증감 연산자
    없음
    
    8. SQL 연산자
    자바 -> instanceof
    SQL -> in, between, like, is 등 ..

*/


SELECT
    *
FROM
    tblcountry;

SELECT
    population,
    area,
    population + 10,
    population - 10,
    population * 10,
    population / 2,
    population + area
FROM
    tblcountry;

SELECT
    *
FROM
    tblcountry;

SELECT
    name,
    capital,
    name || capital,
    name
    || ':'
    || capital
FROM
    tblcountry;

SELECT
    area > 100
FROM
    tblcountry;

SELECT
    *
FROM
    tblcountry
WHERE
    area > 100; -- 조건절

SELECT
    *
FROM
    tblcountry
WHERE
    name = '대한민국'; -- 조건절

SELECT
    *
FROM
    tblcountry
WHERE
    name <> '대한민국'; -- 조건절

SELECT
    *
FROM
    tblcountry
WHERE
        continent = 'AS'
    AND NOT ( area > 100 );

SELECT
    *
FROM
    tblcountry
WHERE
    continent = 'AS'
    OR area > 100;

SELECT
    *
FROM
    tblcountry
WHERE
        continent = 'AS'
    AND NOT area > 100;

/*
    테이블이나 컬럼에 별명을 붙일 수 있음(Alias)
    
    컬럼의 별칭
    컬럼은 이미 이름이 존재하는데 별명은 왜붙임?
    결과셋의 컬렴명을 바꿔준다.
    결과셋의 컬럼명들을 올바르게 유지하고 싶을 때 ..
    
    1. 컬럼명이 중복될때
    2. 컬럼을 가공했을 때
    
    테이블 별칭
     - 결과셋과는 무관
     - SQL 작성 시 사용



*/

SELECT
    name,
    capital
FROM
    tblcountry; -- 국가명, 수도명 <- Alias(별명)

SELECT
    name
FROM
    tblmen;

SELECT
    name
FROM
    tblwomen; -- 테이블은 다르지만 같은 컬럼?

SELECT
    tblmen.name   AS 남자_이름,
    tblwomen.name AS 여자_이름
FROM
         tblmen
    INNER JOIN tblwomen ON tblmen.name = tblwomen.couple;

SELECT
    name,
    length(name)      AS 국가명_글자수,
    area * 2 + 10     AS 면적_연산_결과,
    population + area AS 기타
FROM
    tblcountry; -- 2. 컬럼을 가공했을 때, ""안에 넣으면 띄어쓰기 가능, 키워드명인 select도 별명으로 쓸 수 있음
-- 하지만 쓰면 안됨

SELECT
    name,
    capital
FROM
    tblcountry;

select hr.tblCountry.name, hr.tblCountry.capital from hr.tblCountry;

SELECT
    c.name,
    c.capital -- 그 다음에 이거
FROM
    hr.tblcountry c; -- 이게 첫번째