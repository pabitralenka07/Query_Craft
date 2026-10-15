CREATE DATABASE Library_Database;
USE Library_Database;


CREATE TABLE Publisher(
Name VARCHAR(50) PRIMARY KEY,
Address VARCHAR(100),
Phone_No VARCHAR(10)
);
INSERT INTO Publisher VALUES
('Pearson','New Delhi','8972357825'),
('McGrawHill','Bangaluru','2378257815'),
('Oxford','Mumbai','7825529345');
SELECT * FROM Publisher;

CREATE TABLE Book(
Book_id INT PRIMARY KEY,
Title VARCHAR(100),
Publisher_name VARCHAR(50),
Publishing_year INT,
FOREIGN KEY(Publisher_name) REFERENCES Publisher(Name) ON DELETE CASCADE
);
INSERT INTO Book VALUES 
(101, 'Database Systems', 'Pearson', 2018), 
(102, 'Operating Systems', 'McGrawHill', 2015), 
(103, 'Computer Networks', 'Oxford', 2020), 
(104, 'Data Structures', 'Pearson', 2012), 
(105, 'Artificial Intelligence', 'Oxford', 2023);
SELECT *FROM Book;

CREATE TABLE Book_author(
Book_id INT,
Author_name VARCHAR (50),
PRIMARY KEY (Book_id,Author_name),
FOREIGN KEY(Book_id) REFERENCES Book(Book_id) ON DELETE CASCADE
);
INSERT INTO Book_author VALUES 
(101, 'Korth'), 
(101, 'Sudarshan'), 
(102, 'Galvin'), 
(103, 'Tanenbaum'),
(104, 'Mark Allen'), 
(105, 'Stuart Russell');
SELECT * FROM Book_author;

CREATE TABLE Library_programe(
Program_id INT PRIMARY KEY,
Program_name VARCHAR(50),
Address VARCHAR(50)
);
INSERT INTO Library_programe VALUES 
(1, 'Computer Science', 'Block A'), 
(2, 'Information Technology', 'Block B'), 
(3, 'Electronics', 'Block C');
SELECT * FROM Library_programe;

CREATE TABLE Book_copies(
Book_id INT,
Program_id INT,
No_of_copies INT,
PRIMARY KEY(Book_id,Program_id),
FOREIGN KEY(Book_id) REFERENCES Book(Book_id),
FOREIGN KEY(Program_id) REFERENCES Library_programe(Program_id) ON DELETE CASCADE
);
INSERT INTO Book_copies VALUES 
(101, 1, 5), 
(102, 1, 3), 
(103, 2, 4), 
(104, 2, 6), 
(105, 3, 2); 
SELECT * FROM Book_copies;

CREATE TABLE Book_lending(
Book_id INT,
Program_id INT,
Card_no INT,
Date_out DATE,
Due_date DATE,
FOREIGN KEY (Book_id) REFERENCES Book(Book_id) ON DELETE CASCADE, 
FOREIGN KEY (Program_id) REFERENCES Library_programe(Program_id) ON DELETE CASCADE
);
INSERT INTO Book_lending VALUES 
(101, 1, 1001, '2025-01-10', '2025-01-20'), 
(102, 1, 1001, '2025-02-15', '2025-02-25'), 
(103, 2, 1001, '2025-03-05', '2025-03-15'), 
(104, 2, 1001, '2025-04-12', '2025-04-22'), 
(105, 3, 1002, '2025-05-10', '2025-05-20');
SELECT * FROM Book_lending;


-- Retrieve complete book details 
SELECT
	b.Book_id,
    b.Title,
    b.Publisher_name,
    b.Publishing_year,
    ba.Author_name,
    lp.Program_name,
    bc.No_of_copies
FROM Book b
	JOIN Book_author ba ON b.Book_id = ba.Book_id
	JOIN Book_copies bc ON b.Book_id = bc.Book_id
	JOIN Library_programe lp ON bc.Program_id = lp.Program_id
ORDER BY b.Book_id;


-- Borrowers Who Borrowed More Than 3 Books (Jan–Jun 2025)

SELECT 
	Card_no, 
	COUNT(Book_id) AS Total_Books 
FROM Book_lending
WHERE Date_out BETWEEN '2025-01-01' AND '2025-06-30' 
GROUP BY Card_no 
HAVING COUNT(Book_id) > 3;

-- Delete a Book and Update Other Tables
DELETE FROM Book_author WHERE Book_id = 101;

-- Partition BOOK Table by Publication Year 
CREATE TABLE Book_partition(
Book_id INT,
Title VARCHAR(100),
Publisher_name VARCHAR(50),
Publishing_year INT
)
PARTITION BY RANGE (Publishing_year) (
	PARTITION P1 VALUES LESS THAN(2000),
	PARTITION P2 VALUES LESS THAN(2010),
	PARTITION P3 VALUES LESS THAN(2020),
	PARTITION P4 VALUES LESS THAN MAXVALUE
);

INSERT INTO Book_Partition
SELECT * FROM Book;
SELECT * FROM Book_partition
WHERE Publishing_year = 2018;

-- Create View for Available Books
CREATE VIEW Available_books AS
SELECT
	b.Book_id, 
	b.Title, 
	SUM(bc.No_of_copies) AS Total_copies, 
	COUNT(bl.Book_id) AS Issued_copies, 
	(SUM(bc.No_of_copies) - COUNT(bl.Book_id)) AS Available_copies 
FROM Book b 
JOIN Book_copies bc ON b.Book_id = bc.Book_id 
LEFT JOIN Book_lending bl ON b.Book_id = bl.Book_id 
GROUP BY b.Book_id, b.Title;

SELECT * FROM Available_books;
