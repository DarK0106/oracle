-- *.sql -> (SQL)스크립트 파일

-- 한줄 주석
/*
    여러 줄 주석
*/

-- Ctrl + / : 한 줄 주석

/*
    관계형 데이터베이스
    - 변수 없음, 제어문 없음 -> SQL은 프로그래밍 언어가 아니다
    - 데이터베이스와 대화를 목적으로 하는 언어 -> 대화형 언어
    - SQL에서 사용하는 자료형 -> 테이블을 선언할 때 컬럼에 적용하는 용도로 자주 사용
    
    1. 숫자형
        - 정수 / 실수
    a. number
        - (유효자리)38자리까지 표현
        - 1~22byte
        - 1*10^-130 ~ 9.9999*10^125
        - number: 정수 or 실수를 마음대로 넣을 수 있는 자료형
        - number(precision): 전체 자릿수
        - ex) number(3) <- 3자리수까지만 들어감, 이거 하는 순간 정수형만 가능, 실수 넣으면 정수만 들어감
        - number(precision, scale): 소수 이하 자릿수 -> 정수형도 들어가고 실수형도 들어감
    
    2. 문자형
    
    
    
    3. 날짜/시간형
    
    
    
    4. 이진 데이터형
    
    
    
*/


/*

    DDL
    
    create table 테이블명 (
    
        컬럼 선언,
        컬럼 선언,
        컬럼 선언
        컬럼 선언 -> 컬럼명 자료형
    );

*/

-- 수업할 때 식별자 패턴 -> DB Object라고 불리는 패턴은 헝가리언 표기법
create table tblType 
(

    --num number -- num: 컬럼 이름 / number: 컬럼에 넣을 수 있는 자료형
    -- 실행하는법? 블럭 잡고 Ctrl + Enter
    -- 내가 실행하고 싶은걸 골라서 실행하는 방식
    -- 순서대로 실행하는 그런게 아님
    -- 어차피 남남
    -- num number(3) -- 3의 의미: 3자리, -999 ~ 999
    num number(4,2) -- 4자리 + 소수 이하 2자리까지 받음, 4자리가 정수 2자리 소수이하 2자리 해서 4자리 라는 말
    -- -99.99 ~ 99.99

);

drop table tblType; -- Shift + Home / Shift + End

select * from tabs; -- tabs = tables, 내가 가지고 있는 테이블 목록

-- 데이터 추가하기
-- insert into 테이블명(컬럼명) values (값);
-- insert into 테이블명(컬럼명A, 컬럼명B) values (값A, 값B);

insert into tblType (num) values (100); -- 100 -> 정수형 리터럴
insert into tblType (num) values (3.14); -- 3.14 -> 실수형 리터럴
insert into tblType (num) values (3.54); -- 3.54 넣으면 반올림 해서 4 들어감(number(3)으로 했을 때)
insert into tblType (num) values (12345678901234567890123456789012345678);
insert into tblType (num) values (-999);
insert into tblType (num) values (999);
insert into tblType (num) values (999.99); -- 반올림을 원칙으로 하기 때문에 에러 발생
insert into tblType (num) values (999.39); -- 반올림 하면 짤리기 때문에 얘는 또 들어감
insert into tblType (num) values (-99.99);
insert into tblType (num) values (99.99);
insert into tblType (num) values (99.9099);
select * from tblType; -- 테이블의 모든 데이터를 가져와라