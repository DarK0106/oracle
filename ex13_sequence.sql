-- ex13_sequence.sql

/*
    시퀀스, Sequence
    - DB가 관리하는 객체라고 부르는 DB Object(테이블, 제약사항, 시퀀스 등 ..)
    - DB Object들을 만들고 수정하고 삭제하는 언어를 DDL이라고 부름(create, drop, alter)
    - 시퀀스는 일련 번호를 생성하는 객체(*중요)
    - 오라클 전용
    - 주로 식별자를 만드는데 사용
    
    시퀀스 객체 생성하기
    - create sequence 시퀀스명;
    
    시퀀스 객체 삭제하기
    - drop sequence 시퀀스명;

    시퀀스 객체 사용하기
    - 시퀀스명.nextVal
    - 시퀀스명.currVal



*/

create sequence seqNum;

select seqNum.nextVal from dual; -- 호출할때마다 숫자 하나를 돌려줌, 중복되지 않으면서 1씩 증가
drop sequence seqNum; -- 삭제하면 그걸로 끝

create sequence seqNo;

select seqNo.nextVal from dual; -- seqNum, seqNo 서로 독립적

select name, seqNum.nextVal from tblInsa;

insert into tblMemo(seq, name, memo, regdate)
    values (seqNum.nextVal, '강아지', '멍멍멍', sysdate); -- nextVal 사용 예
    
select * from tblMemo;

select seqNum.currVal from dual; -- 이 객체가 마지막으로 반환했던 숫자를 반환

-- 쇼핑몰에 상품 번호를 만들고 싶다, 상품 번호가 섞여있는 경우가 많음
-- ex. ABC001, BDF5534 ...
select 'ABC' || seqNum.nextVal from dual;

select 'ABC' || lpad(seqNum.nextVal, 3, '0') from dual;

-- 중간에 무슨일이생겨서 seqNum을 삭제할 일이 생겼음
-- 삭제하고 다시만들었는데 insert했던 데이터는 남아있음
-- 그래서 다시 insert 해볼려고하면 PK에 위배됨(이미 번호가 있으니까)

/*
    시퀀스 객체 생성하기
    - create sequence 시퀀스명; <- 초간단버전
    
    - create sequence 시퀀스명 increment by n start with n maxvalue n minvalue n cycle cache n;
    increment by n: 증감치 
    start with n: 시작값 
    maxvalue n: 최댓값(증감치가 양수일 때)
    minvalue n: 최솟값 
    cycle: 순환구조 
    cache n: 임시저장(성능 관련)

*/

drop sequence seqTest;
create sequence seqTest
                -- increment by 5 -- 증감치
                -- start with 10 -- 시작값
                -- maxvalue 10
                -- cycle
                cache 20;
            
select seqTest.nextVal from dual;

-- cache
-- service.msc -> OracleServiceXE -> 중지 -> DB 죽음 -> 실행 -> DB 부활
-- 5까지 해놨던거 nextVal 해보면 6으로 됨
-- 갑자기 정전이 났다? -> 오라클을 중지 버튼 누를 틈이 없음 -> 15번까지 해놓은걸 기억할 틈을 안 줌
-- oracle.exe 강제종료(갑자기 정전나는 상황 연출)
-- 다시 켜봤는데 16이 떠야 하는데 왜 26이 뜰까?
-- 업무상에 문제될건없음 중복만 안되면 됨
-- 메모리와 하드 왔다갔다하는 속도는 엄청느림
-- 그 왔다갔다를 PC 자체적으로 최소화하려고 함
-- 처음에 시퀀스 객체를 만들때 하드에서 애초에 20이라고 저장해놓음
-- 일단 그러면 왔다갔다 안하고 메모리에서만 시퀀스를 20까지 증가시킴
-- 21번째로 가는 순간 하드로 한번 감 그러면 하드에 있던걸 40으로 저장함
-- 그럼 이제 메모리에 있는 애는 40될때까지는 하드 왔다갔다할일이 없어서 성능이 좋음
-- 근데 정전나서 메모리에 있던 숫자가 날아감 -> 그래서 다시 켜보면
-- 하드에 있던 40이 마지막 숫자라고 생각해서 41이 찍힘
-- 그래서 같은 맥락으로 아까도 26이 뜬것
-- 근데 만약 숫자 건너뛰면 곤란한 업무가 있음 -> drop 시키고
-- start with 다음숫자 해서 다시 만들면 됨