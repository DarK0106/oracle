--ex22_union.sql

/*
    DB 이론
    - 관계 대수 -> 연산(자)
    - 테이블을 피연산자로 하는 계산
    - 테이블 + 테이블 -> union
    - 테이블 - 테이블 -> minus
    - 테이블 * 테이블 -> join

    테이블
    - 합집합(union)
    - 차집합(minus)
    - 교집합(intersect)
    
    가로로 붙이는게 join 세로로 붙이는게 union
*/

select * from tblMen;
select * from tblWomen;

select * from tblMen m 
    inner join tblWomen w 
        on m.name = w.couple; -- 커플

select * from tblMen; -- A 라고 생각
select * from tblWomen; -- B 라고 생각

/*
A
+ (유니온)
B
*/

select * from tblMen
union
select * from tblWomen;

-- ORA-01789: 질의 블록은 부정확한 수의 결과 열을 가지고 있습니다.
-- 이런건 유니온을 못함
/*
ㅁㅁㅁㅁ
ㅁㅁㅁㅁ
ㅁㅁㅁㅁ
ㅁㅁ
ㅁㅁ
유니온하면 약간 이런 느낌
*/
select * from tblInsa
union
select * from tblTodo;

-- 그럼 유니온 못해? -> 할 수 있음
-- 왜 구문이 select union select 일까?
select name, ibsadate from tblInsa
union
select title, adddate from tblTodo;
-- 합쳐지긴하는데 딱히 쓸모가 없음
-- 구조만 똑같으면 유니온은 됨

-- 그럼 유니온은 언제 쓸까?
-- 쇼핑몰이 있다 -> 구매 이력
-- 보통 전체 기간 보여주는게 아니고 3개월, 6개월 이렇게 보여줌
-- 년도별로도 나뉘어져 있음

-- select * from 구매 2026; -- 10만건
-- select * from 구매 2025; -- 1백만건
-- select * from 구매 2024; -- 1백만건

-- 회사에서 게시판을 만드는데 부서별 전용 게시판을 만들기로 했음
select * from 영업부게시판;
select * from 총무부게시판;
select * from 개발부게시판;

-- 사장님이 요즘 무슨 글이 올라오나 물어봄 
-- -> 모든 게시판을 한번에 볼 순 없음?
select * from 영업부게시판
union
select * from 총무부게시판
union
select * from 개발부게시판;

-- 야구 선수 트레이딩 하는 사이트?
select * from 공격수;
select * from 수비수;

select 공통된컬럼 from 공격수
union
select 공통된컬럼 from 수비수;

-- 동물 -> 애완 동물
create table tblAAA
(
    name varchar2(30) not null,
    color varchar2(30) not null


);

-- 동물 -> 야생 동물
create table tblBBB
(
    name varchar2(30) not null,
    color varchar2(30) not null


);

insert into tblAAA values ('강아지', '검정');
insert into tblAAA values ('고양이', '노랑');
insert into tblAAA values ('토끼', '갈색');
insert into tblAAA values ('거북이', '녹색');
insert into tblAAA values ('강아지', '회색');

insert into tblBBB values('강아지', '검정');
insert into tblBBB values('고양이', '노랑');
insert into tblBBB values('호랑이', '주황');
insert into tblBBB values('사자', '회색');
insert into tblBBB values('고양이', '삼색');

-- union -> 수학에서의 합집합 -> 중복 제거
-- 검정 강아지랑 노랑 고양이 없어져서 5개 5개 합쳤지만 8개가 나옴
select * from tblAAA
union
select * from tblBBB;

rollback;

-- union all -> 중복 허용
select * from tblAAA
union all
select * from tblBBB;

-- 차집합(minus)
select * from tblAAA
minus
select * from tblBBB;

-- B에서 A를 빼면?`
select * from tblBBB
minus
select * from tblAAA;

-- 교집합
select * from tblAAA
intersect
select * from tblBBB;