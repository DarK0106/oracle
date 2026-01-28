-- ex26_with.sql

/*

    [WITH <Sub Query>]
    SELECT column_list
    FROM table_name
    [WHERE search_condition]
    [GROUP BY group_by_expression]
    [HAVING search_condition]
    [ORDER BY order_expression [ASC|DESC]];
    
    WITH <Sub Query> -- 인라인뷰에 잠시 이름을 붙인다(이유: 가독성)
    SELECT column_list -- 원하는 컬럼을 지정해서 그 컬럼만 가져와라 (ex.난 학생들의 국어 점수만 보고 싶다) 
    FROM table_name    -- 데이터 소스. 어떤 테이블로부터 데이터를 가져와라
    WHERE search_condition -- 행 조건을 지정해서 원하는 행을 가져옴
    GROUP BY group_by_expression -- 그룹을 나눈다
    HAVING search_condition -- 그룹 조건 지정, 그룹한테 물어보는 조건 -> 원하는(조건을 만족하는) 그룹만 가져와라
    ORDER BY order_expression [ASC|DESC] -- 레코드를 정렬 -> 정렬 기준을 뭘로 할까? -> 컬럼
    
    
    각 절의 순서(매우중요)
    1. WITH
    6. SELECT <- 거의 대부분 SELECT가 꼴등
    2. FROM
    3. WHERE
    4. GROUP BY
    5. HAVING
    7. ORDER BY
    
*/

-- 인라인뷰의 특징 이름이 없다(익명 테이블)
select * from 
    (select name, buseo, jikwi from tblInsa where city = '서울') seoul;

with seoul as (select name, buseo, jikwi from tblInsa where city = '서울')
select * from seoul;

-- tblMen.몸무게(90이하) + tblWomen.몸무게(60초과) > join
-- tblMen inner join tblWomen

create or replace view vwMen
as
select name, age, couple from tblMen where weight <= 90;

create or replace view vwWomen
as
select name, age, couple from tblWomen where weight > 60;

select * from (select name, age, couple from tblMen where weight <= 90) a
    inner join (select name, age, couple from tblWomen where weight > 60) b
        on a.couple = b.name;
        
select * from vwMen a
    inner join vwWomen b
        on a.couple = b.name;
        
with a as (select name, age, couple from tblMen where weight <= 90),
     b as (select name, age, couple from tblWomen where weight > 60)
        select * from a
            inner join b
                on a.couple = b.name;