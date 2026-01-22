-- ex04_where.sql

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
    
    각 절의 순서(매우중요)
    3. SELECT <- 거의 대부분 SELECT가 꼴등
    1. FROM
    2. WHERE

*/

SELECT
    * -- 세번째
FROM
    tblcountry -- 첫번째
WHERE
    continent = 'AS'; -- 두번째, where는 행에 대한 조건, 데이터베이스에서는 행이라고 안 하고 레코드(Record)라고 함
        -- 튜플(Tuple) 이라고도 함
        
select *
    from tblcountry
        where area >= 100;
        
select *
    from tblcountry
        where continent = 'AS';
        
-- tblComedian
-- 1. 몸무게(weight)가 60kg 이상이고, 키(height)가 170cm 미만인 사람

-- 2. 몸무게가 70kg 이하인 여자만

-- tblInsa
-- 3. 부서가 '개발부'이고, 급여가 150만원 이상 받은 직원

-- 4. 급여 + 수당을 합한 금액이 200만원이 넘는 직원


select *    
    from tblcomedian
        where weight >= 60 and height < 170;
        
select *
    from tblcomedian
        where weight <= 70 and gender = 'f';
        
select *
    from tblInsa
        where buseo = '개발부' and basicpay >= 1500000;
        
select *
    from tblInsa
        where basicpay + sudang >= 2000000;
        
        
/*

    Optimizer -> SQL 실행하기 전에 결과를 얻기 위해 최적의 SQL로 수정
    
    between
    - where 절에서 사용 -> 조건으로 사용
    - 컬럼명 between 최솟값 and 최댓값
    - 범위 비교
    - 가독성이 좋아 사용
    - 최솟값, 최댓값 모두 포함

*/

select * 
    from tblInsa
        where basicpay >= 1000000 and basicpay <= 1200000;
        
select * 
    from tblInsa
        where 1000000 <= basicpay and basicpay <= 1200000;
        
select * 
    from tblInsa
        where basicpay between 1000000 and 1200000; -- between 활용
        
/*

    SQL에서의 비교 연산
    1. 숫자형
    2. 문자형
    3. 날짜시간형

*/

select * 
    from tblInsa
        where basicpay between 1000000 and 1200000; -- between 활용
        
select *
    from employees
        where first_name <= 'F';
        
select *
    from employees
        where first_name >= 'J' and first_name <= 'L';
        
select *
    from employees
        where first_name between 'J' and 'L';
        
desc tblInsa;
select *
    from tblInsa
        where ibsadate < '2010-01-01';
        
select *
    from tblInsa
        where ibsadate >= '2010-01-01' and ibsadate <= '2010-12-31';
        
select *
    from tblInsa
        where ibsadate between '2010-01-01' and '2010-12-31';
        
/*

    in 연산자
    - where 절에서 많이 사용 -> 조건으로 많이 사용
    - 열거형 비교
    - 컬럼명 in (값, 값, 값 ...)
    - 가독성이 좋아 사용

*/

-- tblInsa. 개발부
select * from tblInsa where buseo = '개발부';

-- 개발부 + 홍보부 + 총무부
select * from tblInsa where buseo = '개발부' or buseo = '홍보부' or buseo = '총무부';

select * from tblInsa where buseo in ('개발부', '홍보부', '총무부'); -- in 사용

-- city -> 서울 + 인천
-- 직위 -> 과장 + 부장
-- basicpay -> 250~300만원

select * from tblInsa
    where city in ('서울', '인천')
        and jikwi in ('과장', '부장')
            and basicpay between 2500000 and 3000000;
            
            
/*

    like
    - where 절에서 사용 -> 조건으로 사용
    - 패턴 비교(정규 표현식과 비슷)
    - 컬럼명 like '패턴 문자열'
    
    패턴 문자열 구성 요소
    1. _: 임의의 문자 1개(자바로 치면 .)
    2. %: 임의의 문자 N개. N: 0~무한대(자바로 치면 .*)

*/

-- 직원명: 김OO

select * from tblInsa;
select * from tblInsa where name like '김__';
select * from tblInsa where name like '_길_';
select * from tblInsa where name like '__수';
select * from tblInsa where name like '엄__';
select * from tblInsa where name like '_준_';
select * from tblInsa where name like '__식';

select * from employees where first_name like 'S_____'; -- S 대소문자 구분 조심
-- 데이터는 대소문자 가림

select * from tblInsa where name like '엄%';
select * from tblInsa where name like '김정%';
select * from tblInsa where name like '%식';
select * from tblInsa where name like '%길%';

select * from employees where name like 'S%';

select * from tblInsa where ssn like '______-1______'; -- 주민등록번호로 남자 찾기
select * from tblInsa where ssn like '%-2%'; -- 주민등록번호 뒷자리 2로 시작하면 여자


/*

    RDBMS 에서의 null
    - 컬럼값이 비어있는 상태
    - null 상수 제공
    - SQL을 포함한 대부분의 언어는 null 은 연산의 대상이 될 수 없다(피연산자가 될 수 없다)
    
    is null 이라는 연산자를 사용해보자
    - null 을 전문적으로 처리하기 위한 연산자
    - where 절에서 사용
    - 컬럼명 is null
    not null 이라는 상수가 또 있음
    
*/

select * from tblcountry;

-- 인구수가 기재되어있지 않은 나라를 찾아라
select * 
    from tblcountry
        -- 해결) = 를 is null로 바꿔라
        where population is null; -- 피연산자가 null이라 조건절에서 null 이면 false를 반환
        
-- 인구수가 기재되어있는 나라를 찾아라
select *
    from tblcountry
        where not population is null;
        
select *
    from tblcountry
        where not population is not null;
        
-- tblInsa 연락처(tel)가 없는 직원?
select *
    from tblInsa
        where tel is null;
        
select *
    from tblInsa
        where tel is not null;
        
-- tblTodo / 할 일을 완료한 일들이 뭐가 있는지?
select *
    from tblTodo
        where completedate is not null; -- 완료한 일들
        
select *
    from tblTodo
        where completedate is null; -- 아직 안했음
        
-- 도서관 -> 대여 테이블(컬럼: 대여 날짜, 반납 날짜)

-- 아직까지 반납을 안한 사람?
select *
    from 대여
        where 반납날짜 is null;
        
-- 반납을 완료한 사람?
select *
    from 대여
        where 반납날짜 is not null; -- 예시, 실행 X