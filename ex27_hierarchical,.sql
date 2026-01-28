-- ex27_hierarchical,.sql

/*
    계층형 쿼리, Hierarchical Query
    - 오라클 전용 쿼리
    - 레코드의 관계가 서로간의 상하 수직 구조인 경우에만 사용한다
    - 주로 자기 참조를 하는 테이블에서 사용

    계층형 쿼리
    1. start with 절 + connect by 절
    2. 계층형 쿼리에서만 사용 가능한 의사 컬럼
        a. prior
        b. level
        c. 몇가지 함수들 ..

*/

select seq as 번호, 
       name as 직원명, 
       boss as 상사번호, 
       prior name as 상사명,
       level,
       connect_by_root name as 사장,
       connect_by_isleaf, -- 더이상 자식을 가지지 않는 leaf 노드, terminal 노드라고도 함
       -- SQL은 true false가 없어서 0이 true 1이 false
       sys_connect_by_path(name, '>')
from tblSelf
    start with seq = 1
        connect by prior seq = boss; -- on s1.seq = s2.boss
   
-- 스페이스바로 직급별 들여쓰기를 다르게 해보자        
select
    lpad(' ', (level -1) * 2)|| name as 직원명
from tblSelf
    start with seq = 1
        connect by prior seq = boss;