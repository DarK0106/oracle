-- ex20_join.sql

/*

    관계형 데이터베이스 시스템이 지양하는 것들 !!
    
    1. 테이블에 기본 키(PK) 가 없는 상태
    2. null 이 많은 상태의 테이블 -> 공간 낭비 + SQL
    3. 하나의 속성값이 원자값이 아닌 상태 -> 더 이상 쪼개지지 않는 값(원자값)을 넣어야 한다.
    4. 데이터가 중복되는 상태 -> 데이터 관리 불편(일관성 저하)


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

-- 쇼핑몰 > 판매 테이블
create table tblShop (
    seq number primary key,             --판매번호(PK)
    id varchar2(30) not null,           --고객 아이디
    name varchar2(30) not null,         --고객명
    tel varchar2(15) not null,          --연락처
    item varchar2(50) not null,         --상품명
    qty number not null,                --수량
    regdate date default sysdate not null
);

insert into tblShop 
    values (1, 'hong', '홍길동', '010-1234-5678', '마우스', 1, default);

insert into tblShop 
    values (2, 'test', '테스트', '010-5555-6666', '키보드', 1, default);
    
insert into tblShop 
    values (3, 'hong', '홍길동', '010-1234-5678', '태블릿', 1, default);    


-- 직원 정보
-- 직원(번호(PK), 직원명, 급여, 거주지, 담당프로젝트)
create table tblStaff (
    seq number primary key,         --직원번호(PK)
    name varchar2(30) not null,     --직원명
    salary number not null,         --급여
    address varchar2(300) not null, --거주지
    project varchar2(300)           --담당프로젝트
);

insert into tblStaff values (1, '홍길동', 300, '서울시', '홍콩 수출');
insert into tblStaff values (2, '아무개', 250, '인천시', 'TV 광고');
insert into tblStaff values (3, '하하하', 350, '의정부시', '매출 분석');

select * from tblStaff;

-- '홍길동'에게 담당 프로젝트를 1개 추가 > '고객 관리'

--1	홍길동	300	서울시	    홍콩 수출,고객 관리
--2	아무개	250	인천시	    TV 광고
--3	하하하	350	의정부시	    매출 분석

--1	홍길동	300	서울시	    홍콩 수출
--2	아무개	250	인천시	    TV 광고
--3	하하하	350	의정부시	    매출 분석
--4	홍길동	300	서울시      고객 관리

-- 테이블 생성 순서가 중요하다
-- 1. 부모 테이블 -> 2. 자식 테이블

create table tblStaff -- 부모 테이블
(
    seq number primary key,         --직원번호(PK)
    name varchar2(30) not null,     --직원명
    salary number not null,         --급여
    address varchar2(300) not null --거주지
);

create table tblProject -- 자식 테이블 
(
    seq number primary key,              -- 프로젝트 번호(PK)
    project varchar2(300) not null,      -- 프로젝트명
   
   -- 담당직원번호(Foreign Key, 참조키, 외래키)
   -- ORA-02449: 외래 키에 의해 참조되는 고유/기본 키가 테이블에 있습니다
   -- 자식 테이블이 부모 테이블에 참조하고 있는 값이 있으면 부모 테이블을 지울 수 없다
    staff_seq number not null references tblStaff(seq)
    
);

insert into tblStaff values (1, '홍길동', 300, '서울시');
insert into tblStaff values (2, '아무개', 250, '인천시');
insert into tblStaff values (3, '하하하', 350, '의정부시');


insert into tblProject values (1, '홍콩 수출', 1); -- 홍길동
insert into tblProject values (2, 'TV 광고', 2); -- 아무개
insert into tblProject values (3, '매출 분석', 3); -- 하하하
insert into tblProject values (4, '고객 관리', 1); -- 홍길동이 또 맡는 업무
insert into tblProject values (5, '대리점 분양', 2); -- 아무개가 또 맡는 업무

select * from tblStaff;
select * from tblProject;

-- 사장님: 'TV 광고' 담당자를 불러와 !!
select * from tblProject where project = 'TV 광고';
select * from tblStaff where seq = 2;

select * from tblStaff where seq = 
    (select staff_seq from tblProject where project = 'TV 광고');
    
-- A. 신입 사원 입사 -> 신규 프로젝트 배정
-- A.1 신입 사원 추가
insert into tblStaff values (4, '호호호', 220, '성남시');

-- A.2 신규 프로젝트 배정
insert into tblProject values (6, '자재 매입', 4);

select * from tblStaff where seq = 
    (select staff_seq from tblProject where project = '자재 매입');
    
-- A.3 신규 프로젝트 추가
-- ORA-02291: 무결성 제약조건(HR.SYS_C008467)이 위배되었습니다- 부모 키가 없습니다
insert into tblProject values (7, '고객 유치', 5);

select * from tblStaff where seq = 
    (select staff_seq from tblProject where project = '고객 유치');
    
delete from tblProject
where seq = 7;

-- B. '홍길동' 퇴사
-- B.1 '홍길동' 삭제

select * from tblstaff;

delete from tblStaff where name = '홍길동'; -- 동명이인이 있을 수 있으니 조심해야함
delete from tblStaff where seq = 1; -- 유일한 식별자로 검색 -> PK

-- 사장님: 홍콩 수출 담당자 누구야 !!
select * from tblStaff where seq = 
    (select staff_seq from tblProject where project = '홍콩 수출');
    
select * from tblProject;
select * from tblStaff;

-- B.2 '홍길동' 삭제 전 -> 업무 인수 인계(위임)
update tblProject set staff_seq = 2 where staff_seq = 1;

-- B.3 '홍길동' 삭제
delete from tblStaff where seq = 1; -- 유일한 식별자로 검색 -> PK

-- 인수인계한 아무개가 출력됨
select * from tblStaff where seq = 
    (select staff_seq from tblProject where project = '홍콩 수출');
    
drop table tblStaff;
drop table tblProject;


create table tblShop
(
    seq number primary key,                     -- 판매번호(PK)
    item varchar2(50) not null,                 -- 상품명
    qty number not null,                        -- 수량
    regdate date default sysdate not null,
    id varchar2(30) not null references tblUser(id) -- 구매한 고객의 ID(FK)
    -- Foreign Key 는 항상 부모 테이블의 Primary Key와 관계를 맺어야 함
    -- Primary Key 가 아닌 데이터와 관계를 맺으면 만약에 이름 같은 경우, 동명이인이
    -- 있을 수 있기 때문에 누가 구매한건지 구분이 안 감
);

-- 회원가입이 되어야 판매가 되니까 tblUser가 부모 테이블
-- tblShop 이 tblUSer 참조
create table tblUser
(
    id varchar2(30) primary key,                -- 고객 아이디(PK)
    name varchar2(30) not null,                 -- 고객명
    tel varchar2(15) not null                   -- 연락처

);

/*
    조인, Join
    - (서로 관계를 맺고) 2개(1개) 이상의 테이블을 대상으로 select를 날리는데 1개의 결과셋이 출력
    
    조인의 종류(ANSI-SQL)
    1. 크로스 조인, cross join
    2. 내부(단순) 조인, inner join
    3. 외부 조인, outer join
    4. 셀프 조인, self join
    5. 전체 외부 조인, full outer join
    
    1. 크로스 조인, cross join
    2. 내부(단순) 조인, inner join
    3. 외부 조인, outer join
        - 전체 외부 조인, full outer join
    
    1. 셀프 조인, self join
    
    DB 이론
    - 관계 대수 -> 연산(자)
    - 테이블을 피연산자로 하는 계산
    - 테이블 + 테이블 -> union
    - 테이블 - 테이블 -> minus
    - 테이블 * 테이블 -> join
    
    1. 크로스 조인, cross join
    - 카티션 곱, 데카르트 곱
    - A 테이블 * B 테이블 = 1개의 결과 테이블
    - 결론은 쓸모가 없다..? -> 가치가 있는 행과 가치가 없는 행(쓰레기)이 같이 존재한다
    - 그럼 왜씀? -> 유효성 관계없이 양이 많은 데이터가 필요할 때 -> 대량의 더미 데이터용
    - 나머지 조인들이 크로스 조인을 바탕으로 만들어졌기 때문에 안쓸뿐이지 중요는하다



*/

select * from tblCustomer; -- 고객 3명
select * from tblSales; -- 판매 9건

-- 이 둘을 곱한다?
select * from tblCustomer cross join tblSales; -- 표준 SQL 구문(다른 SQL에서도 이렇게 쓴다는것)
select * from tblCustomer, tblSales; -- 오라클 전용 구문


/*

    2. 내부(단순)조인, inner join
    - 크로스 조인에서 유효한 레코드만 추출한 조인
    
    select 칼럼리스트 from 테이블A cross join 테이블B;
    
    왼쪽의 테이블의 PK 와 오른쪽 테이블의 FK 가 똑같은 애들만 콕 집어야하는데
    오라클이 알아서 할 수 있는게 아니라서 on 이라는 조건을 붙여야함
    select 칼럼리스트 from 테이블A inner join 테이블B on 테이블A.PK = 테이블B.FK;


*/

-- 고객 정보와 판매 정보를 같이 보고 싶어서 inner join
-- ANSI-SQL(표준 SQL 구문)
select * from tblcustomer 
    inner join tblSales 
        on tblCustomer.seq = tblSales.cseq;
        
-- Oracle 전용 구문
-- 왜 오라클 전용 구문이 따로 있을까?
-- 오라클이 표준보다 먼저 나왔기 때문
-- 오라클 출시되고 10년뒤에 표준으로 맞추자!! 해서
-- 나온게 ANSI
select * from tblCustomer, tblSales
        where tblCustomer.seq = tblSales.cseq;
        
-- 헷갈리는 시퀀스들만 누구건지 앞에다가 테이블을 작성하자
select
    c.seq as 회원번호,
    c.name as 회원명,
    s.seq as 판매번호,
    s.item as 상품명
from tblCustomer c
    inner join tblSales s -- 긴걸 줄이는 용도기의 Alias이기 때문에 알파벳 소문자 하나만 적는다
        on c.seq = s.cseq;
        
-- 고객 테이블 + 판매 테이블
-- 어떤 고객(c.name)이 어떤 물건(s.item)을 몇개(s.qty)를 사갔는지 궁금하다

select *
    from tblCustomer c
        inner join tblSales s
            on c.seq = s.cseq;
            
select 
    item,   
    qty,
    cseq,
    (select name from tblCustomer where seq = tblSales.cseq) -- 상관 서브 쿼리
from tblSales; -- 자식 테이블 -> 메인 쿼리

-- 비디오(자식) + 장르(부모)
-- 어떤 비디오가 어떤 장르에 속해있는지 한꺼번에 보고 싶다
select 
    *
from tblGenre g
    inner join tblVideo v
        on g.seq = v.genre;
        
-- 대여(자식) + 비디오(부모) = 비디오(자식) + 장르(부모)
-- 대여 + 비디오 + 장르
-- 기존에 두 테이블(비디오 + 장르)을 이미 조인해놨는데 새로운 '대여'가 포함이 된다?
-- [회원]-[대여]-[비디오]-[장르]
-- {[대여]-([비디오]-[장르])}
select
    *
from tblGenre g
    inner join tblVideo v
        on g.seq = v.genre
            inner join tblRent r
                on v.seq = r.video;
-- 출력: 액션 장르에 털미네이터라는 영화가 있는데 이걸 07/02/03 에 누가 빌려갔는데 아직 반납 안했음

-- 회원(부모) + 대여(자식) = 대여(자식) + 비디오(부모) = 비디오(자식) + 장르(부모)
-- 회원 + 대여 + 비디오 + 장르

select
    *
from tblGenre g
    inner join tblVideo v
        on g.seq = v.genre
            inner join tblRent r
                on v.seq = r.video
                    inner join tblMember m
                        on m.seq = r.member; -- 회원(tblMember m)의 PK 인 seq 와 대여(tblRent r)의 FK 인 member
                        
-- join 도 성능상으로는 느림


/*
    3. 외부 조인 outer join
    - 내부 조인의 반댓말이 아니다
    - 내부 조인을 그대로 가지고 있고 거기에 + @ 한 느낌
    - 내부 조인의 확장같은 느낌
    
    select 
        칼럼리스트 
    from 테이블A 
        (left 아니면 right)outer join 테이블B 
            on 테이블A.PK = 테이블B.FK; 
    
    left 는 왼쪽의 테이블을 가리킨다 라는 의미 right는 오른쪽
    on 조건은 쓰레기 데이터를 걸러내는 역할

*/

select * from tblCustomer;      -- 3명
select * from tblSales;         -- 구매 내역 9건

insert into tblCustomer values (4, '강아지', '010-1234-5678', '서울시');
insert into tblCustomer values (5, '고양이', '010-1234-5678', '서울시');

-- 내부 조인
-- 물건을 한번이라도 구매한 이력이 있는 고객의 정보와 구매 내역을 가져오시오.
select * from tblCustomer c
    inner join tblSales s
        on c.seq = s.cseq;
        
-- 외부 조인
-- inner join에 참여하지 않은 애들도 다 가져와라가 outer join?
-- 모든(구매 이력이 있든 없든) 고객의 정보를 가져오시오
-- 구매 이력이 있다면 그 구매 내역도 같이 가져오시오
-- 방향은 부모 테이블을 가르키는게 대부분이다
select * from tblCustomer c
    left outer join tblSales s
        on c.seq = s.cseq;

select * from tblCustomer c
    right outer join tblSales s
        on c.seq = s.cseq;
        
select * from tblstaff; -- 4명(직원들 중 3명은 프로젝트를 담당중)
-- 방금 다시 입사시킨 길동이는 프로젝트가 없음
select * from tblProject; -- 프로젝트 6건

-- 내부 조인
-- 프로젝트를 1개 이상 담당하고 있는 직원 정보와 프로젝트 정보를 갖고 오세요
-- 길동이는 프로젝트를 맞고 있지 않아서 안 보임
select * from tblStaff s
    inner join tblProject p
        on s.seq = p.staff_seq;
        
-- 외부 조인
-- 담당 프로젝트 유무와 상관없이 모든 직원의 정보를 가져오되, 담당하고 있는 프로젝트 정보도 가져오세요
select * from tblStaff s
    left outer join tblProject p
        on s.seq = p.staff_seq;
        
        
/*
    4. 셀프 조인
    
    - 내부 조인인데 셀프 조인인 애가 있고
    - 외부 조인인데 셀프 조인인 애가 있다
    
    4. 셀프 조인, self join
    - 1개의 테이블을 사용하는 조인
    - 테이블이 자기 스스로와 관계를 맺고 있는 테이블이 있다. 그럴 때 사용




*/

-- hr.employees <- 이것도 자기참조하는 테이블
-- 직원 테이블
create table tblSelf

(
    seq number primary key,                      -- 직원 번호(PK)
    name varchar2(30) not null,                  -- 직원 이름
    department varchar2(50) not null,            -- 부서 이름
    
    -- 사장은 유일하게 상사가 없다, 사장도 직원 중 한명
    -- 그래서 not null 못함
    boss number null references tblSelf(seq)     -- 직속 상사의 직원 번호, 본인이 본인을 참조하는 중
    

);

insert into tblSelf values (1, '홍사장', '사장실', null);
insert into tblSelf values (2, '김부장', '영업부', 1);
insert into tblSelf values (3, '박과장', '영업부', 2);
insert into tblSelf values (4, '최대리', '영업부', 3);
insert into tblSelf values (5, '정사원', '영업부', 4);
insert into tblSelf values (6, '이부장', '개발부', 1);
insert into tblSelf values (7, '하과장', '개발부', 6);
insert into tblSelf values (8, '신과장', '개발부', 6);
insert into tblSelf values (9, '황대리', '개발부', 7);
insert into tblSelf values (10, '허사원', '개발부', 9);

-- 직원 명단을 가져오시오. 단, 상사의 이름까지
-- 1. join
-- 2. subquery
-- 3. 계층형 쿼리

-- 직원들 중 직속 상사가 있는 직원만 가져오시오
-- 홍사장 빠짐
select 
    s2.name as 직원명,
    s2.department as 부서명,
    s1.name as 상사명
from tblself s1 -- 의도: 상사 테이블
    inner join tblSelf s2 -- 직원 테이블
        on s1.seq = s2.boss;

-- 모든 직원들과 상사 정보를 가져오시오!!
select 
    s2.name as 직원명,
    s2.department as 부서명,
    s1.name as 상사명
from tblself s1 -- 의도: 상사 테이블
    right outer join tblSelf s2 -- 직원 테이블
        on s1.seq = s2.boss;
        
select
    name as 직원명,
    department as 부서명,
    boss,
    (select name from tblSelf where seq = a.boss)
from tblSelf a; -- 직원(자식) 테이블

/*
    5. 전체 외부 조인, full outer join
    - 서로 참조하고 있는 관계에서 사용
    - 테이블 A > (참조) > 테이블 B
    - 테이블 B > (참조) > 테이블 A
    양쪽이 서로 참조
    관계가 너무 세서 데이터 조작이 힘들다
    그래서 잘 안쓴다?



*/

-- 예시
select * from tblMen;
select * from tblWomen;

-- 커플인 남녀를 가져오시오
select
    m.name as 남자,
    w.name as 여자
from tblMen m
    inner join tblWomen w -- 서로 참조하고 있어서 누가 부모 자식인지 상관없음
        on m.name = w.couple;
        
-- 커플 정보를 가져오고 남자 솔로들도 가져오시오
-- 그럼 '여친이 없어 가져오지 못했던 남자'를 가리켜야 한다
-- 그래서 left outer
select
    m.name as 남자,
    w.name as 여자
from tblMen m
    left outer join tblWomen w -- 서로 참조하고 있어서 누가 부모 자식인지 상관없음
        on m.name = w.couple;
        
-- 커플 정보를 가져오고 여자 솔로들도 가져오시오        
select
    m.name as 남자,
    w.name as 여자
from tblMen m
    right outer join tblWomen w -- 서로 참조하고 있어서 누가 부모 자식인지 상관없음
        on m.name = w.couple;
        
-- 다 가져오시오
-- full outer join

select
    m.name as 남자,
    w.name as 여자
from tblMen m
    full outer join tblWomen w -- 서로 참조하고 있어서 누가 부모 자식인지 상관없음
        on m.name = w.couple;

        
