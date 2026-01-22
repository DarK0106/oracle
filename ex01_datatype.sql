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
    
    2. 문자형 -> varchar2 매우 중요
        - 문자 + 문자열
        - char vs nchar -> n의 의미?
        - char vs varchar -> var의 의미?
        
        a. char
        
        - 고정 자릿수 문자열 -> 공간(컬럼)의 크기가 불변
        - char(n): 최대 n자리 문자열 (ex. char(10)), n은 바이트
            - 최소 크기: 1바이트
            - 최대 크기: 2000바이트
        
        
        b. nchar
            - n : national -> 오라클 인코딩(UTF-8)과 상관없이 해당 컬럼을 UTF-16으로 동작
            - nchar(n): 최대 n자리 문자열, n 은 문자수를 뜻함
                - 최소 크기: 1문자
                - 최대 크기: 1000문자
        
        
        c. varchar2(다른 데이터베이스에서는 varchar)
            - 가변 자릿수 문자열 -> 공간(컬럼)의 크기가 줄어드는게 가능
            - varchar2(n): 최대 n자리 문자열, n 은 바이트를 말함
                - 최소 크기: 1바이트
                - 최대 크기: 4000바이트
            - 데이터 삽입 후 -> 남은 공간을 버린다.(trim)
            - 가변 문자열 -> 주소, 자기 소개
        
        d. nvarchar2(다른 데이터베이스에서는 nvarchar)
            - n : national -> 오라클 인코딩(UTF-8)과 상관없이 해당 컬럼을 UTF-16으로 동작
            - varchar2(n): 최대 n자리 문자열,n(문자수)
                - 최소 크기: 1문자
                - 최대 크기: 2000문자
                
        e. clob, nclob
            - 대용량 텍스트
            - 속도가 느림, 자바로 치면 참조형, 한 다리 건너서 액세스함
            
    3. 날짜  시간형
        a. date
            - 년월일시분초
        
        
        b. timestamp
            - 년월일시분초 + 밀리초 + 나노초
            - 타임존
        
        
        c. interval
            - 시간
            - 틱값
    
    
    
    
    
    4. 이진 데이터형
        - 비 텍스트 데이터
        - 이미지, 영상, 음악, 실행 파일, 압축 파일 등
        - 잘 사용 안함
        ex) 게시판(첨부파일) -> DB에는 첨부 파일의 이름을 저장(문자열)
        a. blob
        
    결론
    1. 숫자 -> number
    2. 문자열 -> varchar2
    3. 날짜 -> date
    얘네만 집중적으로 공부하자
    
    
    
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
    -- num number(4,2) -- 4자리 + 소수 이하 2자리까지 받음, 4자리가 정수 2자리 소수이하 2자리 해서 4자리 라는 말
    -- -99.99 ~ 99.99
    -- txt char(10)
    -- txt varchar2(10)
    -- txt1 char(10),
    -- txt2 varchar2(10)
    -- txt nchar(10)
    
    regdate date

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

insert into tblType (txt) values ('ABC'); -- 문자열 리터럴 -> 10바이트 == 몇글자? -> 인코딩(UTF-8) -> 영어 1바이트, 한글 3바이트
insert into tblType (txt) values ('ABCEFGHIJ');
insert into tblType (txt) values ('홍길동');
insert into tblType (txt) values ('홍길동A');
insert into tblType (txt) values ('홍길동님'); -- 12바이트라서 안들어감
insert into tblType (txt) values ('홍길동님안녕하세요.');

insert into tblType (txt1, txt2) values ('ABCDE', 'ABCDE');

insert into tblType (regdate) values ('2026-01-22'); -- 날짜 리터럴

select * from tblType; -- 테이블의 모든 데이터를 가져와라