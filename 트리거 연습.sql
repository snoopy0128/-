CREATE Table tbl_trigger_1 (
    col_1 INT,
    col_2 VARCHAR(50)
);

CREATE Table tbl_trigger_2(
    col_1 INT,
    col_2 VARCHAR(50)
);


INSERT into tbl_trigger_1 VALUES (1, '데이터 1 입력');

SELECT * from tbl_trigger_1;

DELIMITER $$

CREATE Trigger dot_update_trigger
after UPDATE
on tbl_trigger_1 for each row

Begin
    insert into tbl_trigger_2 VALUES (OLD.col_1, OLD.col_2);

end $$

DELIMITER ;

set sql_safe_updates = 0;

UPDATE tbl_trigger_1 set col_1 = 1, col_2 = '1을 2로 수정'

SELECT * from tbl_trigger_2;
SELECT * from tbl_trigger_1;