CREATE DATABASE Election_Database;
USE Election_Database;


CREATE TABLE CONSTITUENCY (
    cons_id      INT PRIMARY KEY,
    csname       VARCHAR(50),
    csstate      VARCHAR(50),
    no_of_voters INT
);

CREATE TABLE PARTY (
    pid     INT PRIMARY KEY,
    pname   VARCHAR(50),
    psymbol VARCHAR(50)
);

CREATE TABLE CANDIDATES (
    cand_id  INT PRIMARY KEY,
    name     VARCHAR(50),
    age      INT,
    state    VARCHAR(50),
    phone_no VARCHAR(15),
    cons_id  INT
);

CREATE TABLE VOTER (
    vid     INT PRIMARY KEY,
    vname   VARCHAR(50),
    vage    INT,
    vaddr   VARCHAR(100),
    cons_id INT
);


INSERT INTO CONSTITUENCY VALUES
    (1, 'Bhubaneswar', 'Odisha',         20000),
    (2, 'Cuttack',     'Odisha',         15000),
    (3, 'Hyderabad',   'Telangana',      25000),
    (4, 'Vizag',       'Andhra Pradesh', 18000);

INSERT INTO PARTY VALUES
    (101, 'BJP',      'Lotus'),
    (102, 'Congress', 'Hand'),
    (103, 'BJD',      'Conch');

INSERT INTO CANDIDATES VALUES
    (1, 'Rahul',  45, 'Odisha',    '9876543210', 1),
    (2, 'Suresh', 50, 'Telangana', '9876543211', 3),
    (3, 'Ramesh', 55, 'Odisha',    '9876543212', 2),
    (4, 'Rahul',  45, 'Telangana', '9876543210', 3);

INSERT INTO VOTER VALUES
    (1, 'Anil',  22, 'Bhubaneswar', 1),
    (2, 'Sunil', 30, 'Cuttack',     2),
    (3, 'Kiran', 19, 'Hyderabad',   3);


SELECT name, COUNT(DISTINCT state) AS states_count
FROM CANDIDATES
GROUP BY name
HAVING COUNT(DISTINCT state) > 1;


SELECT csstate, COUNT(*) AS total_constituencies
FROM CONSTITUENCY
GROUP BY csstate
ORDER BY total_constituencies DESC
LIMIT 1;


DELIMITER $$
CREATE PROCEDURE insert_voter(
    IN id   INT,
    IN name VARCHAR(50),
    IN age  INT,
    IN addr VARCHAR(100),
    IN cid  INT
)
BEGIN
    IF age >= 18 THEN
        INSERT INTO VOTER VALUES (id, name, age, addr, cid);
    ELSE
        SELECT 'Not an eligible voter' AS Message;
    END IF;
END $$
DELIMITER ;


CALL insert_voter(4, 'Ravi', 20, 'Vizag', 4);
CALL insert_voter(5, 'Amit', 16, 'Bhubaneswar', 1);

DELIMITER $$
CREATE PROCEDURE voters_count(
    IN cname VARCHAR(50)
)
BEGIN
    SELECT csname, no_of_voters
    FROM CONSTITUENCY
    WHERE csname = cname;
END $$
DELIMITER ;

CALL voters_count('Bhubaneswar');


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


INSERT INTO VOTER VALUES (6, 'Mahesh', 25, 'Bhubaneswar', 1);

SELECT * FROM CONSTITUENCY;
