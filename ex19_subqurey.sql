-- ex19_subqurey.sql

/*

    SQL
    1. Main Query, 보통 쿼리라고 읽음
        - 하나의 문장 안에 하나의 select(insert, update, delete)문으로 되어 있는 쿼리
    
    
    2. Sub Query, 반드시 서브쿼리라고 읽음
        - 하나의 문장 안에 또 다른 문장이 들어있는 쿼리
        - 메인 쿼리의 일부분으로 쿼리 하나가 삽입되는데 그게 서브쿼리
        - 메인 쿼리가 select 일떄 또다른 select를 넣을 수 있음
        - 바깥쪽에 insert, update, delete가 있는데 그 안에 select를 넣을 수 있음





*/

-- tblCountry. 인구수가 가장 많은 나라의 이름?
select max(population) from tblcountry;
select name from tblCountry where population = 120660; -- 안 좋은 방법, 숫자 맨날 고쳐야함

select name from tblCountry where population = (select max(population) from tblcountry);
-- select max(population) from tblcountry 얘가 120660이라는 숫자를 뽑아낸거니까 이거 통째로 박아버리면 문제 해결
-- 이게 서브쿼리

-- tblComedian에서 몸무게가 가장 많이 나가는 사람의 정보?
-- 129kg가 최대 몸무게다
select max(weight) from tblcomedian;
select * from tblComedian where weight = 129;

select * from tblcomedian where weight = (select max(weight) from tblcomedian);

-- tblInsa 평균 급여보다 더 많이 받는 직원들?
select * from tblInsa
    where basicpay >= (select avg(basicpay) from tblInsa);
    
/*
    서브 쿼리가 삽입되는 위치가 여러군데이다
    1. 조건절 -> 어떤 애와 비교하기 위한 값으로 쓰일 때?
        a. 반환값이 1행 1열 -> 단일값 반환 -> 상수 취급 = 값 1개
        b. 반환값이 n행 1열 -> 다중값 반환 -> 열거형 비교 -> in 연산자
        c. 반환값이 1행 n열 -> 다중값 반환 -> 그룹 비교 -> N:N 비교
        d. 반환값이 n행 n열 -> 다중값 반환 -> b + c -> in 연산자 + N:N 비교




*/

select * from tblWomen
    where couple = (select name from tblMen where age = 31 and height = 183);
    
    
-- ORA-01427: 단일 행 하위 질의에 2개 이상의 행이 리턴되었습니다.
select * from tblWomen
    where couple = (select name from tblMen where age = 22);
    
select * from tblWomen
    where couple in (select name from tblMen where age = 22);
    
-- tblInsa. '홍길동'과 같은 지역
select * from tblInsa
    where city = (select city from tblInsa where name = '홍길동');

-- tblInsa. '홍길동'과 같은 지역 + 홍길동과 같은 부서
select * from tblInsa
    where city = (select city from tblInsa where name = '홍길동')
        and buseo = (select buseo from tblInsa where name = '홍길동');
        
select * from tblInsa
    where (city, buseo) = (select city, buseo from tblInsa where name = '홍길동');
    
-- 급여가 260만원 이상 받은 직원과 같은 부서 + 같은 지역인 직원들을 다 찾아라
select * from tblInsa
    where (city, buseo) in (select city, buseo from tblInsa where basicpay >= 2600000);
    
    
/*
    서브 쿼리가 삽입되는 위치가 여러군데이다
    1. 조건절 -> 어떤 애와 비교하기 위한 값으로 쓰일 때?
    2. 컬럼 리스트에도 삽입 -> 서브 쿼리가 컬럼의 값으로 사용된다
        - 반드시 결과값이 1행 1열이어야 한다. -> 스칼라 쿼리(원자값 반환)
        a. 정적 서브 쿼리 -> 모든 행에 동일한 값을 반환, 사실 거의 안 쓴다
        b. 상관 서브 쿼리 -> 메인 쿼리의 일부 값을 활용해 서브쿼리에 사용
                          -> 메인 쿼리와 연관된 값을 반환





*/

select
    name, buseo, basicpay,
    (select round(avg(basicpay)) from tblInsa)
from tblInsa;

select
    name, buseo, basicpay,
    (select jikwi, city from tblInsa where num = 1001)
from tblInsa;

-- 상관 서브 쿼리
select
    name, buseo, basicpay,
    (select round(avg(basicpay)) from tblInsa where buseo = a.buseo)
from tblInsa a;

/*
    서브 쿼리가 삽입되는 위치가 여러군데이다
    1. 조건절 -> 어떤 애와 비교하기 위한 값으로 쓰일 때?
    2. 컬럼 리스트에도 삽입 -> 서브 쿼리가 컬럼의 값으로 사용된다
    3. FROM절
        - 서브쿼리의 결과셋을 또 하나의 테이블이라고 생각하고 메인 쿼리가 실행
        - 익명 테이블 역할 또는 임시 테이블 역
        - 인라인 뷰(Inline View)

*/

select * from (select num, name, jikwi from tblInsa where buseo = '기획부');