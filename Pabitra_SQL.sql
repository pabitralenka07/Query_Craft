CREATE DATABASE sql_lab;
USE sql_lab;

CREATE TABLE Student (
    student_id INT PRIMARY KEY,
    name VARCHAR(50),
    email VARCHAR(100) UNIQUE,
    phone_number VARCHAR(15),
    address VARCHAR(100)
);

INSERT INTO Student VALUES
(1, 'Rahul Sharma', 'rahul@gmail.com', '9876543210', 'Delhi'),
(2, 'Priya Das', 'priya@gmail.com', '9876543211', 'Kolkata'),
(3, 'Amit Kumar', 'amit@gmail.com', '9876543212', 'Patna'),
(4, 'Sneha Patel', 'sneha@gmail.com', '9876543213', 'Ahmedabad'),
(5, 'Rohan Singh', 'rohan@gmail.com', '9876543214', 'Lucknow'),
(6, 'Anjali Gupta', 'anjali@gmail.com', '9876543215', 'Mumbai'),
(7, 'Vikram Rao', 'vikram@gmail.com', '9876543216', 'Hyderabad'),
(8, 'Pooja Mishra', 'pooja@gmail.com', '9876543217', 'Bhubaneswar'),
(9, 'Arjun Mehta', 'arjun@gmail.com', '9876543218', 'Jaipur'),
(10, 'Neha Verma', 'neha@gmail.com', '9876543219', 'Chandigarh');

SELECT * FROM Student;

CREATE TABLE Course (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(50),
    credit INT
);

INSERT INTO Course VALUES
(101, 'Database Management System', 4),
(102, 'Computer Networks', 3),
(103, 'Operating System', 4),
(104, 'Data Structures', 3),
(105, 'Cloud Computing', 3);

SELECT * FROM Course;


CREATE TABLE Enrollment (
    student_id INT,
    course_id INT,
    enrollment_date DATE,
    PRIMARY KEY (student_id, course_id),
    FOREIGN KEY (student_id) REFERENCES Student(student_id),
    FOREIGN KEY (course_id) REFERENCES Course(course_id)
);

INSERT INTO Enrollment VALUES
(1,101,'2026-01-10'),
(2,102,'2026-01-11'),
(3,103,'2026-01-12'),
(4,104,'2026-01-13'),
(5,105,'2026-01-14'),
(6,101,'2026-01-15'),
(7,102,'2026-01-16'),
(8,103,'2026-01-17'),
(9,104,'2026-01-18'),
(10,105,'2026-01-19');

SELECT * FROM Enrollment;

SELECT student_id, course_id
FROM Enrollment;

SELECT COUNT(*) AS total_students
FROM Student;

ALTER TABLE Student
ADD marks INT;

UPDATE Student SET marks = 85 WHERE student_id = 1;
UPDATE Student SET marks = 78 WHERE student_id = 2;
UPDATE Student SET marks = 90 WHERE student_id = 3;
UPDATE Student SET marks = 88 WHERE student_id = 4;
UPDATE Student SET marks = 76 WHERE student_id = 5;
UPDATE Student SET marks = 82 WHERE student_id = 6;
UPDATE Student SET marks = 91 WHERE student_id = 7;
UPDATE Student SET marks = 74 WHERE student_id = 8;
UPDATE Student SET marks = 86 WHERE student_id = 9;
UPDATE Student SET marks = 80 WHERE student_id = 10;

SELECT * FROM Student;

SELECT student_id, name, marks
FROM Student
WHERE marks > 80;

SELECT name, address
FROM Student
WHERE address IN (
    SELECT address
    FROM Student
    GROUP BY address
    HAVING COUNT(*) > 1
);

SELECT student_id, name, marks
FROM Student
WHERE marks BETWEEN 75 AND 85;

SELECT name
FROM Student
WHERE name LIKE 'P%';

SELECT DISTINCT course_id
FROM Enrollment;

SELECT student_id, name, marks
FROM Student
ORDER BY marks DESC;

SELECT AVG(marks) AS average_marks
FROM Student;

CREATE TABLE Department (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(50),
    hod_name VARCHAR(50),
    office_location VARCHAR(100)
);

INSERT INTO Department VALUES
(1, 'Computer Science', 'Dr. Sahu', 'Block A'),
(2, 'Mechanical', 'Dr. jena', 'Block B'),
(3, 'Electrical', 'Dr. Rao', 'Block C'),
(4, 'Civil', 'Dr. Singh', 'Block D'),
(5, 'Electronics', 'Dr. Das', 'Block E');

SELECT * FROM Department;
