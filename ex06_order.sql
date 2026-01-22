--ex06_order.sql

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
    ORDER BY order_expression -- 레코드를 정렬 -> 정렬 기준을 뭘로 할까? -> 컬럼
    
    
    각 절의 순서(매우중요)
    3. SELECT <- 거의 대부분 SELECT가 꼴등
    1. FROM
    2. WHERE
    4. ORDER BY
    
    
    ex.ORDER BY 컬럼명
    ORDER BY 컬럼명 ASC
    ORDER BY 컬럼명 DESC
    ORDER BY 컬럼명 [ASC|DESC] [, 컬럼명 [ASC|DESC]] * n
    
    ASC -> Ascending -> 오름차순
    DESC -> Descending -> 내림차순

*/

-- 원본 테이블이 저장된 레코드의 순서는 어떤 정렬 상태인지 알 수가 없다
-- 오라클 맘대로 함 -> 오라클이 안 알려줌
-- num으로 정렬된것처럼 보이지만 그건 우연이고, 사실은 정렬되어있지 않은 상태인 것

select * from tblInsa;
select * from tblInsa order by name;
select * from tblInsa order by name asc;
select * from tblInsa order by name desc;

select * from tblInsa order by jikwi asc; -- 1차 정렬
select * from tblInsa order by jikwi asc, buseo desc; -- 2차 정렬
select * from tblInsa order by jikwi asc, buseo desc, basicpay asc; -- 3차 정렬

-- 정렬은 크다 작다를 정렬하는것 -> 비교 가능한 대상은 숫자 문자 날짜
select * from tblInsa order by basicpay desc; -- 숫자
select * from tblInsa order by name asc; -- 문자
select * from tblInsa order by ibsadate asc; -- 날짜

-- order by 는 select 절의 컬럼 인덱스를 사용해서 정렬 가능
-- SQL은 첨자가 1부터 시작
-- 평상시엔 사용 금지
-- 컬럼 순서 바꾸면 정렬도 바뀌기 때문
select -- 두번째로 실행
    name, buseo, jikwi
from tblInsa    -- 첫번째로 실행
    order by 1 asc; -- 세번째로 실행, order by n, n은 컬럼 순서
   
-- 급여(기본급 + 상여급)순으로
select * from tblInsa order by basicpay + sudang desc;

-- 직위순으로 정렬
select * from tblInsa order by jikwi asc;

select
    name, jikwi
from tblInsa;

select
    name, jikwi,
    case jikwi
        when '부장' then 4
        when '과장' then 3
        when '대리' then 2
        when '사원' then 1
    end as jikwiSeq
from tblInsa
    order by jikwiSeq desc;
    
select
    name, jikwi
from tblInsa
    order by case
            when jikwi = '부장' then 4
            when jikwi = '과장' then 3
            when jikwi = '대리' then 2
            when jikwi = '사원' then 1
        end desc;
        
--tblInsa. 남자 -> 여자 순으로
select
    name, ssn, buseo
from tblInsa
    order by case
        when ssn like '%-1%' then 1
        when ssn like '%-2%' then 2
    end asc;