-- ex15_update.sql

/*

    update문
    - 원하는 행의 원하는 컬럼값으로 수정하는 명령어
    update 테이블면 set 컬럼명 = 값 [, 컬럼명=값] * n[where 절]


*/
commit;
rollback;

select * from tblCountry;

-- 대한민국의 수도를 서울에서 세종으로 바꿔주세요
update tblCountry set capital = '세종'; -- 모든 나라의 수도가 세종시로 바뀌어버림
update tblCountry set capital = '세종' where name = '대한민국';

-- 전체 세계 인구의 인구수가 10% 증가했다면
update tblCountry set population = population * 1.1;

update tblCountry set
        capital = '제주',
        population = 5000,
        area = 20
            where name = '대한민국'