CREATE DATABASE Views_index_Database;
USE Views_index_Database;


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
    (1, 'HR',      'Delhi'),
    (2, 'IT',      'Bangalore'),
    (3, 'Finance', 'Mumbai');

INSERT INTO Employees VALUES
    (101, 'Rahul', 45000, 1),
    (102, 'Priya', 55000, 2),
    (103, 'Amit',  60000, 2),
    (104, 'Neha',  35000, 3);


SELECT
    e.emp_id,
    e.emp_name,
    e.emp_salary,
    d.dept_name
FROM Employees e
INNER JOIN Departments d ON e.dept_no = d.dept_no;


SELECT
    e.emp_name,
    d.dept_name
FROM Employees e
LEFT JOIN Departments d ON e.dept_no = d.dept_no;


SELECT
    e.emp_name,
    d.dept_name
FROM Employees e
RIGHT JOIN Departments d ON e.dept_no = d.dept_no;


SELECT emp_name, emp_salary
FROM Employees
WHERE emp_salary > (
    SELECT AVG(emp_salary) FROM Employees
);
