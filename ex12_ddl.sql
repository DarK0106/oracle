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
    
        - 기본키(Key == 컬럼) -> 대표 역할
        - 테이블의 행을 구분하기 위한 제약 사항
        - 값이 유일하다(Unique) + 필수값(Not Null)
        - 하나의 테이블에는 PK는 2개 이상 존재 불가능
        - 반드시 테이블에는 PK가 존재해야 한다(PK가 없는 테이블도 존재는 가능하지만 보통 만들지 않는다)
    
    3. FOREIGN KEY
    
    4. UNIQUE
        - 유일하다. 레코드간에 중복값을 가질 수 없다.
        - NULL 을 가질 수 있다. -> 식별자가 될 수 없다.
        ex) 초등학교 학급
            - 학생이라는 테이블을 만들고싶다
            - 어떤 컬럼이 있을까
            - 번호, 이름, 직책(반장, 부반장)
            - 이 학교는 반장은 1명, 부반장도 1명이라는 규칙이 있음
            - 이런 경우 보통 번호를 PK로 한다 <- 번호로 학생들을 구분할 수 있으니
            - 이름 없는 학생같은건 없을테니 이름에 Not Null
            - 반장 부반장이 각각 2명 이상일수는 없으니까 이때 사용하는게 Unique(줄여서 UQ라고함)
            ex) 1. 홍길동, 반장
                2. 아무개, null
                3. 강아지, 부반장
                4. 고양이, 부반장 <- 오류
    
    5. CHECK
        - 사용자 정의형 제약사항(모든걸 개발자가 직접 만들 수 있음)
        - 나머지 제약사항은 얘가 다 처리함
        - 조건을 정의해서 컬럼의 제약 사용으로 적용
        - where절에서 쓰던 표현을 똑같이 사용
    
    6. DEFAULT(제약사항이라고 보는게 맞나 싶은 애매함)
        - 제약을 안함, 기본값을 설정하는 기능
        - insert, update 할 때 컬럼에 값을 안 넣으면 보통 null이 들어가는데
        - null 대신에 미리 값을 설정해놓을 수 있음
        - 설정한 값을 대신 넣어주는 기능
        - 기본값 역할을 함
        - ex. 국적 이라는 컬럼에 기본값을 대한민국이라고 해놓고,
        - 사용자가 대한민국을 쓰지 않으면, 알아서 대한민국이라고 들어감
    
    
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

create table tblMemo
(
    
    seq number(3) primary key,
    name varchar(30) unique, -- Unique <- 한 사람이 메모를 딱 한개만 작성한다는 뜻
    memo varchar2(1000) not null,
    regdate date null

);

insert into tblMemo(seq, name, memo, regdate)
    values (1, '강아지', '멍멍멍', sysdate);
    
insert into tblMemo(seq, name, memo, regdate)
    values (2, '고양이', '멍멍멍', sysdate);
    
insert into tblMemo(seq, name, memo, regdate)
    values (3, '강아지', '왈왈왈.', sysdate); -- 이미 강아지가 있어서 오류
    
insert into tblMemo(seq, name, memo, regdate)
    values (3, '병아리', '왈왈왈.', sysdate);
    
create table tblMemo
(
    
    seq number(3) primary key,      -- 메모번호 (PK)
    name varchar(30) null,          -- 작성자
    memo varchar2(1000) not null,   -- 메모 내용 (N N)
    regdate date null,              -- 날짜
    
    -- 메모의 중요도를 매겨보자(1(중요), 2(보통), 3(안 중요))
    -- priority number(1) check (priority >= 1 and priority <= 3)
    priority number(1) check (priority between 1 and 3),
    
    -- 메모에 카테고리를 만들고 싶다(ex. 할일, 공부, 약속 ..)
    -- category varchar2(10) check (category = '할일' or category = '공부' or category = '약속')
    category varchar2(10) check (category in ( '할일', '공부', '약속'))
    

);

insert into tblMemo(seq, name, memo, regdate, priority, category)
    values (1, '강아지', '멍멍멍', sysdate, 1, '할일');
    
insert into tblMemo(seq, name, memo, regdate, priority, category)
    values (2, '고양이', '야옹', sysdate, 2, '공부');
    
-- ORA-02290: 체크 제약조건(HR.SYS_C008423)이 위배되었습니다
insert into tblMemo(seq, name, memo, regdate, priority, category)
    values (3, '병아리', '삐약', sysdate, 5, '할일');
    
-- ORA-02290: 체크 제약조건(HR.SYS_C008424)이 위배되었습니다
insert into tblMemo(seq, name, memo, regdate, priority, category)
    values (3, '병아리', '삐약', sysdate, 2, '여행');
    
-- 무슨 체크 제약을 어겼는지 어떻게 구분할까?
-- HR.SYS_C008423, HR.SYS_C008424 번호가 다르다?

-- ORA-02290: 체크 제약조건(HR.SYS_C008424)이 위배되었습니다
insert into tblMemo(seq, name, memo, regdate, priority, category)
    values (4, '송아지', '음메', sysdate, 2, '시험');
    
-- ORA-02290: 체크 제약조건(HR.SYS_C008424)이 위배되었습니다
-- 24번이 priority구나
-- 제약사항도 DB가 관리하는 객체 중 하나
-- 이 번호들이 객체의 이름
-- 이 번호들을 사람이 보긴 힘드니까 이름을 고칠 수 있음

create table tblMemo
(
    -- tblmemo_seq_pk <- 제약사항에 이름 붙이기
    seq number(3) constraint tblmemo_seq_pk primary key,      -- 메모번호 (PK)
    name varchar(30) null,          -- 작성자
    -- Not Null 에는 제약사항 이름을 붙이지 못함
    memo varchar2(1000) not null,   -- 메모 내용 (N N)
    regdate date null,              -- 날짜
    
    -- 메모의 중요도를 매겨보자(1(중요), 2(보통), 3(안 중요))
    -- priority number(1) check (priority >= 1 and priority <= 3)
    priority number(1) constraint tblmemo_priority_ck check (priority between 1 and 3),
    
    -- 메모에 카테고리를 만들고 싶다(ex. 할일, 공부, 약속 ..)
    -- category varchar2(10) check (category = '할일' or category = '공부' or category = '약속')
    category varchar2(10) constraint tblmemo_category_ck check (category in ( '할일', '공부', '약속'))
    

);

-- ORA-00001: 무결성 제약 조건(HR.TBLMEMO_SEQ_PK)에 위배됩니다
-- ORA-02290: 체크 제약조건(HR.TBLMEMO_PRIORITY_CK)이 위배되었습니다
-- ORA-02290: 체크 제약조건(HR.TBLMEMO_CATEGORY_CK)이 위배되었습니다
-- 제약사항 이름 바뀐걸 확인할 수 있음

create table tblMemo
(
    
    seq number(3) primary key,
    name varchar(30) default '익명', -- 사용자가 이름을 적지 않는다면 기본값인 익명이 들어간다
    memo varchar2(1000) not null,
    regdate date default sysdate -- 사용자가 날짜를 넣지 않는다면 기본값인 sysdate 함수를 호출해서 알아서 날짜를 넣는다
    -- null 은 보통 적지 않는다 어차피 값 안넣으면 null이라 괜히 헷갈리기만 함

);

insert into tblMemo(seq, name, memo, regdate)
    values (1, '강아지', '멍멍멍', sysdate);

-- 명시적으로 null을 대입
insert into tblMemo(seq, name, memo, regdate)
    values (2, null, '멍멍멍', sysdate); -- 이름에 null을 넣거나
    
-- 암시적으로 null을 대입
insert into tblMemo(seq, memo, regdate)
    values (3, '멍멍멍', sysdate); -- insert문에서 name 컬럼을 빼서 이름을 안 넣을 수 있다
    
insert into tblMemo(seq, memo)
    values (4, '멍멍멍'); -- insert문에서 name이랑 regdate 다 빼서 암시적으로 null을 대입
    -- 4	익명	멍멍멍	26/01/26 <- 기본값 들어간거 확인
    
select *
    from tblmemo;
    
-- 2번은 null이 들어갔고 3번은 default가 동작하여 익명이 들어갔다
-- 명시적으로 null을 대입한 것과, 암시적으로 null을 대입한 것
-- 명시적으로 null을 대입한 경우엔 오라클이 개발자의 의지가 담겨있다고 본다
-- 그래서 사용자가 바란 것 처럼 null을 넣음(기본값을 넣지 않고)
-- 암시적으로 null을 대입한 경우에는 오라클이 별생각없나보다 라고 생각함
-- 그래서 기본값이 들어감


/*
    제약 사항을 만드는 방법
    1. 컬럼 수준에서 만드는 방법
        - 여태까지 수업했던 방식
        - 컬럼을 선언할 때 제약 사항도 같이 선언한 것
        - 컬럼을 만들면서 옆에 제약도 같이 만들었었음
        - 가독성이 높아지긴함 -> 어떤 컬럼에 어떤 제약사항이 들어갔나 바로 확인 가능
        - 실무에서는 잘 사용하진 않는다 가독성이 썩 좋은 편은 아님
    
    2. 테이블 수준에서 만드는 방법
        - 컬럼 선언과 제약사항 선언을 분리시켜서 만드는 방법
        - 따로 하면 뭐가 좋을까? -> 가독성이 높아짐
        - 테이블의 크기가 커질 수록 코드 관리가 용이하다
    
    3. 외부에서 만드는 방법


*/

drop table tblmemo;

create table tblMemo
(
    
    seq number(3),
    name varchar(30),
    memo varchar2(1000) not null, -- not null 은 여기에만 쓸 수 있음
    regdate date,

    constraint tblmemo_seq_pk primary key(seq),
    constraint tblmemo_name_uq unique(name),
    constraint tblmeom_memo_ck check (length(memo) >= 10)
);

select *
    from tblmemo;