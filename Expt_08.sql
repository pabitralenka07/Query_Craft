CREATE DATABASE Cursor_Database;
USE Cursor_Database;


CREATE TABLE Employee (
    E_id    INT PRIMARY KEY,
    E_name  VARCHAR(50),
    Age     INT,
    Salary  INT
);


INSERT INTO Employee VALUES
    (101, 'Ravi',  30, 40000),
    (102, 'Anita', 28, 50000),
    (103, 'Rahul', 35, 60000),
    (104, 'Priya', 32, 45000);


DELIMITER //

CREATE PROCEDURE EmployeeCursor()
BEGIN

    DECLARE done INT DEFAULT FALSE;

   
    DECLARE v_id     INT;
    DECLARE v_name   VARCHAR(50);
    DECLARE v_age    INT;
    DECLARE v_salary INT;

    
    DECLARE emp_cursor CURSOR FOR
        SELECT E_id, E_name, Age, Salary FROM Employee;

    
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

   
    OPEN emp_cursor;

    read_loop: LOOP
        
        FETCH emp_cursor INTO v_id, v_name, v_age, v_salary;

       
        IF done THEN
            LEAVE read_loop;
        END IF;

       
        SELECT v_id AS ID, v_name AS Name, v_age AS Age, v_salary AS Salary;

    END LOOP;

 
    CLOSE emp_cursor;

END //

DELIMITER ;


CALL EmployeeCursor();
