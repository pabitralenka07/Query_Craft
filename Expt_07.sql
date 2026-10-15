CREATE DATABASE Procedure_Database;
USE Procedure_Database;

CREATE TABLE FLIGHTS (
    flno     INT PRIMARY KEY,
    distance INT,
    departs  VARCHAR(50),
    arrives  VARCHAR(50)
);

CREATE TABLE AIRCRAFT (
    aid           INT PRIMARY KEY,
    aname         VARCHAR(50),
    cruisingrange INT
);

CREATE TABLE EMPLOYEES (
    eid    INT PRIMARY KEY,
    ename  VARCHAR(50),
    salary DECIMAL(10,2)
);

CREATE TABLE CERTIFIED (
    eid INT,
    aid INT,
    PRIMARY KEY (eid, aid),
    FOREIGN KEY (eid) REFERENCES EMPLOYEES(eid),
    FOREIGN KEY (aid) REFERENCES AIRCRAFT(aid)
);


INSERT INTO AIRCRAFT VALUES
    (1, 'Boeing 737', 3500),
    (2, 'Boeing 747', 6000),
    (3, 'Airbus A320', 2800),
    (4, 'Cessna 172', 800);

INSERT INTO EMPLOYEES VALUES
    (101, 'Raj',   120000),
    (102, 'Priya',  90000),
    (103, 'Anil',  110000),
    (104, 'Neha',   75000);

INSERT INTO CERTIFIED VALUES
    (101, 1), (101, 2),
    (102, 3),
    (103, 1), (103, 4),
    (104, 3);

INSERT INTO FLIGHTS VALUES
    (1, 1400, 'Delhi',  'Mumbai'),
    (2, 2500, 'Delhi',  'Kolkata'),
    (3, 3200, 'Mumbai', 'Chennai'),
    (4, 5500, 'Delhi',  'Dubai');


SELECT DISTINCT c.eid
FROM CERTIFIED c
JOIN AIRCRAFT a ON c.aid = a.aid
WHERE a.aname LIKE 'Boeing%';


SELECT DISTINCT e.ename
FROM EMPLOYEES e
JOIN CERTIFIED  c ON e.eid = c.eid
JOIN AIRCRAFT   a ON c.aid = a.aid
WHERE a.aname LIKE 'Boeing%';


SELECT DISTINCT a.aid
FROM AIRCRAFT a
WHERE a.cruisingrange >= (
    SELECT MAX(distance)
    FROM FLIGHTS
    WHERE departs = 'Delhi' AND arrives = 'Mumbai'
);

SELECT DISTINCT f.flno
FROM FLIGHTS f
WHERE EXISTS (
    SELECT 1
    FROM EMPLOYEES e
    JOIN CERTIFIED  c ON e.eid = c.eid
    JOIN AIRCRAFT   a ON c.aid = a.aid
    WHERE e.salary > 100000
      AND a.cruisingrange >= f.distance
);


SELECT DISTINCT e.ename
FROM EMPLOYEES e
JOIN CERTIFIED c ON e.eid = c.eid
JOIN AIRCRAFT  a ON c.aid = a.aid
WHERE a.cruisingrange > 3000
  AND a.aname NOT LIKE 'Boeing%';


SELECT eid
FROM EMPLOYEES
WHERE salary = (SELECT MAX(salary) FROM EMPLOYEES);


SELECT eid
FROM EMPLOYEES
WHERE salary = (
    SELECT MAX(salary)
    FROM EMPLOYEES
    WHERE salary < (SELECT MAX(salary) FROM EMPLOYEES)
);


SELECT eid
FROM CERTIFIED
GROUP BY eid
HAVING COUNT(aid) = (
    SELECT MAX(cnt)
    FROM (
        SELECT COUNT(aid) AS cnt
        FROM CERTIFIED
        GROUP BY eid
    ) AS sub
);


SELECT eid
FROM CERTIFIED
GROUP BY eid
HAVING COUNT(aid) = 3;


SELECT SUM(salary) AS Total_Salary_Paid
FROM EMPLOYEES;
