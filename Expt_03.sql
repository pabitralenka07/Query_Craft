CREATE DATABASE Order_Datbase;
USE Order_Datbase;

CREATE TABLE SALESMAN (
    Salesman_id INT PRIMARY KEY,
    Name        VARCHAR(50),
    City        VARCHAR(50),
    Commission  DECIMAL(5,2)
);

CREATE TABLE CUSTOMER (
    Customer_id INT PRIMARY KEY,
    Cust_Name   VARCHAR(50),
    City        VARCHAR(50),
    Grade       INT,
    Salesman_id INT,
    FOREIGN KEY (Salesman_id) REFERENCES SALESMAN(Salesman_id)
        ON DELETE CASCADE
);

CREATE TABLE ORDERS (
    Ord_No       INT PRIMARY KEY,
    Purchase_Amt DECIMAL(10,2),
    Ord_Date     DATE,
    Customer_id  INT,
    Salesman_id  INT,
    FOREIGN KEY (Customer_id) REFERENCES CUSTOMER(Customer_id)
        ON DELETE CASCADE,
    FOREIGN KEY (Salesman_id) REFERENCES SALESMAN(Salesman_id)
        ON DELETE CASCADE
);

INSERT INTO SALESMAN VALUES
    (1000, 'John Smith',   'Bangalore', 0.15),
    (1001, 'Raj Kumar',    'Delhi',     0.13),
    (1002, 'David Lee',    'Mumbai',    0.11),
    (1003, 'Arjun Rao',    'Bangalore', 0.14),
    (1004, 'Priya Sharma', 'Chennai',   0.12);

INSERT INTO CUSTOMER VALUES
    (2001, 'Anil',   'Bangalore', 300, 1000),
    (2002, 'Sunita', 'Delhi',     200, 1001),
    (2003, 'Ramesh', 'Mumbai',    400, 1002),
    (2004, 'Kiran',  'Bangalore', 350, 1000),
    (2005, 'Neha',   'Chennai',   250, 1004),
    (2006, 'Rahul',  'Delhi',     150, 1001);

INSERT INTO ORDERS VALUES
    (3001, 2500.00, '2024-03-10', 2001, 1000),
    (3002, 1500.00, '2024-03-10', 2002, 1001),
    (3003, 4500.00, '2024-03-11', 2003, 1002),
    (3004, 3200.00, '2024-03-11', 2004, 1000),
    (3005, 2800.00, '2024-03-12', 2005, 1004),
    (3006, 1800.00, '2024-03-12', 2006, 1001);


SELECT COUNT(*) AS Total_Customers
FROM CUSTOMER
WHERE Grade > (
    SELECT AVG(Grade)
    FROM CUSTOMER
    WHERE City = 'Bangalore'
);


SELECT
    s.Salesman_id,
    s.Name,
    COUNT(c.Customer_id) AS Total_Customers
FROM SALESMAN s
JOIN CUSTOMER c ON s.Salesman_id = c.Salesman_id
GROUP BY s.Salesman_id, s.Name
HAVING COUNT(c.Customer_id) > 1;


SELECT s.Salesman_id, s.Name, 'Has Customer' AS Status
FROM SALESMAN s
WHERE s.Salesman_id IN (
    SELECT Salesman_id FROM CUSTOMER
)

UNION
SELECT s.Salesman_id, s.Name, 'No Customer' AS Status
FROM SALESMAN s
WHERE s.Salesman_id NOT IN (
    SELECT Salesman_id FROM CUSTOMER
);


CREATE VIEW Top_Salesman_View AS
SELECT
    o.Ord_Date,
    s.Salesman_id,
    s.Name,
    o.Purchase_Amt
FROM ORDERS o
JOIN SALESMAN s ON o.Salesman_id = s.Salesman_id
WHERE o.Purchase_Amt = (
    SELECT MAX(Purchase_Amt)
    FROM ORDERS
    WHERE Ord_Date = o.Ord_Date
);


SELECT * FROM Top_Salesman_View;


DELETE FROM SALESMAN WHERE Salesman_id = 1000;
