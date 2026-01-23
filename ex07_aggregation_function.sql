-- ex07_aggregation_function.sql

/*
    클래스 내에 선언된 함수를 메서드라고 한다.
    
    자바는 객체 지향의 메서드
    - 모든 기능이 객체 안에 구현 -> 데이터(변수), 행동(메서드)
    - s1.getTotal() // 개인 행동
    - Student.getXXX() // 단체 행동
    
    SQL에는 메서드라는 개념은 없고 함수라는 이름은 있음
    - 주체가 없다.
    - 함수 자체로 존재한다.
    
    함수, Function
    1. 내장 함수, Built-in Function <- 미리 만들어진 함수
    2. 사용자 정의 함수, User Function <- ANSI-SQL 에는 이런 기능이 없음, 오라클이 따로 만든 PL/SQL 에서만 존재
    
    집계 함수, 통계 함수(Aggregation Fuction)
    - Java Stream -> count(), sum(), avg(), max(), min() 얘네와 거의 똑같
    
    1. count()
    2. sum()
    3. avg()
    4. max()
    5. min()
    
    1. count()
    - 결과 테이블의 레코드 수를 반환
    - number count(*) <- 특정 컬럼에 null 유무와 상관없이 모든 레코드의 수를 세겠습니다
    - number count(특정 컬럼명) <- null 을 예상하고 레코드 수를 세겠습니다
    - null 값을 제외한다는걸 기억하자

*/

select * from tblCountry; --14
select count(*) from tblCountry; --14
select count(name) from tblCountry; --14
select count(capital) from tblCountry; --14
select count(population) from tblCountry; --13, NULL 값이 하나 있었다

select name from tblcountry;
select capital from tblCountry;
select population from tblCountry;

-- 그 결과셋에 실존하는 행의 개수를 세줘라 count()
-- 그럼 count(*) 은? -> 모든 컬럼이니까 케냐에 인구수 없어도 레코드는 있으니
-- 케냐 행도 개수에 포함되는것

-- 연락처가 있는 직원수??
select count(tel) from tblInsa;
select count(*) from tblInsa where tel is not null; -- 57


-- 연락처가 없는 직원수?
select count(*) - count(tel) from tblInsa;
select count(*) from tblInsa where tel is null;

-- 어떤 부서들이 있나요?
select distinct buseo from tblInsa;

select count(distinct buseo) from tblInsa;

-- tblComedian 남자수? 여자수?
select * from tblcomedian;

select count(*) from tblcomedian where gender = 'm';
select count(*) from tblcomedian where gender = 'f';

-- *자주 쓰는 패턴*
-- 남자수와 여자수를 한개의 테이블로 가져오시오

select
    count(case
        when gender ='m' then '남자'
    end) as "남자 인원수",
    count(case
        when gender = 'f' then '여자'
    end) as "여자 인원수"
from tblcomedian;

select
    case
        when gender ='m' then '남자'
        when gender = 'f' then '여자'
    end
from tblcomedian; -- case 가 null 을 반환한다는 특성을 포기했기 때문에 적절하지 못함

-- tblInsa 기획부 몇명? 총무부 몇명? 개발부 몇명?

select count(*) from tblInsa where buseo = '기획부';

select
    count(case
        when buseo = '기획부' then 1 -- then 으로 뭘 반환하던 상관없음 count에선 그게 중요한게 아니기 때문
    end) as "기획부 인원수",
    count(case
        when buseo = '총무부' then 2
    end) as "총무부 인원수",
    count(case
        when buseo = '개발부' then 3
    end) as "개발부 인원수",
    count(case
        when buseo not in ('기획부', '총무부', '개발부') then 4 -- not 과 in 활용
    end) as "나머지 부서 인원수"
from tblInsa;


/*

    2. sum()
    - 해당 컬럼의 합을 구한다
    - number sum(컬럼명)
    - 숫자형 컬럼에만 적용
    
    
*/

select sum(population), sum(area) from tblcountry;
select sum(name) from tblCountry; --ORA-01722: 수치가 부적합합니다
select sum(ibsadate) from tblInsa; -- ORA-00932: 일관성 없는 데이터 유형: NUMBER이(가) 필요하지만 DATE임
select sum(*) from tblCountry; -- 당연히 안 됨

select
    sum(basicpay) as 지출급여합,
    sum(sudang) as 지출수당합,
    sum(basicpay + sudang) as 총급여
from tblInsa;

/*

    3. avg()
    - 해당 컬럼의 평균값을 반환
    - number avg(특정 컬럼명)
    - 숫자형 컬럼에 적용 가능
*/

-- tblInsa, 60명 직원의 평균 급여를 알고싶다
select sum(basicpay) / 60 from tblInsa;
select sum(basicpay) / count(*) from tblInsa;
select avg(basicpay) from tblInsa;

-- tblCountry 전체 인구수에 대한 평균?
select sum(population) / 14 from tblcountry; -- 14475
select sum(population) / count(*) from tblcountry;
select avg(population) from tblcountry; -- 15588 값이 더 늘었다?
select sum(population) / 13 from tblCountry; -- 15588, 케냐가 null 
select sum(population) / count(population) from tblCountry;
-- 케냐를 포함시키고 평균내는 경우도 있고, 케냐를 포함시키지 않고 평균내는 경우도 있다
-- 지금 상황에서는 포함하지 않는게 맞음

-- 회사 -> 성과급 지급을 한다 -> 기업 이익을 낸 출처를 조사해보니 -> 1팀만 이익을 발생시킴
-- 이때 사장님 왈 그래도 우리가 다 같은 직원 아니겠냐, 다 같이 나눠갖자
-- 1. 총 지급액 / 모든 직원수 = sum() / count(*)
-- 사장님이 만약 보너스를 1팀한테만 주겠다
-- 2. 총 지급액 / 1팀 직원수 = sum() / count(1팀) = avg() 이게 avg


/*

    4. max() 최댓값
    object max(특정 칼럼명)
    
    
    5. min() 최솟값
    object min(특정 칼럼명)
    
    - 숫자형, 문자형, 날짜형 모두 적용 가능

*/

select max(basicpay) from tblInsa;
select min(basicpay) from tblInsa;

select max(name) from tblInsa;
select min(name) from tblInsa;
select max(ibsadate), min(ibsadate) from tblInsa;

select
    count(*) as 직원수,
    sum(basicpay) as 총급여합,
    avg(basicpay) as 평균급여,
    max(basicpay) as 최고급여,
    min(basicpay) as 최저급여
from tblInsa;

-- 집계 함수 사용 시 주의할 점!!
-- 요구사항) 직원들의 이름과 전체 직원수를 가져오시오.
-- 칼럼 리스트(SELECT절) 에서는 집계함수와 일반 칼럼을 동시에 사용할 수 없다.
select name, count(*) from tblInsa; -- ORA-00937: 단일 그룹의 그룹 함수가 아닙니다
select name from tblInsa;
select count(*) from tblInsa;

-- 요구사항) 평균 급여보다 더 많이 받는 직원들이 궁금합니다
select avg(basicpay) from tblinsa;
select * from tblinsa where basicpay >= 1556526;
select * from tblinsa where basicpay >= avg(basicpay); -- ORA-00934: 그룹 함수는 허가되지 않습니다
-- where 절에서는 집계 함수를 쓸 수 없다
-- where 절은 개인에 대한 질문 -> 한 사람을 조작하기 위한 용도의 공간,
-- 따라서 여러 사람들의 값으로 판단할 수 밖에 없는 집계 함수가 나오면 where 가 상당히 곤란해짐