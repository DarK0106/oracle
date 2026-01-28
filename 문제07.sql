-- ### subquery ###################################


-- 우리 회사(EMPLOYEES)의 전체 직원 평균 월급보다 **더 많은 월급(Salary)**을 받는 직원들의 
-- **이름(First_Name)**과 **월급(Salary)**을 출력하세요. (단, 월급이 높은 순서대로 정렬해서 보여주세요.)
select * from employees;

select first_name, salary
from employees
    where salary > (select avg(salary) from employees)
        order by salary desc;

-- 2. tblMan. tblWoman. 서로 짝이 있는 사람 중 남자와 여자의 정보를 모두 가져오시오.
--    [남자]        [남자키]   [남자몸무게]     [여자]    [여자키]   [여자몸무게]
--    홍길동         180       70              장도연     177        65
--    아무개         175       null            이세영     163        null
--    ..
SELECT
    m.name as 남자, m.height as 남자키, m.weight as 남자몸무게,
    w.name as 여자, w.height as 여자키, w.weight as 여자몸무게
FROM tblMen m
    INNER JOIN tblWomen w  -- 누구랑 붙일까요?
        ON m.couple = w.name;   -- 어떤 조건으로 커플임을 확인하죠?
    
SELECT
    name as 남자,
    height as 남자키,
    weight as 남자몸무게,
    couple as 여자, -- 여친 이름은 남자 테이블에 이미 있죠?
    
    -- Q1. 여자 테이블 가서 '이 남자 여친의 키' 가져오기
    (SELECT height FROM tblWomen WHERE name = tblmen.couple ) as 여자키,
    
    -- Q2. 여자 테이블 가서 '이 남자 여친의 몸무게' 가져오기
    (SELECT weight FROM tblWomen WHERE name = tblmen.couple ) as 여자몸무게

FROM tblMen
WHERE couple IS NOT NULL; -- 커플인 사람만 조회

-- 3. tblAddressBook. 가장 많은 사람들이 가지고 있는 직업은 주로 어느 지역 태생(hometown)인가?
select * from tblAddressBook;

SELECT 
    hometown AS "태생",
    count(*) AS "인원수" 
FROM tblAddressBook
WHERE job = (
    -- [서브쿼리] 가장 흔한 직업 1개 찾기
    SELECT job 
    FROM (
        SELECT job, count(*) 
        FROM tblAddressBook
        GROUP BY job
        ORDER BY count(*) DESC
    )
    WHERE rownum = 1
)
GROUP BY hometown
ORDER BY count(*) DESC;

-- [복수전] 미션: "비주류의 삶을 찾아라"
-- tblAddressBook에서 **가장 사람 수가 적은 고향(Hometown)**을 찾아내세요. 
-- 그리고, 그 고향 출신인 사람들의 **이름(name), 직업(job), 나이(age), 고향(hometown)**을 모두 출력하세요.

select
    hometown as "고향",
    name as "이름",
    job as "직업",
    age as "나이"
from tblAddressBook
where hometown = 
(
    select hometown
    from
    (
    select hometown, count(*)
    from tblAddressBook
    group by hometown
    order by count(*) asc
    
    )
    where rownum = 1
);



-- 4. tblAddressBook. 이메일 도메인들 중 평균 아이디 길이가 가장 긴 이메일 사이트의 도메인은 무엇인가?
select
    email as "이메일"
from tblAddressBook
    where email =
    (
    select email
    from
    (
    select email, count(*)
    where length(email) > avg(length(email))
    
    
    )
    







-- 5. tblAddressBook. 평균 나이가 가장 많은 출신(hometown)들이 가지고 있는 직업 중 가장 많은 직업은?


-- 6. tblAddressBook. 남자 평균 나이보다 나이가 많은 서울 태생 + 직업을 가지고 있는 사람들을 가져오시오.


-- 7. tblAddressBook. gmail.com을 사용하는 사람들의 성별 > 세대별(10,20,30,40대) 인원수를 가져오시오.


-- 8. tblAddressBook. 가장 나이가 많으면서 가장 몸무게가 많이 나가는 사람과 같은 직업을 가지는 사람들을 가져오시오.


-- 9. tblAddressBook.  동명이인이 여러명 있습니다. 이 중 가장 인원수가 많은 동명이인의 명단을 가져오시오.(모든 이도윤)


-- 10. tblAddressBook. 가장 사람이 많은 직업의(332명) 세대별 비율을 구하시오.
--    [10대]       [20대]       [30대]       [40대]
--    8.7%        30.7%        28.3%        32.2%

