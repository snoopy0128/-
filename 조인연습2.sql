use sqldb;

-- SELECT * from stdtbl 
-- UNION
-- SELECT * from clubtbl;


-- UNION ALL 은 중복된 열까지 모두 출력
SELECT * from stdtbl 
UNION ALL
SELECT * from clubtbl;


-- 서브 쿼리에서 not in

-- in ~ 에 포함

-- usertbl에서 mobile이 null인 경우
-- 그사람을 제외하고 전화번호를 
-- 010 0000 0000 로 조회
SELECT name, CONCAT (mobile1,mobile2)
FROM usertbl
where name not in (
SELECT name
FROM usertbl
WHERE mobile1 is NULL);


-- 전화번호 없는 사람 이름 나오게
SELECT name, CONCAT (mobile1,mobile2)
FROM usertbl
where name in (
SELECT name
FROM usertbl
WHERE mobile1 is NULL);

SELECT name, CONCAT (mobile1,mobile2)
FROM usertbl
where name not in (
SELECT name
FROM usertbl
WHERE mobile1 is NOT NULL);


