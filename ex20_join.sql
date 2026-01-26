-- ex20_join.sql

/*

    관계형 데이터베이스 시스템이 지양하는 것들 !!
    
    1. 테이블에 기본 키(PK) 가 없는 상태
    2. null 이 많은 상태의 테이블 -> 공간 낭비 + SQL
    3. 하나의 속성값이 원자값이 아닌 상태 -> 더 이상 쪼개지지 않는 값(원자값)을 넣어야 한다.


*/

create table tblNote
(

    name varchar2(30) not null,                     -- 작성자
    content varchar2(1000) not null,                -- 내용
    regdate date default sysdate not null           -- 작성시각


);

insert into tblNote values('홍길동', '자바 정리', default);
insert into tblNote values('아무개', '오라클 정리', default);
insert into tblNote values('강아지', '네트워크 정리', default);

select * from tblNote;

update tblNote set content = '자바 수업 정리' where regdate =''; -- regdate는 조건이 되면 절대 안된다
-- 왜냐하면 시분초까지 다 넣어야 하기 때문, 하필이면 똑같은 시간에 작성된 글이 있으면 구별이 안됨

update tblNote set content = '자바 수업 정리' where content = '자바 정리'; -- 가능은 한데 다른 애가 우연히 이렇게 써버리면
-- 또 구분이 안됨

update tblNote set content = '자바 수업 정리' where name = '홍길동'; -- 길동이가 글을 하나 더 쓰면 그 글도 바꿔버림, 문제 해결 안됨

update tblNote set content = '자바 수업 정리' where content = '자바 정리' and name = '홍길동';

drop table tblUser;

create table tblUser
(
    id varchar2(30) primary key,
    name varchar2(30) not null,
    hobby1 varchar2(50),
    hobby2 varchar2(50),
    hobby3 varchar2(50)



);

-- 회원이 10000명이 가입함
-- 딱 1명이 취미가 100개
-- 나머지 9999명이 취미가 0~2개
-- 오직 1명만을 위해서 hobby 컬럼을 100개를 만들어야함

select * from tblUSer;

insert into tblUser values('hong', '홍길동', '독서', null, null);
insert into tblUser values('dog', '강아지', null, null, null);
insert into tblUSer values('cat', '고양이', '운동','독서','코딩');
insert into tblUser values('test', '테스트', '런닝', '메뉴얼독서', null);

select * from tblUSer where hobby = '독서';
select * from tblUSer where hobby like '%독서%'; -- 원하지 않았던 test의 메뉴얼독서도 찾아짐

update tblUser set hobby = '책읽기' where hobby = '독서';
