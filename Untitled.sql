-- ==============================
-- GLOBAL SETTINGS
-- ==============================
SET SQL_SAFE_UPDATES = 0;

-- =====================================================
-- EXPERIMENT 1: LIBRARY DATABASE
-- =====================================================
DROP DATABASE IF EXISTS library_db;
CREATE DATABASE library_db;
USE library_db;

CREATE TABLE PUBLISHER (
    Name VARCHAR(50) PRIMARY KEY,
    Address VARCHAR(100),
    Phone VARCHAR(15)
);

CREATE TABLE BOOK (
    Book_id INT PRIMARY KEY,
    Title VARCHAR(100),
    Publisher_Name VARCHAR(50),
    Pub_Year INT,
    FOREIGN KEY (Publisher_Name) REFERENCES PUBLISHER(Name)
    ON DELETE CASCADE
);

CREATE TABLE BOOK_AUTHORS (
    Book_id INT,
    Author_Name VARCHAR(50),
    PRIMARY KEY (Book_id, Author_Name),
    FOREIGN KEY (Book_id) REFERENCES BOOK(Book_id)
    ON DELETE CASCADE
);

CREATE TABLE LIBRARY_PROGRAMME (
    Programme_id INT PRIMARY KEY,
    Programme_Name VARCHAR(50),
    Address VARCHAR(100)
);

CREATE TABLE BOOK_COPIES (
    Book_id INT,
    Programme_id INT,
    No_of_Copies INT,
    PRIMARY KEY (Book_id, Programme_id),
    FOREIGN KEY (Book_id) REFERENCES BOOK(Book_id) ON DELETE CASCADE,
    FOREIGN KEY (Programme_id) REFERENCES LIBRARY_PROGRAMME(Programme_id) ON DELETE CASCADE
);

CREATE TABLE BOOK_LENDING (
    Book_id INT,
    Programme_id INT,
    Card_No INT,
    Date_Out DATE,
    Due_Date DATE,
    FOREIGN KEY (Book_id) REFERENCES BOOK(Book_id) ON DELETE CASCADE,
    FOREIGN KEY (Programme_id) REFERENCES LIBRARY_PROGRAMME(Programme_id) ON DELETE CASCADE
);

INSERT INTO PUBLISHER VALUES
('Pearson','New Delhi','9876543210'),
('McGraw Hill','Bangalore','9876501234'),
('Oxford','Mumbai','9876512345');

INSERT INTO BOOK VALUES
(101,'Database Systems','Pearson',2018),
(102,'Operating Systems','McGraw Hill',2015),
(103,'Computer Networks','Oxford',2020),
(104,'Data Structures','Pearson',2012),
(105,'Artificial Intelligence','Oxford',2023);

INSERT INTO BOOK_AUTHORS VALUES
(101,'Korth'),(101,'Sudarshan'),
(102,'Galvin'),(103,'Tanenbaum'),
(104,'Mark Allen'),(105,'Stuart Russell');

INSERT INTO LIBRARY_PROGRAMME VALUES
(1,'Computer Science','Block A'),
(2,'Information Technology','Block B'),
(3,'Electronics','Block C');

INSERT INTO BOOK_COPIES VALUES
(101,1,5),(102,1,3),(103,2,4),(104,2,6),(105,3,2);

INSERT INTO BOOK_LENDING VALUES
(101,1,1001,'2025-01-10','2025-01-20'),
(102,1,1001,'2025-02-15','2025-02-25'),
(103,2,1001,'2025-03-05','2025-03-15'),
(104,2,1001,'2025-04-12','2025-04-22'),
(105,3,1002,'2025-05-10','2025-05-20');

-- Queries
SELECT * FROM BOOK;

CREATE VIEW Available_Books AS
SELECT b.Book_id, b.Title,
SUM(bc.No_of_Copies) AS Total_Copies,
COUNT(bl.Book_id) AS Issued_Copies,
(SUM(bc.No_of_Copies) - COUNT(bl.Book_id)) AS Available_Copies
FROM BOOK b
JOIN BOOK_COPIES bc ON b.Book_id = bc.Book_id
LEFT JOIN BOOK_LENDING bl ON b.Book_id = bl.Book_id
GROUP BY b.Book_id, b.Title;

SELECT * FROM Available_Books;

-- =====================================================
-- EXPERIMENT 2: COLLEGE DATABASE
-- =====================================================
DROP DATABASE IF EXISTS college_db;
CREATE DATABASE college_db;
USE college_db;

CREATE TABLE STUDENT (
    REGNO VARCHAR(15) PRIMARY KEY,
    SName VARCHAR(50),
    Address VARCHAR(100),
    Phone VARCHAR(15),
    Gender VARCHAR(10)
);

CREATE TABLE SEMSEC (
    SSID INT PRIMARY KEY,
    Sem INT,
    Sec CHAR(1)
);

CREATE TABLE CLASS (
    REGNO VARCHAR(15),
    SSID INT,
    PRIMARY KEY (REGNO, SSID),
    FOREIGN KEY (REGNO) REFERENCES STUDENT(REGNO),
    FOREIGN KEY (SSID) REFERENCES SEMSEC(SSID)
);

CREATE TABLE COURSE (
    Subcode VARCHAR(10) PRIMARY KEY,
    Title VARCHAR(50),
    Sem INT,
    Credits INT
);

CREATE TABLE IAMARKS (
    REGNO VARCHAR(15),
    Subcode VARCHAR(10),
    SSID INT,
    Test1 INT,
    Test2 INT,
    Test3 INT,
    FinalIA INT,
    PRIMARY KEY (REGNO, Subcode, SSID),
    FOREIGN KEY (REGNO) REFERENCES STUDENT(REGNO),
    FOREIGN KEY (Subcode) REFERENCES COURSE(Subcode),
    FOREIGN KEY (SSID) REFERENCES SEMSEC(SSID)
);

INSERT INTO STUDENT VALUES
('1BP22CS101','Amit Kumar','Bangalore','9876543210','Male'),
('1BP22CS102','Sneha Reddy','Hyderabad','9876543211','Female'),
('1BP22CS103','Rahul Sharma','Delhi','9876543212','Male'),
('1BP22CS104','Priya Singh','Mumbai','9876543213','Female'),
('1BP22CS105','Arjun Rao','Bangalore','9876543214','Male'),
('1BP22CS106','Neha Gupta','Chennai','9876543215','Female');

INSERT INTO SEMSEC VALUES
(1,4,'A'),(2,4,'B'),(3,4,'C'),
(4,8,'A'),(5,8,'B'),(6,8,'C');

INSERT INTO CLASS VALUES
('1BP22CS101',3),('1BP22CS102',3),
('1BP22CS103',2),('1BP22CS104',1),
('1BP22CS105',4),('1BP22CS106',5);

INSERT INTO COURSE VALUES
('CS401','DBMS',4,4),
('CS402','OS',4,3),
('CS801','ML',8,4),
('CS802','Cloud',8,3);

INSERT INTO IAMARKS VALUES
('1BP22CS101','CS401',3,18,16,19,NULL),
('1BP22CS102','CS401',3,15,14,16,NULL),
('1BP22CS103','CS402',2,12,13,11,NULL),
('1BP22CS104','CS402',1,17,18,16,NULL),
('1BP22CS105','CS801',4,19,18,20,NULL),
('1BP22CS106','CS802',5,13,12,14,NULL);

UPDATE IAMARKS
SET FinalIA = ((Test1+Test2+Test3)-LEAST(Test1,Test2,Test3))/2;

ALTER TABLE IAMARKS ADD COLUMN CAT VARCHAR(20);

UPDATE IAMARKS i
JOIN CLASS c ON i.REGNO=c.REGNO
JOIN SEMSEC ss ON c.SSID=ss.SSID
SET i.CAT =
CASE
WHEN i.FinalIA BETWEEN 17 AND 20 THEN 'Outstanding'
WHEN i.FinalIA BETWEEN 12 AND 16 THEN 'Average'
ELSE 'Weak'
END
WHERE ss.Sem=8;

-- =====================================================
-- EXPERIMENT 3: ORDER DATABASE
-- =====================================================
DROP DATABASE IF EXISTS order_db;
CREATE DATABASE order_db;
USE order_db;

CREATE TABLE SALESMAN (
    Salesman_id INT PRIMARY KEY,
    Name VARCHAR(50),
    City VARCHAR(50),
    Commission DECIMAL(5,2)
);

CREATE TABLE CUSTOMER (
    Customer_id INT PRIMARY KEY,
    Cust_Name VARCHAR(50),
    City VARCHAR(50),
    Grade INT,
    Salesman_id INT,
    FOREIGN KEY (Salesman_id) REFERENCES SALESMAN(Salesman_id) ON DELETE CASCADE
);

CREATE TABLE ORDERS (
    Ord_No INT PRIMARY KEY,
    Purchase_Amt DECIMAL(10,2),
    Ord_Date DATE,
    Customer_id INT,
    Salesman_id INT,
    FOREIGN KEY (Customer_id) REFERENCES CUSTOMER(Customer_id) ON DELETE CASCADE,
    FOREIGN KEY (Salesman_id) REFERENCES SALESMAN(Salesman_id) ON DELETE CASCADE
);

INSERT INTO SALESMAN VALUES
(1000,'John Smith','Bangalore',0.15),
(1001,'Raj Kumar','Delhi',0.13),
(1002,'David Lee','Mumbai',0.11),
(1003,'Arjun Rao','Bangalore',0.14),
(1004,'Priya Sharma','Chennai',0.12);

INSERT INTO CUSTOMER VALUES
(2001,'Anil','Bangalore',300,1000),
(2002,'Sunita','Delhi',200,1001),
(2003,'Ramesh','Mumbai',400,1002),
(2004,'Kiran','Bangalore',350,1000),
(2005,'Neha','Chennai',250,1004),
(2006,'Rahul','Delhi',150,1001);

INSERT INTO ORDERS VALUES
(3001,2500,'2024-03-10',2001,1000),
(3002,1500,'2024-03-10',2002,1001),
(3003,4500,'2024-03-11',2003,1002),
(3004,3200,'2024-03-11',2004,1000),
(3005,2800,'2024-03-12',2005,1004),
(3006,1800,'2024-03-12',2006,1001);

-- =====================================================
-- EXPERIMENT 6: TRIGGER
-- =====================================================
DROP DATABASE IF EXISTS election_db;
CREATE DATABASE election_db;
USE election_db;

CREATE TABLE CONSTITUENCY (
    cons_id INT PRIMARY KEY,
    csname VARCHAR(50),
    csstate VARCHAR(50),
    no_of_voters INT
);

CREATE TABLE VOTER (
    vid INT PRIMARY KEY,
    vname VARCHAR(50),
    vage INT,
    vaddr VARCHAR(100),
    cons_id INT
);

INSERT INTO CONSTITUENCY VALUES
(1,'Bhubaneswar','Odisha',20000);

DELIMITER $$
CREATE TRIGGER voter_count_update
AFTER INSERT ON VOTER
FOR EACH ROW
BEGIN
    UPDATE CONSTITUENCY
    SET no_of_voters = no_of_voters + 1
    WHERE cons_id = NEW.cons_id;
END$$
DELIMITER ;

-- =====================================================
-- EXPERIMENT 8: CURSOR
-- =====================================================
DROP DATABASE IF EXISTS cursor_db;
CREATE DATABASE cursor_db;
USE cursor_db;

CREATE TABLE Employee (
    E_id INT PRIMARY KEY,
    E_name VARCHAR(50),
    Age INT,
    Salary INT
);

INSERT INTO Employee VALUES
(101,'Ravi',30,40000),
(102,'Anita',28,50000);

DELIMITER //
CREATE PROCEDURE EmployeeCursor()
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE v_id INT;
    DECLARE v_name VARCHAR(50);

    DECLARE emp_cursor CURSOR FOR SELECT E_id,E_name FROM Employee;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    OPEN emp_cursor;
    read_loop: LOOP
        FETCH emp_cursor INTO v_id,v_name;
        IF done THEN LEAVE read_loop; END IF;
        SELECT v_id,v_name;
    END LOOP;
    CLOSE emp_cursor;
END//
DELIMITER ;

CALL EmployeeCursor();

-- ==============================
-- END OF FILE
-- ==============================