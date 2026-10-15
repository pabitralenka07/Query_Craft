
CREATE DATABASE Prime;
USE Prime;


CREATE TABLE accounts (
	id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50),
    balance DECIMAL(10,2)
);

INSERT INTO accounts(name,balance) VALUES
('Adam',500.00),
('Bob',300.00),
('Charlie',1000.00);

SELECT * FROM accounts;

# transactions
START TRANSACTION;

UPDATE accounts SET balance = balance + 1000 WHERE id = 1;

SAVEPOINT after_wallet_topup;

UPDATE accounts SET balance = balance + 10 WHERE id = 1;

COMMIT;

SELECT * FROM accounts;



# join
CREATE TABLE customers (
	customer_id INT PRIMARY KEY,
    name VARCHAR(50),
    city VARCHAR(50)
);

INSERT INTO customers VALUES
(1,'Alice','Mumbai'),
(2,'Bob','Delhi'),
(3,'Charlie','Bangalore'),
(4,'David','Mumbai');

CREATE TABLE orders (
	order_id INT PRIMARY KEY,
    customer_id INT,
    amount INT
);

INSERT INTO orders VALUES
(101,1,500),
(102,1,900),
(103,2,300),
(104,5,700);

SELECT * FROM customers;
SELECT * FROM orders;

-- inner join 
SELECT c.customer_id, o.order_id, c.name
FROM customers c
INNER JOIN orders o
ON c.customer_id = o.customer_id;

-- left join
SELECT *
FROM customers c
LEFT JOIN orders o
ON c.customer_id = o.customer_id;

-- right join
SELECT *
FROM customers c
RIGHT JOIN orders o
ON c.customer_id = o.customer_id;

-- outer join
SELECT *
FROM customers c
LEFT JOIN orders o
ON c.customer_id = o.customer_id

UNION

SELECT *
FROM customers c
RIGHT JOIN orders o
ON c.customer_id = o.customer_id;

-- cross join 
SELECT *
FROM customers
CROSS JOIN orders;

-- self join
SELECT *
FROM customers as A
JOIN customers as B
ON A.customer_id = B.customer_id;

-- left exclusive join
SELECT *
FROM customers as A
LEFT JOIN orders as B
ON A.customer_id = B.customer_id
WHERE B.customer_id IS NULL;

-- right exclusive join
SELECT *
FROM customers as A
RIGHT JOIN orders as B
ON A.customer_id = B.customer_id
WHERE A.customer_id IS NULL;

# sub query
SELECT * FROM customers;
SELECT * FROM orders;

-- with WHERE
SELECT *
FROM orders
WHERE amount > (
	SELECT AVG (amount)
    FROM orders
);

-- with SELECT
SELECT name,
	(
		SELECT COUNT(*)
        FROM orders o
        WHERE o.customer_id = c.customer_id
    )AS order_count
FROM customers c;

-- with FROM
SELECT
	summary.customer_id,
    summary.avg_amount
FROM
	(
		SELECT
			customer_id,
            AVG(amount) as avg_amount
		FROM orders
        GROUP BY customer_id
	)AS summary;
    
    
# Views
CREATE VIEW view1 AS
SELECT customer_id,name FROM customers;

SELECT * FROM view1;
SELECT * FROM view1 WHERE name = "Alice";

-- 

CREATE VIEW view2 AS
SELECT c.customer_id,c.name,o.order_id
FROM customers c
INNER JOIN orders o
ON c.customer_id = o.customer_id;

SELECT * FROM view2;


#Index
CREATE TABLE accounts1 (
	account_id INT PRIMARY KEY,
    name VARCHAR (50), 
    balance DECIMAL (10, 2), 
    branch VARCHAR (50)
) ;

INSERT INTO accounts1 VALUES
 (1, 'Adam', 500.00, 'Mumbai'),
 (2, 'Bob', 300.00, 'Delhi'),
 (3, 'Charlie', 700.00, 'Bangalore'),
 (4, 'David', 1000.00, 'Noida');
 
SELECT * FROM accounts1;

CREATE INDEX id_branch ON accounts1 (branch);  -- single col

CREATE INDEX id2 ON accounts1 (branch,balance);  -- multi col

SHOW INDEX FROM accounts1;

SELECT *
FROM accounts1
WHERE branch = "Mumbai";


# Procedures
SELECT * FROM accounts1;

DELIMITER $$

CREATE PROCEDURE check_balance (IN acc_id INT, OUT bal DECIMAL (10, 2))

BEGIN
	SELECT balance INTO bal
	FROM accounts1
	WHERE account_id = acc_id;
END $$

DELIMITER ;

CALL check_balance(1, @balance);

SELECT @balance;




