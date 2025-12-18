-- 혹시 이전에 만든 프로시저가 있다면 초기화
    DROP Procedure if EXISTS doit_proc;

SELECT COUNT(*) FROM customer;

-- 스토어드 프로시저 틀
DELIMITER $$

CREATE PROCEDURE doit_proc()
BEGIN
-- 변수 선언
    DECLARE customer_cnt int;
    DECLARE add_number int;

-- 초기값 설정
    SET customer_cnt = 0;
    SET add_number = 100;

    SET customer_cnt = (SELECT count(*) from customer);

    SELECT customer_cnt + add_number;

END $$
DELIMITER ;


call doit_proc();

show CREATE PROCEDURE doit_proc;


-- 지우고 다시해보기
DROP Procedure doit_proc;

DROP Procedure if EXISTS doit_proc;

DELIMITER $$

CREATE Procedure doit_proc()
BEGIN
    DECLARE customer_cnt int;
    DECLARE add_number int;

    SET customer_cnt = 0;
    SET add_number = 100;

    SET customer_cnt = (SELECT count(*) from customer);

    SELECT customer_cnt + add_number;
END $$

DELIMITER ;

call doit_proc();

DROP Procedure doit_proc;



-- if
-- store_id가 1이면 변수 s_id_one에 1씩 더하고,
-- store_id가 1이 아니면 변수 s_id_two에 1씩 더하고
-- 마지막에 selec로 결과를 반환
SELECT * FROM customer where customer_id = 1;

DELIMITER $$

CREATE PROCEDURE doit_if(customer_id_input int)
BEGIN
-- 변수 선언
    DECLARE store_id_i int;
    DECLARE s_id_one int;
    DECLARE s_id_two int;

-- 초기값 설정
    SET store_id_i = (SELECT store_id FROM customer where customer_id = customer_id_input);

    IF store_id_i = 1 THEN set s_id_one = 1;
    ELSE set s_id_two = 2;
    END IF;

    SELECT store_id_i, s_id_one, s_id_two;

END $$
DELIMITER ;

call doit_if(1);