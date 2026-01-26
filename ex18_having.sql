-- ex18_having.sql

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
    HAVING search_condition -- 그룹 조건 지정, 그룹한테 물어보는 조건 -> 원하는(조건을 만족하는) 그룹만 가져와라
    ORDER BY order_expression [ASC|DESC] -- 레코드를 정렬 -> 정렬 기준을 뭘로 할까? -> 컬럼
    
    
    각 절의 순서(매우중요)
    5. SELECT <- 거의 대부분 SELECT가 꼴등
    1. FROM
    2. WHERE
    3. GROUP BY
    4. HAVING
    6. ORDER BY
    
    having 절
    - 그룹에 대한 조건절
    
*/

select                          -- 3. 그룹별 통계값을 구한다.
    buseo,
    count(*),
    round(avg(basicpay))
from tblInsa                    -- 1. 60명의 데이터를 가져온다.
    group by buseo;             -- 2. 60명을 대상으로 부서별 그룹을 나눈다.
    
select                          -- 4. 그룹별 통계값을 구한다.
    buseo,
    count(*),
    round(avg(basicpay))
from tblInsa                    -- 1. 60명의 데이터를 가져온다.
    where basicpay >= 1500000   -- 2. 60명 중 급여가 150만원 이상인 사람만 가져오기           
    group by buseo;             -- 3. where 절을 거치고 난 3n명을 대상으로 부서별 그룹을 나눈다.
    
    
select                          -- 4. 그룹별 통계값을 구한다.
    buseo,
    count(*),
    round(avg(basicpay))
from tblInsa                    -- 1. 60명의 데이터를 가져온다.
    group by buseo              -- 2. 60명을 대상으로 부서별 그룹을 나눈다.
        having(avg(basicpay)) >= 1500000; -- 3. 각 그룹별 평균 급여가 150만원 이상
    
-- having 은 group 에 대한 조건절


-- 각 부서별(group by) 과장 + 부장 인원수(where)가 3명이 넘는(having) 부서들은 어디일까?
select
    buseo,
    count(*)
from tblInsa
    where jikwi in ('과장', '부장')
        group by buseo
            having count(*) >= 3;














