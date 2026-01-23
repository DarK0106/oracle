--ex12_ddl.sql

/*

    수업 진도
    1. 초반 DML(ex01~ex11)
    2. DDL -> 테이블 구조를 어떻게 만드는가에 대해
    3. 후반 DML
    ---------------- ANSI-SQL
    4. 데이터 설계(모델링)
    5. 간단한 프로젝트 1일
    ----------------
    6. PL/SQL
    ---------------- PL/SQL
    7. DB 프로젝트 1주일
    
    1. DDL
    - Data Definition Language
    - 데이터 정의어
    - DB의 구조를 생성/관리하는 명령어
    - 데이터베이스 객체 중에 가장 중요한게 테이블 뷰 사용자 인덱스 등
    - 이걸 생성하고 수정하고 삭제하는 명령어들을 DDL이라고 한다
    a. create: 생성
    b. drop: 삭제
    c: alter: 수정
    
    테이블 생성하기 -> 테이블을 만들려면 어떤 구조의 테이블을 만들지부터 생각해봐야함
    테이블 구조(스키마, Schema) -> 컬럼 정의하기
        -> 컬럼의 이름을 정하고 자료형을 정하고 길이를 정하는것, 제약사항을 정의한다(*중요)
        
    create table 테이블명 (
        컬럼 선언,
        컬럼 자료형(길이) NULL 제약사항
        
    제약사항, Constraint
    - 데이터베이스의 무결성을 보장하기 위한 장치
    - 저장된 데이터는 반드시 올바른 데이터여야 한다
    - 해당 칼럼에 들어갈 데이터에 대한 조건
        1. 조건을 만족하면 저장
        2. 조건을 만족하지 못하면 에러
        
    1. NOT NULL
        - NOT NULL 이 정의된 컬럼은 반드시 값을 가져야 한다
        - 해당 컬럼에 값이 없으면 NOT NULL 제약사항을 위반했기 때문에 에러 발생
        - 필수값(required)
    
    
    2. PRIMARY KEY
    
    3. FOREIGN KEY
    
    4. UNIQUE
    
    5. CHECK
    
    6. DEFAULT
    
    );


*/

-- 메모 테이블
create table tblMemo
(
    -- 컬럼명 자료형(길이) NULL 제약사항
    seq number(3) not null, -- null이라고 적혀있으면 이 컬럼은 값을 안 넣어도 됩니다(쓰기 싫으면 쓰지 마)
    -- 선택 가능한 값, 즉 Optional 이라고 부름
    name varchar(30) null,
    memo varchar2(1000) not null,
    regdate date null
    
    --메모번호(NN)
    --작성자
    --메모내용(NN)
    --날짜
    -- NN == Not Null 해당 컬럼은 값을 반드시 가져야 합니다.

);

select * from tblMemo;

insert into tblMemo(seq, name, memo, regdate)
    values (1, '홍길동', '메모입니다','2026-01-23');
    
insert into tblMemo(seq, name, memo, regdate)
    values (2, '아무개', '테스트입니다',to_date('2026-01-23 17:07:54', 'yyyy-mm-dd hh24:mi:ss'));
    
insert into tblMemo(seq, name, memo, regdate)
    values (3, '강아지', '멍멍멍', sysdate);
    
insert into tblMemo(seq, name, memo, regdate)
    values (4, '고양이', '메모입니다.', null);
    
insert into tblMemo(seq, name, memo, regdate)
    values (5, '병아리', null, null);
    
insert into tblMemo(seq, name, memo, regdate)
    values (6, null, null, null);
    
insert into tblMemo(seq, name, memo, regdate)
values (null, null, null, null);

drop table tblMemo;

insert into tblMemo(seq, name, memo, regdate)
    values (1, '강아지', '멍멍멍', sysdate);
    
-- SQL 오류: ORA-01400: NULL을 ("HR"."TBLMEMO"."MEMO") 안에 삽입할 수 없습니다    
insert into tblMemo(seq, name, memo, regdate)
    values (2, '고양이', null, sysdate);
    
insert into tblMemo(seq, name, memo, regdate)
    values (2, '고양이', '', sysdate); -- 빈문자열도 null 로 취급한다.
    
    
    
-- 메모 테이블
create table tblMemo
(
    -- 컬럼명 자료형(길이) NULL 제약사항
    seq number(3) primary key, -- primary key 라는 제약 사항이 적용됨
    -- null이라고 적혀있으면 이 컬럼은 값을 안 넣어도 됩니다(쓰기 싫으면 쓰지 마)
    -- 선택 가능한 값, 즉 Optional 이라고 부름
    name varchar(30) null,
    memo varchar2(1000) not null,
    regdate date null
    
    --메모번호(NN)
    --작성자
    --메모내용(NN)
    --날짜
    -- NN == Not Null 해당 컬럼은 값을 반드시 가져야 합니다.

);

insert into tblMemo(seq, name, memo, regdate)
    values (1, '강아지', '멍멍멍', sysdate);
    
-- SQL 오류: ORA-01400: NULL을 ("HR"."TBLMEMO"."MEMO") 안에 삽입할 수 없습니다    
insert into tblMemo(seq, name, memo, regdate)
    values (2, '고양이', '멍멍멍', sysdate);
    
insert into tblMemo(seq, name, memo, regdate)
    values (3, '강아지', '왈왈왈.', sysdate);
    
-- ORA-00001: 무결성 제약 조건(HR.SYS_C008418)에 위배됩니다 <- primary key 위반
insert into tblMemo(seq, name, memo, regdate)
    values (3, '홍길동', '메모 테스트입니다.', sysdate);

-- SQL 오류: ORA-01400: NULL을 ("HR"."TBLMEMO"."MEMO") 안에 삽입할 수 없습니다
insert into tblMemo(seq, name, memo, regdate)
    values (3, '홍길동', null, sysdate);
    
select * from tblMemo;