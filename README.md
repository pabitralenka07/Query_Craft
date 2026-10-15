# ⚡ Query--Craft

<div align="center">

![SQL](https://img.shields.io/badge/Language-SQL%20%7C%20MySQL%208.0+-00758F?style=for-the-badge&logo=mysql&logoColor=white)
![Status](https://img.shields.io/badge/Status-Completed-success?style=for-the-badge)
![License](https://img.shields.io/badge/License-MIT-blue?style=for-the-badge)
![Maintenance](https://img.shields.io/badge/Maintained%3F-Yes-orange?style=for-the-badge)
![Database](https://img.shields.io/badge/RDBMS-Relational%20Databases-4479A1?style=for-the-badge&logo=databricks&logoColor=white)

**A Comprehensive, Production-Grade Laboratory Suite & Reference Handbook for Relational Database Management Systems (RDBMS) & MySQL Mastery.**

[Explore Modules](#-laboratory-experiments--modules) • [Key Concepts](#-core-database-concepts-covered) • [Quickstart Guide](#-quickstart--execution-guide) • [Query Showcase](#-sample-query-highlights) • [Author](#-author)

---

</div>

## 📌 Overview

**Query--Craft** is a curated, hands-on repository of SQL scripts, real-world schemas, and advanced database solutions. Spanning fundamental Data Definition Language (DDL) and Data Manipulation Language (DML) constructs to enterprise database patterns—such as **range table partitioning**, **row-level triggers**, **parameterized stored procedures**, **deterministic user-defined functions (UDFs)**, **cursor-based iterative algorithms**, and **ACID transactional safeguards**—this repository serves as both an academic lab portfolio and a practical cheat sheet for database developers.

---

## 🗂️ Repository Architecture

```text
Query--Craft/
├── Expt_01.sql        # Experiment 1: Library Management System & Range Partitioning
├── Expt_02.sql        # Experiment 2: College Academic Database & IA Marks Computation
├── Expt_03.sql        # Experiment 3: Order Processing, Sales Analytics & Set Operations
├── Expt_04.sql        # Experiment 4: Hospital System DCL (Grant/Revoke) & TCL (Savepoints)
├── Expt_05.sql        # Experiment 5: Relational Joins (Inner, Left, Right) & Nested Queries
├── Expt_06.sql        # Experiment 6: Election Constituency Database, Stored Procedures & Triggers
├── Expt_07.sql        # Experiment 7: Flight & Aircraft Operations with Complex Correlated Queries
├── Expt_08.sql        # Experiment 8: Sequential Row Processing via MySQL Cursors
├── exp9.sql           # Experiment 9: Result Classification via Cursor Procedures & UDFs
├── exp10.sql          # Experiment 10: Dynamic Library Fine Calculator & Date Arithmetic
├── Pabitra_SQL.sql    # University Enrollment & Academic Schema with Filtering & Constraints
├── Prime_SQL.sql      # The Ultimate SQL Architecture Cheat Sheet (Joins, Indexing, Transactions)
├── Untitled.sql       # Consolidated Multi-Experiment End-to-End Test Suite
├── Untitled_opy.sql   # Idempotent Procedural Functions & Cursor Reference Implementation
├── .gitignore         # Workspace hygiene rules for Git
└── README.md          # Comprehensive documentation and project guide
```

---

## 🔬 Laboratory Experiments & Modules

### 📚 Detailed Experiment Catalog

| File | Domain / System | Primary Database Concepts | Key Highlights |
| :--- | :--- | :--- | :--- |
| **`Expt_01.sql`** | **Library Database** | DDL, Constraints, Cascade Actions, Range Partitioning, Views | Multi-table relational model (`Book`, `Publisher`, `Book_copies`, `Book_lending`), horizontal range partitioning by `Publishing_year`, dynamic view for book availability. |
| **`Expt_02.sql`** | **College Academic Database** | DDL, Relational Joins, Complex Updates, Math Operations, `CASE` Statements | Computation of Internal Assessment (`FinalIA`) by taking the best 2 out of 3 test scores: `((T1+T2+T3)-LEAST(T1,T2,T3))/2`; student classification into performance tiers (`Outstanding`, `Average`, `Weak`). |
| **`Expt_03.sql`** | **Order Processing & Sales** | Foreign Key Cascades, Aggregations, Subqueries, `UNION` Set Operations | Customer grading comparisons using nested subqueries (`Grade > AVG(Grade)`), identifying multi-customer salespeople with `HAVING`, salesmen status union query, `Top_Salesman_View`. |
| **`Expt_04.sql`** | **Hospital System (DCL & TCL)** | Data Control (`GRANT`, `REVOKE`), Transaction Controls (`SAVEPOINT`, `ROLLBACK`, `COMMIT`) | Fine-grained privilege allocation to database users (`dept_user`), user privilege flushing, atomic multi-step transactional rollback using named savepoints (`sp1`). |
| **`Expt_05.sql`** | **Joins & Nested Queries** | `INNER JOIN`, `LEFT JOIN`, `RIGHT JOIN`, Scalar Subqueries | Rigorous comparison between join varieties across `Employees` and `Departments` tables; subquery filtering employees earning above the company-wide average. |
| **`Expt_06.sql`** | **Election & Constituency** | Stored Procedures (`IN` params), Dynamic Triggers (`AFTER INSERT`) | Voter eligibility validation (age ≥ 18) via stored procedure `insert_voter`, parameterized reporting procedure `voters_count`, row-level trigger `voter_count_update` auto-incrementing voter tally in constituency table. |
| **`Expt_07.sql`** | **Flight & Aircraft Management** | Pattern Matching, Correlated Subqueries, `EXISTS`, Multi-Level Aggregations | Flight cruising range checks against airport route distances, `EXISTS` subquery across certified pilots, finding second-highest employee salary without `LIMIT`, identifying pilots certified on maximum aircraft. |
| **`Expt_08.sql`** | **Employee Payroll Cursor** | Stored Procedures, MySQL Cursor Lifecycle | Sequential row iteration with `DECLARE emp_cursor CURSOR FOR`, `DECLARE CONTINUE HANDLER FOR NOT FOUND`, structured `LOOP`, `FETCH`, and `LEAVE` logic. |
| **`exp9.sql`** | **Student Marks Classification** | Cursors, Procedural Branching, Deterministic Functions | Cursor procedure `proc_Grade` populating student grading categories (`Distinction`, `First Class`, `Fail`), standalone reusable deterministic function `get_grade(marks)`. |
| **`exp10.sql`** | **Library Fine System** | Date Arithmetic (`DATEDIFF`, `CURDATE()`, `INTERVAL`), Exception Handling | Automated fine calculation procedure based on overdue threshold days ($5/day for 15–30 days, $50/day for >30 days), automatic status transition to Returned (`'R'`), fine record logging. |

---

### 🌟 Master Reference Modules

* **`Prime_SQL.sql` (The Master SQL Handbook)**:
  * **Complete Joins Suite**: `INNER`, `LEFT`, `RIGHT`, `FULL OUTER` (via `UNION`), `CROSS`, `SELF`, `LEFT EXCLUSIVE`, and `RIGHT EXCLUSIVE`.
  * **Subquery Patterns**: Demonstrations in `WHERE`, `SELECT` (correlated scalar), and `FROM` (inline derived tables).
  * **B-Tree Indexing**: Single-column indexing (`CREATE INDEX id_branch`) and composite multi-column indexing (`CREATE INDEX id2 (branch, balance)`), index inspection with `SHOW INDEX`.
  * **Transactions & Financial Balances**: Multi-account funds transfer simulation with savepoint rollbacks.
  * **Procedures with OUT Parameters**: Returning database state directly into MySQL session variables (`CALL check_balance(1, @balance)`).

* **`Pabitra_SQL.sql` (University Enrollment Architecture)**:
  * Full academic schema modeling students, courses, departmental heads, and enrollment records.
  * Column additions via `ALTER TABLE`, address duplicate identification with `GROUP BY ... HAVING COUNT(*) > 1`, range searches with `BETWEEN`, and pattern lookups with `LIKE 'P%'`.

* **`Untitled.sql` & `Untitled_opy.sql`**:
  * Idempotent, end-to-end execution scripts with `DROP DATABASE IF EXISTS` and clean setup statements ideal for continuous integration, grading, or local test suites.

---

## 🧠 Core Database Concepts Covered

<details>
<summary><b>1. Data Definition & Integrity Constraints (DDL)</b></summary>

* Primary Keys, Composite Primary Keys, and Unique Constraints.
* Foreign Keys with referential integrity enforcement: `ON DELETE CASCADE`.
* Dynamic schema evolution: `ALTER TABLE ADD COLUMN`.
* Physical table data partitioning: `PARTITION BY RANGE (column)`.
</details>

<details>
<summary><b>2. Data Manipulation & Complex Retrieval (DML)</b></summary>

* Set Operations: `UNION` and `UNION ALL`.
* Nested Subqueries: Single-row, multi-row (`IN`, `NOT IN`), and correlated (`EXISTS`).
* Aggregation & Windowing logic: `COUNT`, `SUM`, `AVG`, `MAX`, `MIN` coupled with `GROUP BY` and `HAVING`.
* Conditional Value Computations: `CASE WHEN ... THEN ... ELSE ... END`.
</details>

<details>
<summary><b>3. Procedural Programming (PL/SQL & MySQL Routines)</b></summary>

* **Stored Procedures**: Encapsulating complex business logic, utilizing `IN` and `OUT` parameters.
* **Deterministic Functions**: Reusable scalar logic with `RETURNS <type> DETERMINISTIC`.
* **Database Triggers**: Row-level automation (`AFTER INSERT ON table FOR EACH ROW`).
* **Cursors**: Declarative pointers for sequentially traversing recordsets with explicit exception handlers (`CONTINUE HANDLER FOR NOT FOUND`).
</details>

<details>
<summary><b>4. Security, Administration & Transactions (DCL & TCL)</b></summary>

* User Access Management: `GRANT` and `REVOKE` privileges on target objects.
* Security Cache Management: `FLUSH PRIVILEGES`.
* Transaction Isolation & Atomicity: `START TRANSACTION`, `SAVEPOINT <name>`, `ROLLBACK TO <name>`, and `COMMIT`.
</details>

<details>
<summary><b>5. Database Performance Optimization</b></summary>

* **Views**: Abstracting complex joins and calculated metrics into virtual representations (`Available_books`, `Top_Salesman_View`, `Test1_View`).
* **Indexes**: Reducing table scans through single-column and composite multi-column indexing.
* **Range Partitioning**: Segmenting physical storage to speed up temporal query execution.
</details>

---

## 💻 Sample Query Highlights

### 1. Computing Best 2 of 3 Internal Assessment Marks
```sql
UPDATE IAMARKS
SET FinalIA = (
    (Test1 + Test2 + Test3) - LEAST(Test1, Test2, Test3)
) / 2
WHERE REGNO IS NOT NULL;
```

### 2. Automated Voter Count Trigger
```sql
DELIMITER $$
CREATE TRIGGER voter_count_update
AFTER INSERT ON VOTER
FOR EACH ROW
BEGIN
    UPDATE CONSTITUENCY
    SET no_of_voters = no_of_voters + 1
    WHERE cons_id = NEW.cons_id;
END $$
DELIMITER ;
```

### 3. Range-Based Table Partitioning
```sql
CREATE TABLE Book_partition (
    Book_id INT,
    Title VARCHAR(100),
    Publisher_name VARCHAR(50),
    Publishing_year INT
)
PARTITION BY RANGE (Publishing_year) (
    PARTITION P1 VALUES LESS THAN (2000),
    PARTITION P2 VALUES LESS THAN (2010),
    PARTITION P3 VALUES LESS THAN (2020),
    PARTITION P4 VALUES LESS THAN MAXVALUE
);
```

### 4. Deterministic Grade Classifier Function
```sql
DELIMITER $$
CREATE FUNCTION get_grade(p_marks INT)
RETURNS VARCHAR(30) DETERMINISTIC
BEGIN
    DECLARE v_class VARCHAR(30);
    IF p_marks BETWEEN 990 AND 1500 THEN SET v_class = 'Distinction';
    ELSEIF p_marks BETWEEN 900 AND 989 THEN SET v_class = 'First Class';
    ELSEIF p_marks BETWEEN 825 AND 899 THEN SET v_class = 'Higher Second Class';
    ELSE SET v_class = 'Fail';
    END IF;
    RETURN v_class;
END $$
DELIMITER ;
```

---

## 🚀 Quickstart & Execution Guide

### Prerequisites
* **MySQL Server** (Version 8.0 or later recommended)
* A graphical database client (e.g., **MySQL Workbench**, **DBeaver**, or **DataGrip**) or the standard **MySQL CLI**.

### Setup Instructions

1. **Clone the Repository**:
   ```bash
   git clone https://github.com/pabitralenka07/Query--Craft.git
   cd Query--Craft
   ```

2. **Run via MySQL Command Line**:
   ```bash
   # Log into MySQL
   mysql -u <username> -p

   # Execute any desired script
   source /path/to/Query--Craft/Expt_01.sql;
   ```

3. **Run via MySQL Workbench / GUI**:
   * Open MySQL Workbench and connect to your instance.
   * Go to `File` > `Open SQL Script...` (or press `Ctrl+O` / `Cmd+O`).
   * Select any `.sql` file from the repository and execute with the `⚡ Execute` button.

---

## 🛠️ Technology Stack

* **Dialect**: Standard ANSI SQL & MySQL 8.x Dialect
* **Engine**: InnoDB (Default for foreign key constraints and ACID compliance)
* **Environment**: Compatible with Linux, macOS, and Windows MySQL distributions

---

## 👤 Author

* **Pabitra Lenka**
  * GitHub: [@pabitralenka07](https://github.com/pabitralenka07)

---

## 📄 License

This repository is licensed under the [MIT License](LICENSE) — feel free to explore, study, adapt, and build upon these queries for educational and professional purposes.
