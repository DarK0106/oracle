--ex14_insert.sql

/*

    DML -> select, insert, update, delete
    
    insert 문
    - 테이블에 데이터를 추가하는 명령어
    
    insert into 테이블명 (컬럼 리스트) values (값 리스트);


*/

drop table tblMemo;

select * from tblMemo;

create table tblMemo
(
    
    seq number(3) primary key,
    name varchar(30) default '익명',
    memo varchar2(1000),
    regdate date default sysdate not null

);

create sequence seqMemo;

-- 1. 표준
-- 원본 테이블에 정의된 컬럼 순서대로 컬럼 리스트와 값 리스트를 작성
insert into tblMemo (seq, name, memo, regdate)
    values (seqMemo.nextVal, '홍길동', '메모입니다.', sysdate);


-- 2. 컬럼 리스트의 순서는 원본 테이블과 무관하다
-- -  컬럼 리스트의 순서와 값 리스트의 순서는 일치해야 한다.(*중요)
insert into tblMemo (regdate, seq, name, memo)
    values (sysdate, seqMemo.nextVal, '홍길동', '메모입니다.');
    
-- 3. SQL 오류: ORA-00913: 값의 수가 너무 많습니다
insert into tblMemo (seq, name, regdate)
    values (seqMemo.nextVal, '홍길동', '메모입니다.', sysdate);
    
-- 4. SQL 오류: ORA-00947: 값의 수가 충분하지 않습니다
insert into tblMemo (seq, name, memo, regdate)
    values (seqMemo.nextVal, '메모입니다.', sysdate);

-- 5. null 컬럼 조작(memo) -> null 을 넣겠다 !! 할 때 하는 방법(명시적으로 넣기)
insert into tblMemo (seq, name, memo, regdate)
    values (seqMemo.nextVal, '홍길동', null, sysdate);
    
select * from tblMemo;

-- 5. null 컬럼 조작(name) -> null 을 넣겠다 !! 할 때 하는 방법(암시적으로 넣기)
insert into tblMemo (seq, name, regdate)
    values (seqMemo.nextVal, '홍길동', sysdate); -- 컬럼 리스트랑 값 리스트 둘 다 memo랑 메모 내용을 다 빼버림

-- 6. deafault 조작 -> 기본값을 넣는 방법
-- 6-1. 컬럼 생략 -> 암시적으로 null 대입 -> default 호출
insert into tblMemo (seq, memo, regdate)
    values (seqMemo.nextVal, '메모입니다.', sysdate); -- 익명 넣어진거 확인
    
-- 6-2. null 상수를 호출
-- default가 호출이 되지 않고 진짜 null 이 들어감
-- 그럼 암시적으로만 null 을 넣어야 default가 호출되나?
-- 또 다른 방법이 있음
insert into tblMemo (seq, name, memo, regdate)
    values (seqMemo.nextVal, null, '메모입니다.', sysdate);

-- 6-3. default 상수를 활용하자
insert into tblMemo (seq, name, memo, regdate)
    values (seqMemo.nextVal, default, '메모입니다.', sysdate);
    
-- 7. 단축 표현, 컬럼 리스트를 없애버린다?
-- 잘들어감
-- 그럼 생략하는게 좋네? -> 그건아님
insert into tblMemo
    values (seqMemo.nextVal, '홍길동', '메모입니다.', sysdate);

-- 7-1. 컬럼 리스트를 생략했을 때에는 컬럼 리스트의 순서를 바꿀 수 없다
-- SQL 오류: ORA-00932: 일관성 없는 데이터 유형: NUMBER이(가) 필요하지만 DATE임
insert into tblMemo
    values (sysdate, seqMemo.nextVal, '홍길동', '메모입니다.');

-- 7-2. null 컬럼 생략 불가능
-- SQL 오류: ORA-00947: 값의 수가 충분하지 않습니다
insert into tblMemo
    values (seqMemo.nextVal, '메모입니다.', sysdate);
    
-- 7-3 default 컬럼 생략 불가능, default 명시적 호출은 가능
insert into tblMemo
    values (seqMemo.nextVal, default, '메모입니다.', sysdate);
    
-- 8.
-- tblMemo 테이블의 복사본을 만들어주세요(tblMemoCopy)
create table tblMemoCopy
(
    
    seq number(3) primary key,
    name varchar(30) default '익명',
    memo varchar2(1000),
    regdate date default sysdate not null

);

insert into tblMemoCopy select * from tblMemo; -- Sub Query
insert into tblMemoCopy select * from tblMemo where name = '홍길동'; -- 가공도 가능

select * from tblMemoCopy;

-- 9.
-- tblMemo 테이블의 복사본을 만들어주세요(tblMemoCopy)
-- 데이터와 컬럼도 복사는 해주는데 제약사항을 복사를 안함
-- 이렇게 만든 테이블은 바로 써먹질 못함
-- 그럼 뭐할때씀? 더미 데이터 만들때 -> 임시, 테스트용
drop table tblMemoCopy;

create table tblMemoCopy as select * from tblMemo;

select * from tblMemo;
select * from tblMemoCopy;

-- ORA-00955: 기존의 객체가 이름을 사용하고 있습니다.
insert into tblMemoCopy values (5, default, '메모입니다.', sysdate);