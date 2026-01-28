-- ex23_alter.sql

/*
    테이블 수정하기
    테이블 수정 -> 컬럼 수정 -> 컬럼명 or 자료형(길이) or 제약사항 수정

    테이블을 수정해야 하는 상황 발생 !!
    1. 테이블 삭제(drop) -> 테이블 DDL(create) 수정 -> 수정된 DDL로 다시 테이블 생성
        a. 기존 테이블에 데이터가 없는 경우 -> 아무 문제 없음
        b. 기존 테이블에 데이터가 있는 경우 -> 미리 데이터 백업 -> 테이블 삭제
            -> 테이블 DDL(create) 수정 -> 수정된 DDL로 다시 테이블 생성
            -> 백업한 데이터를 다시 복구
    
    2. alter 명령어 사용 -> 기존 테이블의 구조 변경
        a. 기존 테이블에 데이터가 없는 경우 -> 아무 문제 없음
        b. 기존 테이블에 데이터가 있는 경우 -> 상황에 따라 비용 차이 발생





*/

create table tblEdit
(
    seq number,
    name varchar2(20)



);

insert into tblEdit values (1, '마우스');
insert into tblEdit values (2, '키보드');
insert into tblEdit values (3, '모니터');

-- Case1 1. 새로운 컬럼을 추가하기
alter table tblEdit
    add(컬럼 정의);
    
alter table tblEdit
    add (price number);

-- ORA-01758: 테이블은 필수 열(not null 인 컬럼)을 추가하기 위해 비어 있어야 합니다.
-- 키보드 마우스 모니터는 값이 없어서 null임, 근데 not null 컬럼을 만든다함, 값이 없는데 없으면 안된대
-- 오라클 입장에선 뭐어쩌라는거?? -> 에러
-- 새로 추가해야 하는 컬럼이 not null이면 데이터를 다 지워야 함
alter table tblEdit
    add (price number not null);

-- 임시방편으로 0으로 채워넣자
alter table tblEdit
    add (price number default 0 not null);
    
delete from tblEdit;
    
select * from tblEdit;

drop table tblEdit;
    
-- Case 2. 기존 컬럼을 삭제하기
alter table tblEdit
    drop column 컬럼명;
    
-- 데이터도 날아가니 조심해야함. 복구안됨
alter table tblEdit
    drop column price;
    
-- PK 건드리는건 절대 금지 -> 보통 수정도 안하고 삭제도 안함
alter table tblEdit
    drop column seq; -- 실수로라도 절대 하면 안됨!!
    
-- Case 3. 컬럼 수정하기

-- Case 3.1 컬럼 길이 수정하기(확장/축소)

-- ORA-12899: "HR"."TBLEDIT"."NAME" 열에 대한 값이 너무 큼(실제: 29, 최대값: 20)
insert into tblEdit values (4, '삼성 갤럭시 북 6 프로');

alter table tblEdit
    modify(컬럼 정의);

alter table tblEdit
    modify(name varchar(100)); -- 확장
    
-- ORA-01441: 일부 값이 너무 커서 열 길이를 줄일 수 없음
alter table tblEdit
    modify(name varchar(29)); -- 축소

-- 상품명 중 가장 이름이 긴 상품명이 뭘까? -> 컬럼 길이 조절
select max(length(name)) from tblEdit;

select name from tblEdit
    where length(name) = (select max(length(name)) from tblEdit);
    
select length(name), name from tblEdit order by length(name) desc;
    
desc tblEdit;

-- Case 3.2 컬럼의 제약사항 수정하기(not null 에 한함)
alter table tblEdit
    modify (컬럼명 자료형(길이) null); -- not null 이었던게 null로 바뀜

alter table tblEdit
    modify (컬럼명 자료형(길이) not null); -- null 이었던게 not null로 바뀜

-- ORA-02296: (HR.) 사용으로 설정 불가 - 널 값이 발견되었습니다.
-- null 이었던걸 not null 로 바꾸려면 문제가 발생할 확률이 높음
alter table tblEdit
    modify (name varchar2(29) not null);
    
insert into tblEdit values (5, null);

select * from tblEdit;

-- Case 3.3 컬럼의 자료형 바꾸기
alter table tblEdit
    modify (name number);
    
update tblEdit set name = null;

-- Case 3.4 컬럼명 바꾸기
alter table tblEdit
    rename column name to item;
    
-- Case 4. 제약 사항 조작(추가, 삭제)

drop table tblEdit;
    
create table tblEdit
(
    seq number,
    name varchar2(20)

);   

alter table tblEdit
    add constraint tbledit_seq_pk primary key(seq);
    
alter table tblEdit
    add constraint tbledit_seq_uq unique(name);

alter table tblEdit
    drop constraint tbledit_seq_uq;
    

-- DB 처음 설계 + 구축
-- style 1.
create table tblEdit
(
    seq number primary key,
    name varchar2(20) unique

); -- 가장 안 좋은 스타일     

-- Style 2.    
create table tblEdit
(
    seq number primary key,
    name varchar2(20) unique

    constraint tbledit_seq_pk primary key(seq),
    constraint tbledit_seq_uq unique(name)
);       

-- Style 3.
create table tblEdit
(
    seq number primary key,
    name varchar2(20) unique

);

alter table tbledit add constraint tbledit_seq_pk primary key(seq);
alter table tbledit add constraint tbledit_seq_uq unique(name);
-- 가장 권장되는 스타일    
    
    
    
    
    
    
    
    
    