-- ex25_rank_function.sql

/*
    순위 함수
    - rownum 을 기반으로 만들어진 함수
    
    1. rank() over(order by 컬럼명 [asc|desc])
        - 값이 같으면 순서가 동일
        - 누적이 되서 괜찮음
    2. dense_rank() over(order by 컬럼명 [asc|desc])
        - 값이 같으면 순서가 동일
        - 누적이 되지 않음
    3. row_number() over(order by 컬럼명 [asc|desc])
        - 무조건 다른 순위를 가짐
        - rownum을 직접 사용했을 때와 동일

*/

-- tblInsa, 급여순으로 가져오는데 순위를 매겨달라
select 
    a.*, rownum 
from (select name, buseo, basicpay from tblInsa order by basicpay desc) a;

select
    name, buseo, basicpay,
    rank () over(order by basicpay desc)
from tblInsa;

select
    name, buseo, basicpay,
    row_number() over(order by basicpay desc) as rnum
from tblInsa;

select
    name, buseo, basicpay,
    dense_rank () over(order by basicpay desc) as rnum
from tblInsa;

-- 5위를 알고 싶다

select * from
(select
    name, buseo, basicpay,
    rank () over(order by basicpay desc) as rnum
from tblInsa)
    where rnum = 5;
    
    
-- partition by == group by 와 비슷한 역할
-- 순위함수에서만 사용 가능
select
    name, buseo, jikwi, basicpay,
    rank() over(partition by jikwi order by basicpay desc) as rnum
from tblInsa;