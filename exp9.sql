CREATE DATABASE IF NOT EXISTS Functions_Database;
USE Functions_Database;


CREATE TABLE Stud_Marks (
    Name        VARCHAR(50),
    Total_Marks INT
);

CREATE TABLE Result (
    Roll  INT,
    Name  VARCHAR(50),
    Class VARCHAR(50)
);

INSERT INTO Stud_Marks VALUES ('Ravi',  1200);
INSERT INTO Stud_Marks VALUES ('Anita',  950);
INSERT INTO Stud_Marks VALUES ('Rahul',  870);
INSERT INTO Stud_Marks VALUES ('Priya', 1000);


DELIMITER $$
CREATE PROCEDURE proc_Grade()
BEGIN
    DECLARE done    INT DEFAULT FALSE;
    DECLARE v_name  VARCHAR(50);
    DECLARE v_marks INT;
    DECLARE v_class VARCHAR(30);
    DECLARE rno     INT DEFAULT 1;
    DECLARE c1 CURSOR FOR SELECT Name, Total_Marks FROM Stud_Marks;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    OPEN c1;
    read_loop: LOOP
        FETCH c1 INTO v_name, v_marks;
        IF done THEN LEAVE read_loop; END IF;
        IF v_marks BETWEEN 990 AND 1500 THEN SET v_class = 'Distinction';
        ELSEIF v_marks BETWEEN 900 AND 989 THEN SET v_class = 'First Class';
        ELSEIF v_marks BETWEEN 825 AND 899 THEN SET v_class = 'Higher Second Class';
        ELSE SET v_class = 'Fail';
        END IF;
        INSERT INTO Result VALUES (rno, v_name, v_class);
        SET rno = rno + 1;
    END LOOP;
    CLOSE c1;
END $$
DELIMITER ;

CALL proc_Grade();
SELECT * FROM Result;

DELIMITER $$
CREATE FUNCTION get_grade(p_marks INT)
RETURNS VARCHAR(30) DETERMINISTIC
BEGIN
    DECLARE v_class VARCHAR(30);
    IF p_marks BETWEEN 990 AND 1500 THEN SET v_class = 'Distinction';
    ELSEIF p_marks BETWEEN 900 AND 989 THEN SET v_class = 'First Class';
    ELSEIF p_marks BETWEEN 825 AND 899 THEN SET v_class = 'Higher Second Class';
    ELSE SET v_class = 'Fail';
    END IF;
    RETURN v_class;
END $$
DELIMITER ;

SELECT get_grade(1200) AS Result;
SELECT get_grade(870)  AS Result;