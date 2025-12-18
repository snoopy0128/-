SELECT * from usertbl, buytbl;

SELECT usertbl.name, buytbl.`prodName` from usertbl, buytbl where usertbl. `userID` = buytbl.`userID`;
SELECT * from usertbl left OUTER JOIN buytbl on usertbl.`userID` = buytbl.`userID`;

SELECT * from usertbl RIGHT OUTER JOIN buytbl on usertbl.`userID` = buytbl.`userID`;

SELECT U.`userID`, U.name, B.`prodName`, U.addr, CONCAT(U.mobile1, U.mobile2)
from usertbl U left OUTER JOIN buytbl B on U.`userID` = B.`userID`
where U.addr = '서울';


-- self join
-- use sqldb;

-- create Table emptbl (
--     emp CHAR(3),
--     manager CHAR(3),
--     empTel VARCHAR(8)
-- );


SELECT* FROM emptbl;
insert into emptbl VALUES('나사장', NULL, '0000');
INSERT into emptbl VALUES('김재무', '나사장', '2222');
INSERT into emptbl VALUES('김부장', '김재무', '2222-1');
INSERT into emptbl VALUES('이부장', '김재무', '2222-2');
INSERT into emptbl VALUES('우대리', '이부장', '2222-2-1');
INSERT into emptbl VALUES('지사원', '이부장', '2222-2-2');
INSERT into emptbl VALUES('이영업', '나사장', '1111');
INSERT into emptbl VALUES('한과장', '이영업', '1111-1');
INSERT into emptbl VALUES('최정보', '나사장', '3333');
INSERT into emptbl VALUES('윤차장', '최정보', '3333-1');
INSERT into emptbl VALUES('이주임', '윤차장', '3333-1-1');


TRUNCATE emptbl;

-- self join
-- 우대리의 직속상관 연락처

SELECT * FROM emptbl A INNER JOIN emptbl B on A.manager = B.emp;
SELECT A.emp as '부하직원', B.emp as '직속상관', B.`empTel` as '직속상관연락처' 
FROM emptbl A INNER JOIN emptbl B on A.manager = B.emp
WHERE A.emp='우대리';



-- create Table stdTbl(
--     stdName VARCHAR(10) NOT NULL PRIMARY KEY,
--     addr CHAR(4) NOT NULL
-- );

-- create Table clubTbl(
--     clubName VARCHAR(10) NOT NULL PRIMARY KEY,
--     roomNo CHAR(4) NOT NULL
-- );


-- CREATE Table stdclubTbl(
--     num int AUTO_INCREMENT NOT NULL PRIMARY KEY,
--     stdName VARCHAR(10) NOT NULL,
--     clubName VARCHAR(10) NOT NULL,
--     Foreign Key (stdName) REFERENCES stdtbl(stdName),
--     Foreign Key (clubName) REFERENCES clubTbl (clubName)
-- );


SELECT * from stdtbl;
SELECT * FROM clubtbl;


-- INSERT INTO stdtbl VALUES('김범수', '경남'),('성시경', '서울'),('조용필', '경기'),('은지원', '경북'),('바비킴', '서울');
-- INSERT INTO clubtbl VALUES('수영', '101호'),('바둑', '102호'),('축구', '103호'),('봉사', '104호');
-- INSERT INTO stdclubtbl VALUES(null, '김범수', '바둑'),(null, '김범수', '축구'),(null, '조용필', '축구'),(null, '은지원', '축구'),(null, '은지원', '봉사'),(null, '바비킴', '봉사');

SELECT * FROM stdclubtbl;



-- 미션1
-- 학생 테이블, 동아리 테이블, 학생 동아리 테이블을 이용해서 학생을 기준으로 학생이름/지역/가입한 동아리/동아리방을 출력
SELECT stdtbl.`stdName`, stdtbl.`addr`, clubtbl.`clubName`, clubtbl.`roomNo` 
from stdtbl 
INNER JOIN stdclubtbl 
on stdtbl.`stdName` = stdclubtbl.`stdName` 
INNER JOIN clubtbl 
on clubtbl.`clubName` = stdclubtbl.`clubName`;


-- 미션2
-- 동아리를 기준으로 가입한 학생의 목록을 출력
SELECT clubtbl.`clubName`, stdclubtbl.`stdName` FROM clubtbl INNER JOIN stdclubtbl
on clubtbl.`clubName` = stdclubtbl.`clubName`;



-- 전체 회원의 구매 기록을 출력하되 구매 기록이 없는 회원도 출력
SELECT * from usertbl;
SELECT * from buytbl;

SELECT U.`mDate`, U.name, B.`prodName` 
from usertbl U
LEFT OUTER JOIN buytbl B
on U.`userID` = B.`userID`


-- 구매 내역이 없는 회원의 목록
SELECT U.name, B.`prodName` 
from usertbl U
LEFT OUTER JOIN buytbl B
on U.`userID` = B.`userID`
where B.`prodName` is NuLL;



-- 1) 동아리에 가입하지 않은 학생 출력 - 성시경의 클럽 이름에 null
SELECT S.`stdName`, SC.`clubName`
FROM stdtbl S
left OUTER JOIN stdclubtbl SC
on S.`stdName` = SC.`stdName`
where SC.`clubName` is NULL;


-- 2) 동아리를 기준으로 가입된 학생 이름 출력, 가입 학생이 하나도 없는 동아리도 출력, 수영쪽의 학생이 null
SELECT C.`clubName`, SC.`stdName` 
FROM stdtbl S
LEFT OUTER JOIN stdclubtbl SC
on S.`stdName` = SC.`stdName`
RIGHT OUTER JOIN clubtbl C
on C.`clubName` = SC.`clubName`;


-- 3) 위의 결과를 하나로 합치기(UNION)
-- 즉, 동아리에 가입하지 않은 학생도 출력되고 학생이 한 명도 없는 동아리도 출력되게 하세요.
SELECT S.`stdName`, SC.`clubName`
FROM stdtbl S
left OUTER JOIN stdclubtbl SC
on S.`stdName` = SC.`stdName`
where SC.`clubName` is NULL
UNION
SELECT C.`clubName`, SC.`stdName` 
FROM stdtbl S
LEFT OUTER JOIN stdclubtbl SC
on S.`stdName` = SC.`stdName`
RIGHT OUTER JOIN clubtbl C
on C.`clubName` = SC.`clubName`;



-- 교재 5,6장 연습문제 풀이 후 제출
use world;

SELECT * from country;
SELECT * FROM city;
SELECT * FROM countrylanguage;

-- 5-1) country 테이블의 Name열에서 'United States'인 데이터와 
-- city 테이블에서 해당 국가와 일치하는 데이터

SELECT country.NAME, city.*
FROM country
INNER JOIN city
on city.CountryCode = country.CODE
where country.Name = 'United States';


-- 5-2) city 테이블에서 인구가 가장 많은 도시 상위 10개
-- country 테이블에서 해당 도시의 국가 이름과 국가 총인구, GNP, 수명 등 정보를 조회
-- 조인 또는 서브 쿼리를 활용
use world;
SELECT city.Name, city.Population as '도시 인구', country.Name as country_name, country.Population as '국가총인구', country.GNP, country.LifeExpectancy as '수명'
FROM city
INNER JOIN country
on city.CountryCode = country.CODE
ORDER BY city.Population DESC LIMIT 10;


-- 5-3) countrylanguage 테이블과 country 테이블을 조합하여
-- 사용 언어가 English인 국가의 정보를 조회
use world;

SELECT country.*
FROM countrylanguage
INNER JOIN country
on countrylanguage.CountryCode = country.Code
where countrylanguage.Language = 'English';

SELECT *
FROM country
where code in (
    SELECT countrycode
    FROM countrylanguage
    where countrylanguage.LANGUAGE = 'English'
);


-- 5-4) sakila 데이터베이스
--  category 테이블의 name 열이 'Action'인 데이터와 관련된 배우 이름(first_name, last_name),
--  영화제목(title)과 개봉연도(release_year)를 조회

use sakila;
SELECT * from category;
SELECT * FROM actor;
SELECT * FROM film;
SELECT * FROM film_category;
SELECT * FROM film_actor;
SELECT * FROM rental;


SELECT A.first_name, A.last_name, F.title, F.release_year
FROM actor A
INNER JOIN film_actor FA
on A.actor_id = FA.actor_id
INNER JOIN film F
on F.film_id = FA.film_id
INNER JOIN film_category FC
on FC.film_id = F.film_id
INNER JOIN category C
on C.category_id = FC.category_id
WHERE C.name = 'Action'



-- 5-5) sakila 데이터 베이스의 
-- film, category, rental, inventory, payment 테이블을 활용하여 
-- 어떤 장르를 선호하는지 장르별 dvd 렌탈 횟수와 장르별 결제한 금액을 조회
-- 이를 고객 번호와 고객 이름을 함께 넣어 조회
SELECT
from film 
INNER JOIN category
on film.last_update = category.last_update
INNER JOIN rental
on 


-- 5-6) 
-- DROP Table IF EXISTS emp;
-- CREATE Table emp
-- (
--     employee_id int NOT  NULL PRIMARY KEY,
--     employee_name VARCHAR(50) NOT NULL,
--     manager_id int NULL
-- );

INSERT INTO emp VALUES (101, '이지연', NULL);
INSERT INTO emp VALUES (102, '강정훈', 101);
INSERT INTO emp VALUES (103, '임도환', 101);
INSERT INTO emp VALUES (104, '민가영', 102);
INSERT INTO emp VALUES (105, '김민찬', 102);
INSERT INTO emp VALUES (106, '장미선', 103);
INSERT INTO emp VALUES (107, '김시영', 103);
INSERT INTO emp VALUES (101, '이지연', );

-- 각 직원의 레벨 및 관리자 이름을 조회
-- 이때, 레벨 숫자가 낮을수록 높은 직급임



-- 6-1)
-- world 데이터베이스의 country 테이블에서 Name, Continent, Population
-- 열을 하나의 열로 만들기 위해 문자열을 연결하고 
-- 각 문자열 사이를 구분할 수 있도록 빈캄을 추가하여 그 결과를 조회
use world;
SELECT * FROM country;

SELECT CONCAT(Name, ' ', Continent, ' ', Population, ' ')
FROM country;


-- 6-2)
-- world 데이터베이스의 country 테이블에서 lndepYear 열이 Null인
-- 데이터를 조회하고 Null을 '데이터 없음'으로 표시
use world;
SELECT * FROM country;

SELECT name, IFNULL(IndepYear, "데이터 없음") as IndepYear 
FROM country
where IndepYear is null;


-- 6-3)
-- world 데이터베이스의 country 테이블에서 
-- Name 열을 모두 대문자로 조회하거나 모두 소문자로 조회
use world;
SELECT * FROM country;

SELECT UPPER(name), LOWER(name)
FROM country;


-- 6-4) 
-- world 데이터베이스의 country 테이블에서
-- Name 열의 왼쪽, 오른쪽, 양쪽 공백을 제거하고 데이터 조회
use world;
SELECT * FROM country;

SELECT LTRIM(Name), RTRIM(Name), TRIM(Name)
FROM country;


-- 6-5)
-- world 데이터 베이스의 country 테이블에서
-- Name 열의 길이가 20보다 큰 데이터를 열 길이가 높은 순서(내림차순)로 정렬
use world;
SELECT * FROM country;

SELECT Name, LENGTH(Name) as '나라 이름 길이'
FROM country
WHERE LENGTH(Name)>20
ORDER BY LENGTH(Name) DESC;


-- 6-6)
-- world 데이터베이스의 country 테이블에서
-- SurfaceArea 열의 소수점 자리까지만 조회
use world;
SELECT * FROM country;

SELECT Name, ROUND(`SurfaceArea`, 1)
FROM country;


-- 6-7)
-- world 데이터베이스의 country 테이블에서
-- Name 열의 2번째 문자부터 4개의 문자를 조회
use world;
SELECT * FROM country;

SELECT Name, SUBSTRING(Name, 2, 4)
FROM country;


-- 6-8)
-- world 데이터베이스의 country 테이블에서
-- Code 열에 있는 A라는 글자를 Z로 변환
use world;
SELECT * FROM country;

SELECT Code, REPLACE(Code, 'A', 'Z')
FROM country;


-- 6-9)
-- world 데이터베이스의 country 테이블에서
-- Code 열에 있는 A를 Z로 변환하고
-- Z를 10번 반복하여 표시한 결과를 조회
use world;
SELECT * FROM country;

SELECT Code, REPLACE(Code, 'A', repeat('Z',10))
from country;


-- 6-10)
-- 현재 날짜 및 시간에서 24시간을 더하는 쿼리
SELECT Now(), DATE_ADD(Now(), INTERVAL 24 HOUR);


-- 6-11)
-- 현재 날짜 및 시간에서 24시간을 빼는 쿼리 
SELECT Now(), DATE_SUB(NOW(), INTERVAL 24 HOUR);


-- 6-12)
-- 2024년은 1월 1일이 어떤 요일인지 조회
SELECT DAYNAME('2024-01-01');

-- 6-13)
-- world 데이터베이스의 country 테이블 전체 행 개수를 구하는 쿼리
SELECT COUNT(*)
FROM country;

-- 6-14)
-- world 데이터베이스의 country 테이블에서
-- GNP열의 합 및 평균, 최댓값, 최솟값을 구하는 쿼리
SELECT SUM(GNP) as '합', AVG(GNP) as '평균', MAX(GNP) as '최댓값', MIN(GNP) as '최솟값'
FROM country;

-- 6-15)
-- world 데이터베이스의 country 테이블에서
-- LifeEXpectancy 열을 소수 첫 번째 자리에서 반올림한 결과를 조회
SELECT Name, ROUND(LifeEXpectancy, 0)
FROM country;

-- 6-16)
-- world 데이터베이스의 country 테이블에서
-- LifeExpectancy 열의 값이 높은 순서대로 순위를 부여하되
-- 동점일 경우 알파벳 순으로 하여 더 높은 순위를 부여하는 쿼리
SELECT ROW_NUMBER() OVER (ORDER BY LifeExpectancy DESC, Name ASC) as '순위',
Name, LifeExpectancy
FROM country;


-- 6-17)
-- world 데이터베이스의 country 테이블에서
-- LifeExpectancy 열의 값이 높은 순서대로 순위를 부여하되
-- 동점일 경우 같은 순위를 부여하고 
-- 그다음 순위는 동점 순위 개수만큼 건너뛰고 다음 순위를 부여하는 쿼리
SELECT RANK() over (ORDER BY LifeExpectancy DESC) as '순위', 
Name, LifeExpectancy
from country;



-- 6-18)
-- world 데이터베이스의 country 테이블에서
-- LifeExpectancy 열의 값이 높은 순서대로 순위를 부여하되
-- 동점일 경우 같은 순위를 부여하고
-- 그다음 순위는 동점 순위 개수를 무시하고 바로 다음 순위를 부여하는 쿼리
SELECT DENSE_RANK() over (ORDER BY LifeExpectancy DESC) as '순위',
Name, LifeExpectancy
FROM country