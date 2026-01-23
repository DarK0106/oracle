--ex11_datetime_function.sql

/*

    날짜시간 함수
    
    sysdate
    - 시스템의 시각을 반환
    - date sysdate


*/

select sysdate from dual;

/*

    날짜 연산
    1. 시각 - 시각 = 시간
    2. 시각 + 시간 = 시각
    3. 시각 - 시간 = 시각

*/

-- 1. 시각 - 시각 = 시간(일) -> 시 분 초로 내려갈 수는 있는데
-- 단위를 월, 년으로 올리지는 못함
-- 현재 시간 - 입사일 = 근무시간
select
    name, to_char(ibsadate, 'yyyy-mm-dd') as 입사일,
    round(sysdate - ibsadate) as 근무일수, -- 소숫점이 너무 길어서 round로 반올림
    round((sysdate - ibsadate) * 24) as 근무시수,
    round(((sysdate - ibsadate) * 24) * 60) as 근무분수,
    round(((sysdate - ibsadate) * 24 * 60) * 60) as 근무분수,
    round((sysdate - ibsadate) / 30.4) as 근무개월수, -- 절대금지
    round((sysdate - ibsadate) / 365) as 근무년수 -- 절대금지
from tblinsa;

-- 홍길동	2008-10-11	6313.652465277777777777777777777777777778

select
    title, adddate, completedate,
    round((completedate - adddate) * 24) as "실행하기 까지 걸린 시간" -- 언제 하기로 마음먹어서 실제로 실행하기까지 걸린 시간
from tblTodo
    -- order by 4 asc
    -- order by "실행하기 까지 걸린 시간" asc
    order by round((completedate - adddate) * 24) asc;
    
-- 02. 시각 + 시간(일 로 고정되어있음) = 시각
-- 03. 시각 - 시간(일) = 시각

select
    sysdate,
    sysdate + 100 as "100일 후",
    sysdate - 100 as "100일 전",
    to_char(sysdate + (3 /24), 'hh24:mi:ss') as "3시간 뒤",
    to_char(sysdate - (30 / 60 /24), 'hh24:mi:ss') as "30분 전"
from dual;

-- 문제) 최대 단위가 '일'이다.

/*
    날짜 연산(월, 년)
    - 시각 - 시각 = 시간(월 로 하고싶음)
    - number months_between(date, date) 라는 함수를 써야함


*/
select
    name,
    round(sysdate - ibsadate) as 근무일수,
    round(months_between(sysdate, ibsadate)) as 근무개월수,
    round((months_between(sysdate, ibsadate)) / 12) as 근무년수
from tblinsa;

/*

    add_months()
    - 시각 + 시간(월) = 시각
    - 시각 - 시간(월) = 시각

*/

select
    sysdate,
    sysdate + 3,
    add_months(sysdate, 3),
    add_months(sysdate, -2),
    add_months(sysdate, 3 * 12) -- 3년 뒤
from dual;

/*

    시각 - 시각 = 시간
    1. 일, 시, 분, 초 -> 연산자(-)
    2. 월, 년 -> months_between()
    
    시각 + 시간, 시각 - 시간 = 시각
    1. 일, 시, 분 초 -> 연산자(+,-)
    2. 월, 년 -> add_months()

*/

-- null 값에 대한 처리를 하기 위한 함수 -> null value
-- 1. nvl -> 값이 있으면 그 값을 쓰고 없으면(null 이면) 대체값을 사용하세요
-- 2. nvl2

select name, population,
    case
        when population is not null then population
        when population is null then 0
    end,
    nvl(population, 0),
    nvl2(population, 1, 2), -- 값이 있으면 앞에거(1) 반환, 값이 없으면 뒤에거(2) 반환
    -- 당연히 1, 2는 변경 가능
    nvl2(population, '인구 기재됨', '인구 기재되지 않음')
    from tblCountry;