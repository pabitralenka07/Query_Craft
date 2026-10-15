CREATE DATABASE Hospital_Database;
USE Hospital_Database;


CREATE TABLE Departments (
    dept_no       INT PRIMARY KEY,
    dept_name     VARCHAR(50),
    dept_location VARCHAR(50)
);

CREATE TABLE Employees (
    emp_id     INT PRIMARY KEY,
    emp_name   VARCHAR(50),
    emp_salary DECIMAL(10,2),
    dept_no    INT,
    FOREIGN KEY (dept_no) REFERENCES Departments(dept_no)
);


INSERT INTO Departments VALUES
    (1, 'Human Resources', 'Bangalore'),
    (2, 'Finance',         'Delhi'),
    (3, 'IT',              'Hyderabad'),
    (4, 'Marketing',       'Mumbai');

INSERT INTO Employees VALUES
    (100, 'Amit',  40000, 1),
    (102, 'Sneha', 52000, 2),
    (103, 'Rahul', 48000, 3),
    (104, 'Priya', 55000, 4);


GRANT ALL PRIVILEGES
ON Employees
TO 'dept_user'@'localhost';


FLUSH PRIVILEGES;



GRANT SELECT, INSERT
ON Employees
TO 'dept_user'@'localhost';


REVOKE ALL PRIVILEGES
ON Employees
FROM 'dept_user'@'localhost';


REVOKE INSERT
ON Employees
FROM 'dept_user'@'localhost';

START TRANSACTION;
INSERT INTO Employees VALUES (101, 'Ravi', 45000, 1);
SAVEPOINT sp1;
UPDATE Employees
SET emp_salary = 50000
WHERE emp_id = 101;
ROLLBACK TO sp1;
COMMIT;
