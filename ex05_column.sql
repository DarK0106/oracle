--ex05_column.sql

-- 컬럼 리스트에서 할 수 있는 행동들
-- select 컬럼리스트

-- 컬럼명
select name, jikwi, buseo from tblInsa;

-- 이렇게 가져온 컬럼들을 연산해서 가공하기도 함
select name || '님', sudang * 2 from tblInsa; -- 컬럼명까지 바뀌어서 Alias 까지 사용하는걸 권장

-- 상수
select name, 100
    from tblInsa;
    
select 100
    from tblInsa;
    
-- 함수
select name, length(name) from tblcountry;

/*
    
    Java Stream 수업 -> list.stream().distinct().forEach()

    distinct
    - 컬럼 리스트에서 사용
    - 레코드의 중복값 제거
    - distinct 컬럼명 -> 사용법이 이게 아님
    - distinct 컬럼 리스트 -> 이게 정확한 사용법
*/

-- tblCountry. 어떤 대륙들이 있어요? -> 그룹으로 질문한것
-- ex. 당신네 회사에는 직급이 뭐가 있나요?
select distinct continent from tblCountry;

-- tblInsa
select distinct buseo from tblinsa;
select distinct jikwi from tblinsa;
select distinct city from tblinsa;
select distinct name from tblinsa; -- 중복된 이름이 없어서 의미 없음

select distinct buseo, name from tblinsa;

select distinct buseo, jikwi from tblInsa;

/*

    SQL -> 제어문이 없음
    
    case문
    - 대부분의 절에서 사용가능
    - 조건문 역할 -> 주로 컬럼값을 조작할 때 많이 사용
    - 자바로 치면 다중 if 문 또는 switch case 문
    - 조건을 만족하면 then에 있는 값을 반환
    - 조건을 만족하지 못하면 null을 반환함(*중요)
    
    
    언어
    1. C 계열 -> 컴파일 언어 -> java, c#
    2. Basic 계열 -> 인터프리터 언어 -> 주로 스크립트 언어라고 함 -> python
    SQL은 Basic 계열과 많이 닮아 있음
    
*/

select Last || First as name, gender, -- Alias 붙이자
case
    --when 조건 then 값               -- if문과 유사함
    when gender = 'm' then '남자'
    when gender = 'f' then '여자'
end as genderName,                    -- case end 가 하나의 컬럼
case gender
    when 'm' then '남자'
    when 'f' then '여자'
end as genderName2
from tblcomedian;

select
    name, continent,
    case
        when continent = 'AS' then '아시아'
        when continent = 'EU' then '유럽'
        when continent = 'AF' then '아프리카'
        else continent
    end as continentName
from tblcountry;

select
    name, continent,
    case continent
        when 'AS' then '아시아'
        when 'EU' then '유럽'
        when 'AF' then '아프리카'
        else continent
    end as continentName
from tblcountry;

select
    last || first as name, weight,
    case
        when weight > 90 then '과체중'
        when weight > 50 then '저체중'
        else '저체중'
    end state,
    case
        when weight >= 50 and weight <= 90 then '정상체중'
        else '주의체중'
    end state2,
    case
        when weight between 50 and 90 then '정상체중'
        else '주의체중'
    end state3
from tblcomedian;

-- 사원, 대리 -> 현장직
-- 과장, 부장 -> 관리직
select
    name, jikwi,
    case
        when jikwi = '사원' or jikwi = '대리' then '현장직'
        when jikwi = '과장' or jikwi = '부장' then '관리직'
    end
from tblInsa;

select
    name, jikwi,
        case
            when jikwi in('사원', '대리') then '현장직'
            when jikwi in ('과장', '부장') then '관리직'
        end
from tblInsa;

select
    name, ssn,
        case
            when ssn like '%-1%' then '남자'
            when ssn like '%-2%' then '여자'
        end as Gender
from tblInsa;

select
    title,
    case
        when completedate is not null then '완료'
        when completedate is null then '미완료'
    end
from tblTodo;