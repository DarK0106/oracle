--ex21_view.sql

/*
    view, 뷰
    - DB Object -> 객체 -> drop을 하지 않는 이상 오라클에 영구적으로 저장
    - create / drop -> DDL
    - 가상 테이블, 뷰 테이블 ...
    - 테이블과 유사한 행동을 한다
    - select 의 결과를 복사한 테이블(이해를 돕기 위해서 쉽게 표현한 말, 엄연히 따지면 틀린 말)
    - SQL 자체(select 라는 명령어 그 자체)를 저장한 객체
    - view를 만나면 그 view가 정의된 곳으로 간다고 생각, select문을 그때에서야 실행한다
    - view를 만들때는 그 select문을 가지고 있음
    
    create (or replace <- 생략 가능) view 뷰이름 <- 머리
    as <- 목, 연결부
    select 문; <- 몸통
    
    뷰를 사용하는 목적?
    자주 쓰는 쿼리를 저장하는 용도
    복잡하고 긴 쿼리를 저장하는 용도
    저장 객체 -> 같은 데이터베이스 사용자끼리 뷰 공유 가능 -> 재사용 or 협업
    권한 통제 -> 보안
        - ex) 신입 사원의 임무 -> 직원들 연락처를 얻어 문자 메시지 발송
            - tblInsa에 직원들 연락처가 있어요 라고 신입사원한테 알려줌
                - 신입사원이 tblInsa를 셀렉트
        - 문제) 민감한 정보인 주민등록번호와 급여 정보를 신입사원이 보게됨
    오라클이라는 DB는 계정에 따른 테이블 접근 권한을 통제할 수 있음
    -> view를 만들어서 신입사원에겐 vwInsa를 주자
    


*/

create or replace view vwInsa
as
select * from tblInsa;

select num, name, jikwi from tblInsa where buseo = '기획부';

-- 둘이 똑같음
select * from vwInsa;
select * from (select * from tblInsa); -- 익명 뷰, 인라인 뷰

-- 이건 좋지 않은 방법
-- 길동이가 전화번호 바뀌면 tblInsa, tblTel 두군데 다 바꿔야함
-- 같은 데이터를 두 곳 이상 보관하지 마라
create table tblTel
as
select num, name, tel from tblInsa;

select * from tblTel;

-- 그래서 view를 만들어보자
create or replace view vwTel
as
select num, name, tel from tblInsa;

select * from vwTel;

-- 길동이 전화번호를 바꾸면 어떻게됨?
-- 길동이 이름으로 찾지 말고 PK로 찾으시오
-- 길동이 원래 전화번호 011-2356-4528
update tblInsa set tel = '010-1111-2222' where num = 1001;

-- 원본을 확인해보자
select * from tblInsa where num = 1001; -- 010-1111-2222

-- 복사본을 확인해보자
select * from tblTel where num = 1001; -- 011-2356-4528, 복사본은 안바뀜

-- view는 전화번호가 바뀌었을까?
select * from vwTel where num = 1001; -- 010-1111-2222

-- 비디오 대여점 사장님이 날마다 몇십번씩 하는 업무
-- 어떤 회원이 어떤 비디오를 빌려갔으면 반납은 했는지 안했는지
-- 반납을 안했으면 언제까지 반납을 해야하는지
-- 연체되었으면 연체료가 얼마인지
-- 전화해서 빨리 반납하라고 독촉

-- vwCheck로 insert 를 해볼까? -> 불가능

create or replace view vwCheck
as
select
    m.name as 회원명,
    v.name as 비디오,
    r.rentdate as 대여일,
    r.retdate as 반납일,
    g.period as 대여기간,
    r.rentdate + g.period as 반납예정일,
    case
        when r.retdate is not null then r.retdate - r.rentdate - g.period -- 반납은 한 사람
        when r.retdate is null then round(sysdate - r.rentdate - g.period)
    end as 연체일,
    g.price as 대여료, -- 연체료는 하루당 대여료의 10%를 받겠다
    case
        when r.retdate is not null then r.retdate - r.rentdate - g.period -- 반납은 한 사람
        when r.retdate is null then round(sysdate - r.rentdate - g.period)
    end * g.price * 0.1 as 연체료
from tblMember m
    inner join tblRent r
        on m.seq = r.member
            inner join tblVideo v
                on v.seq = r.video
                    inner join tblGenre g
                        on g.seq = v.genre;
                        
select * from vwCheck;

-- 뷰 사용시 주의점!!
-- 1. select -> 실행됨 -> 아 view는 읽기 전용 테이블이구나!!
-- 2. insert -> 실행됨 -> 절대 사용 금지 !!
-- 3. update -> 실행됨 -> 절대 사용 금지 !!
-- 4. delete -> 실행됨 -> 절대 사용 금지 !!
create or replace view vwTodo
as
select * from tblTodo;

select * from vwTodo; -- view를 만난 순간 select * from tblTodo; 가 실행된다

insert into (select * from tblTodo) values (21, '뷰 만들기', sysdate, null);
update vwTodo set completedate = sysdate where seq = 21;
delete from vwTodo where seq = 21;

-- 단순 뷰(테이블이 1개)는 CRUD가 가능
-- 복합 뷰(테이블이 2개 이상)는 CRUD가 불가능 -> R은 가능
-- 뭐가 단순 뷰고 뭐가 복합 뷰인지 어떻게 암?? -> 결론: R만 하자 !!