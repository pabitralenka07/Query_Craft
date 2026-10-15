CREATE DATABASE College_Database;
USE College_Database;


CREATE TABLE Student ( 
REGNO VARCHAR(15) PRIMARY KEY, 
SName VARCHAR(50), 
Address VARCHAR(100), 
Phone VARCHAR(15), 
Gender VARCHAR(10) 
);
INSERT INTO Student VALUES 
('1BP22CS101','Amit Kumar','Bangalore','9876543210','Male'), 
('1BP22CS102','Sneha Reddy','Hyderabad','9876543211','Female'), 
('1BP22CS103','Rahul Sharma','Delhi','9876543212','Male'), 
('1BP22CS104','Priya Singh','Mumbai','9876543213','Female'), 
('1BP22CS105','Arjun Rao','Bangalore','9876543214','Male'), 
('1BP22CS106','Neha Gupta','Chennai','9876543215','Female');
SELECT * FROM Student;


CREATE TABLE SemSec ( 
 SSID INT PRIMARY KEY, 
 Sem INT, 
 Sec CHAR(1) 
);
INSERT INTO SemSec VALUES 
(1,4,'A'), 
(2,4,'B'), 
(3,4,'C'), 
(4,8,'A'), 
(5,8,'B'), 
(6,8,'C');
SELECT * FROM SemSec;


CREATE TABLE Class ( 
 REGNO VARCHAR(15), 
 SSID INT, 
 PRIMARY KEY (REGNO, SSID), 
 FOREIGN KEY (REGNO) REFERENCES Student(REGNO), 
 FOREIGN KEY (SSID) REFERENCES SemSec(SSID) 
);
INSERT INTO Class VALUES 
('1BP22CS101',3), 
('1BP22CS102',3), 
('1BP22CS103',2), 
('1BP22CS104',1), 
('1BP22CS105',4), 
('1BP22CS106',5);
SELECT * FROM Class;


CREATE TABLE Course ( 
 Subcode VARCHAR(10) PRIMARY KEY, 
 Title VARCHAR(50), 
 Sem INT, 
 Credits INT 
);
INSERT INTO Course VALUES 
('CS401','Database Management System',4,4), 
('CS402','Operating Systems',4,3), 
('CS801','Machine Learning',8,4), 
('CS802','Cloud Computing',8,3);
SELECT * FROM Course;


CREATE TABLE IAMARKS ( 
 REGNO VARCHAR(15), 
 Subcode VARCHAR(10), 
 SSID INT, 
 Test1 INT, 
 Test2 INT, 
 Test3 INT, 
 FinalIA INT, 
 PRIMARY KEY (REGNO, Subcode, SSID), 
 FOREIGN KEY (REGNO) REFERENCES Student(REGNO), 
 FOREIGN KEY (Subcode) REFERENCES Course(Subcode), 
 FOREIGN KEY (SSID) REFERENCES SemSec(SSID) 
);
INSERT INTO IAMARKS VALUES 
('1BP22CS101','CS401',3,18,16,19,NULL), 
('1BP22CS102','CS401',3,15,14,16,NULL), 
('1BP22CS103','CS402',2,12,13,11,NULL), 
('1BP22CS104','CS402',1,17,18,16,NULL), 
('1BP22CS105','CS801',4,19,18,20,NULL), 
('1BP22CS106','CS802',5,13,12,14,NULL);
SELECT * FROM IAMARKS;


-- Query – Students in 4th Semester C Section

SELECT s.* 
FROM Student s 
JOIN Class c ON s.REGNO = c.REGNO 
JOIN SemSec ss ON c.SSID = ss.SSID 
WHERE ss.Sem = 4 AND ss.Sec = 'C';

-- Count Male and Female Students Semester & Section Wise

SELECT ss.Sem, ss.Sec, s.Gender, COUNT(*) AS Total 
FROM Student s 
JOIN Class c ON s.REGNO = c.REGNO 
JOIN SemSec ss ON c.SSID = ss.SSID 
GROUP BY ss.Sem, ss.Sec, s.Gender;

-- Create View for Test1 Marks

CREATE VIEW Test1_View AS 
SELECT i.REGNO, i.Subcode, c.Title, i.Test1 
FROM IAMARKS i 
JOIN Course c ON i.Subcode = c.Subcode 
WHERE i.REGNO = '1BP22CS101';
SELECT * FROM Test1_View;

-- Calculate FinalIA (Best Two Average)

UPDATE IAMARKS
SET FinalIA = (
    (Test1 + Test2 + Test3) - LEAST(Test1, Test2, Test3)
) / 2
WHERE REGNO IS NOT NULL;


-- Categorize Students (Only 8th Sem A, B, C)

ALTER TABLE IAMARKS ADD COLUMN CAT VARCHAR(20); 

UPDATE IAMARKS i 
JOIN Class c ON i.REGNO = c.REGNO 
JOIN SemSec ss ON c.SSID = ss.SSID 
SET i.CAT = 
 CASE 
 WHEN i.FinalIA BETWEEN 17 AND 20 THEN 'Outstanding' 
 WHEN i.FinalIA BETWEEN 12 AND 16 THEN 'Average' 
 WHEN i.FinalIA < 12 THEN 'Weak' 
 END 
WHERE ss.Sem = 8 
AND ss.Sec IN ('A','B','C');

SELECT i.REGNO, ss.Sem, ss.Sec, i.Subcode, i.FinalIA, i.CAT 
FROM IAMARKS i 
JOIN Class c ON i.REGNO = c.REGNO 
JOIN SemSec ss ON c.SSID = ss.SSID 
WHERE ss.Sem = 8 AND ss.Sec IN ('A','B','C');

