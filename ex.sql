SELECT * FROM employees;

-- 1)
-- 입사일(hire_date)열이 있는데, 
-- 직원번호가 10001번에 해당하는 직원의 입사일이 5년이 넘었는지 확인
SELECT
    emp_no,
    TIMESTAMPDIFF(YEAR, hire_date, CURDATE()) AS 근속년수
FROM employees
where emp_no = 10001;
-- 만약 지났다면 "입사한지 00일이 지났습니다. 축하합니다. (쿠폰)"
-- 그렇지 않다면 "입사한지 00일밖에 안되었네요, 화이팅!"

-- DROP PROCEDURE if EXISTS five_year;

DELIMITER $$

CREATE PROCEDURE five_year_check(IN p_emp_no INT)
BEGIN
    SELECT
        emp_no,
        hire_date,
        TIMESTAMPDIFF(YEAR, hire_date, CURDATE()) AS 근속년수,
        CASE
            WHEN TIMESTAMPDIFF(YEAR, hire_date, CURDATE()) >= 5
                THEN '입사한지 5년이 지났습니다. 축하합니다. (쿠폰)'
            ELSE
                '입사한지 5년 미만입니다. 화이팅~'
        END AS message
    FROM employees
    WHERE emp_no = p_emp_no;
END $$

DELIMITER ;

call five_year_check(10001);



-- 2)
-- case when 구문 이용해서 학점프로그램.
-- 90점 이상은 A, 80점 이상은 B, 70점 이상은 C, 60점이상은 D, 60점 미만은 F
-- 결과값 : 
-- 취득점수 --> 77 학점 --> C
DELIMITER $$

CREATE PROCEDURE grade_check(IN p_score INT) 
-- create PROCEDURE : 저장 프로시저를 만든다.
-- grade_check : 프로시저(함수) 이름
-- (IN p_score INT) : 입력값 하나 받겠다
-- IN : 밖에서 안으로 들어오는 값 / p_score : 변수 이름 / INT : 정수
BEGIN
-- 이제부터 프로시저 안에서 실행될 코드 시작한다는 의미. 프로시저는 항상 Begin~End로 감쌈
    SELECT
        p_score AS 점수,
        -- p_score : 우리가 전달한 점수 값
        -- AS 점수 : 출력 칼럼 이름을 '점수'로 표시
        CASE
        -- 이제 조건에 따라 값을 골라보겠다는 의미. CASE는 IF대신 SELECT안에서 쓰는 조건문
            WHEN p_score >= 90 THEN 'A'
            WHEN p_score >= 80 THEN 'B'
            WHEN p_score >= 70 THEN 'C'
            WHEN p_score >= 60 THEN 'D'
            ELSE 'F'
        END AS 학점;
        -- END : CASE 끝
        -- AS 학점 : 결과 칼럼 이름
END $$

DELIMITER ;

CALL grade_check(77);

-- 3)
-- sqldb의 구매테이블(buytbl)에 구매액에 1500원 이상인 고객은 '최우수'
-- 1000원 이상인 고객은 '우수'
-- 1원 이상인 고객은 '일반'
-- 구매 실적이 없는 고객은 '유령고객'
use sqldb;
SELECT * FROM buytbl;


DELIMITER $$

CREATE PROCEDURE customer_grade()
-- 저장 프로시저를 만듦 (customer_grade라는 함수를 만듦)
BEGIN
    SELECT
        userID,
        SUM(price * amount) AS total_price,
        -- SUM(price * amount) : 한 고객이 얼마나 썼는지 계산
        CASE
            WHEN SUM(price * amount) >= 1500 THEN '최우수'
            WHEN SUM(price * amount) >= 1000 THEN '우수'
            WHEN SUM(price * amount) >= 1 THEN '일반'
            ELSE '유령고객'
        END AS customer_grade
        -- case끝. case는 무조건 end로 닫는다.
    FROM buytbl
    GROUP BY userID;
    -- GROUP BY userID : 고객별로 묶기. 중복을 한줄로 묶은 것.
END $$

DELIMITER ;


CALL customer_grade();



-- case는 값을 만들어낼 때, if는 로직 흐름을 제어할 때 사용함.
-- case는 SELECT 결과용이고 if는 프로시저/함수 안에서만 사용함.
-- case 안에서 else는 선택이지만 when과 then은 최소 1쌍 이상 반드시 필요함
