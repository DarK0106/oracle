-- ex17_groupby.sql

/*

    [WITH <Sub Query>]
    SELECT column_list
    FROM table_name
    [WHERE search_condition]
    [GROUP BY group_by_expression]
    [HAVING search_condition]
    [ORDER BY order_expression [ASC|DESC]];

    SELECT column_list -- 원하는 컬럼을 지정해서 그 컬럼만 가져와라 (ex.난 학생들의 국어 점수만 보고 싶다) 
    FROM table_name    -- 데이터 소스. 어떤 테이블로부터 데이터를 가져와라
    WHERE search_condition -- 행 조건을 지정해서 원하는 행을 가져옴
    GROUP BY group_by_expression -- 그룹을 나눈다
    ORDER BY order_expression -- 레코드를 정렬 -> 정렬 기준을 뭘로 할까? -> 컬럼
    
    
    각 절의 순서(매우중요)
    4. SELECT <- 거의 대부분 SELECT가 꼴등
    1. FROM
    2. WHERE
    3. GROUP BY
    5. ORDER BY
    
    group by 절
    - 특정 기준(주로 컬럼값)으로 레코드들의 그룹을 나눈다.(수단)
        -> 각각의 그룹을 대상으로 집계 함수를 실행한다.(목적)
*/

select * from tblInsa;

-- tblInsa에서 직위별 평균 급여?
select round(avg(basicpay)) from tblInsa;

select round(avg(basicpay)) from tblInsa where jikwi = '부장';
select round(avg(basicpay)) from tblInsa where jikwi = '과장';
select round(avg(basicpay)) from tblInsa where jikwi = '대리';
select round(avg(basicpay)) from tblInsa where jikwi = '사원';

select distinct jikwi from tblInsa;

select round(avg(basicpay)) from tblInsa group by jikwi; -- 이렇게 쓰면 뭐가 누구의 급여인지 알 수 없음

select 
    jikwi, 
    round(avg(basicpay)) as "직위별 평균 급여", 
    count(*) as "직위별 인원수", 
    sum(basicpay) as "직위별 총지급액",
    max(basicpay) as "직위별 최고 급여",
    min(basicpay) as "직위별 최저 급여"
from tblInsa 
    group by jikwi;

-- 남자 인원수와 여자 인원수?
select count(*) from tblcomedian where gender = 'm';
select count(*) from tblcomedian where gender = 'f';

select
    count(case
        when gender = 'm' then 1
    end) as m,
    count(case
        when gender = 'f' then 1
    end) as f
from tblcomedian;

select
    count(decode(gender, 'm', 1)) as m,
    count(decode(gender, 'f', 1)) as f
from tblcomedian;

select
    gender,
    count(*)
from tblcomedian
    group by gender;
    
select
    buseo,
    count(*) as "부서별 인원수"
from tblInsa
    group by buseo
        -- order by 2 desc; <- 어지간하면 쓰지 않는것이 좋다
        -- order by "부서별 인원수" asc;
        order by count(*) desc;
        
        
select
    buseo,
    count(*)
from tblInsa
    group by buseo;
    
-- 1차 그룹 -> 2차 그룹 -> 3차 그룹
select
    jikwi,
    count(*)
from tblInsa
    group by jikwi; -- 1차 그룹
    
select
    jikwi, -- group by에 있는건 컬럼 리스트에 들어갈 수 있음
    buseo,
    count(*)
from tblInsa
    group by jikwi, buseo; -- 2차 그룹
    
-- 급여별 그룹?
-- 100만원 미만
-- 100만원 이상 ~ 200만원 미만
-- 200만원 이상
select
    basicpay,
    count(*)
from tblInsa
    group by basicpay;
    
select (floor(basicpay / 1000000) + 1) * 100 || '만원 이하' as money,
       count(*)
from tblinsa
    group by floor(basicpay / 1000000);
    
-- tblInsa에서의 남자 인원 수? 여자 인원 수?

select
    substr(ssn, 8, 1),
    count(*)
from tblInsa
    group by substr(ssn, 8, 1);
    
SELECT
    CASE
        WHEN substr(ssn, 8, 1) = '1' THEN '남자'
        WHEN substr(ssn, 8, 1) = '2' THEN '여자'
    END AS 성별,
    count(*) AS 인원수
FROM tblInsa
GROUP BY substr(ssn, 8, 1);

-- tblTodo 완료가 된 일, 완료가 되지 않은 일의 각각 개수?
select
    completedate,
    count(*)
from tblTodo
    group by completedate;
    
select
    case
        when completedate is not null then 1
        else 2
    end,
    count(*)
from tblTodo
    group by case
        when completedate is not null then 1
        else 2
    end;
    
-- tblInsa 에 과장 + 부장이 몇명이고 사원 + 대리가 몇명임?
select
    case
        when jikwi in ('과장', '부장') then 1
        else 2 -- 사원 대리
    end as 직위,
    count(*)
from tblInsa
    group by case
        when jikwi in ('과장', '부장') then 1
        else 2 -- 사원 대리
    end;