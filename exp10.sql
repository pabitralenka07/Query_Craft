CREATE DATABASE IF NOT EXISTS Library_fine_Database;
USE Library_fine_Database;


CREATE TABLE Borrower (
    Rollin        INT,
    Name          VARCHAR(50),
    Date_of_Issue DATE,
    Name_of_Book  VARCHAR(50),
    Status        CHAR(1)
);

CREATE TABLE Fine (
    Roll_no   INT,
    Fine_Date DATE,
    Amt       INT
);

INSERT INTO Borrower VALUES (101, 'Ravi',  CURDATE() - INTERVAL 20 DAY, 'DBMS',   'I');
INSERT INTO Borrower VALUES (102, 'Anita', CURDATE() - INTERVAL 35 DAY, 'Java',   'I');
INSERT INTO Borrower VALUES (103, 'Rahul', CURDATE() - INTERVAL 10 DAY, 'Python', 'I');

DELIMITER $$
CREATE PROCEDURE calculate_fine(IN p_roll_no INT, IN p_bookname VARCHAR(50))
BEGIN
    DECLARE issue_date DATE;
    DECLARE days       INT;
    DECLARE fine_amt   INT DEFAULT 0;

    SELECT Date_of_Issue INTO issue_date
    FROM Borrower
    WHERE Rollin = p_roll_no AND Name_of_Book = p_bookname
    LIMIT 1;

    IF issue_date IS NULL THEN
        SELECT 'Record Not Found' AS Message;
    ELSE
        SET days = DATEDIFF(CURDATE(), issue_date);

        IF days BETWEEN 15 AND 30 THEN
            SET fine_amt = days * 5;
        ELSEIF days > 30 THEN
            SET fine_amt = days * 50;
        ELSE
            SET fine_amt = 0;
        END IF;

        UPDATE Borrower SET Status = 'R'
        WHERE Rollin = p_roll_no AND Name_of_Book = p_bookname;

        IF fine_amt > 0 THEN
            INSERT INTO Fine VALUES (p_roll_no, CURDATE(), fine_amt);
        END IF;

        SELECT CONCAT('Fine Amount = ', fine_amt) AS Message;
    END IF;
END $$
DELIMITER ;

CALL calculate_fine(102, 'Java');
CALL calculate_fine(101, 'DBMS');
CALL calculate_fine(103, 'Python');
CALL calculate_fine(999, 'Unknown');

SELECT * FROM Fine;
SELECT * FROM Borrower;