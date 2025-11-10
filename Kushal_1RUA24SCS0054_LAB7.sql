-- ======================================================================
-- Lab Experiment – Implementation of Triggers in SQL
-- ======================================================================

-- Objective:
-- 1. To understand and create triggers in MySQL.
-- 2. To implement BEFORE and AFTER triggers for INSERT, UPDATE, and DELETE operations.

-- ======================================================================
-- Step 1: Create Database
DROP DATABASE IF EXISTS SchoolDB;
CREATE DATABASE SchoolDB;
USE SchoolDB;

-- ======================================================================
-- Step 2: Create Tables
-- Create a Students table and a Logs table to record trigger actions.

CREATE TABLE Students (
    StudentID INT PRIMARY KEY AUTO_INCREMENT,
    StudentName VARCHAR(50),
    Age INT,
    Marks DECIMAL(5,2)
);

CREATE TABLE StudentLogs (
    LogID INT PRIMARY KEY AUTO_INCREMENT,
    ActionType VARCHAR(50),
    ActionDate DATETIME,
    Description VARCHAR(200)
);

-- OUTPUT:
-- (Run DESC Students; and DESC StudentLogs; to verify structure)
-- WRITE YOUR OUTPUT BELOW
DESC Students;
DESC StudentLogs;

-- output
-- # Field, Type, Null, Key, Default, Extra
-- 'LogID', 'int', 'NO', 'PRI', NULL, 'auto_increment'
-- 'ActionType', 'varchar(50)', 'YES', '', NULL, ''
-- 'ActionDate', 'datetime', 'YES', '', NULL, ''
-- 'Description', 'varchar(200)', 'YES', '', NULL, ''



-- ======================================================================
-- Task 1: BEFORE INSERT Trigger
-- Create a trigger to ensure that no student can be inserted with Marks greater than 100.
-- WRITE YOUR TRIGGER CREATION QUERY BELOW

DELIMITER $$

CREATE TRIGGER before_student_insert
BEFORE INSERT ON Students
FOR EACH ROW
BEGIN
    IF NEW.Marks > 100 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Marks cannot be greater than 100.';
    END IF;
END $$

DELIMITER ;


-- OUTPUT:
-- 09:58:45	CREATE TRIGGER before_student_insert BEFORE INSERT ON Students FOR EACH ROW BEGIN     IF NEW.Marks > 100 THEN         SIGNAL SQLSTATE '45000'         SET MESSAGE_TEXT = 'Marks cannot be greater than 100.';     END IF; END	0 row(s) affected	0.016 sec

-- (Try inserting a record with Marks > 100 to verify validation)
-- This should FAIL (Marks > 100)
INSERT INTO Students (StudentName, Age, Marks)
VALUES ('Abhi', 20, 105);

-- WRITE YOUR OUTPUT BELOW

-- 09:59:38	INSERT INTO Students (StudentName, Age, Marks) VALUES ('Abhi', 20, 105)	Error Code: 1644. Marks cannot be greater than 100.	0.000 sec




-- ======================================================================
-- Task 2: AFTER INSERT Trigger
-- Create a trigger that inserts a log entry into StudentLogs whenever a new student is added.
-- WRITE YOUR TRIGGER CREATION QUERY BELOW

DELIMITER $$

CREATE TRIGGER after_student_insert
AFTER INSERT ON Students
FOR EACH ROW
BEGIN
    INSERT INTO StudentLogs (ActionType, ActionDate, Description)
    VALUES (
        'INSERT',
        NOW(),
        CONCAT('New student added: ', NEW.StudentName, ', Marks: ', NEW.Marks)
    );
END $$

DELIMITER ;


-- OUTPUT: 10:00:15	CREATE TRIGGER after_student_insert AFTER INSERT ON Students FOR EACH ROW BEGIN     INSERT INTO StudentLogs (ActionType, ActionDate, Description)     VALUES (         'INSERT',         NOW(),         CONCAT('New student added: ', NEW.StudentName, ', Marks: ', NEW.Marks)     ); END	0 row(s) affected	0.000 sec

-- (Insert a valid record and check StudentLogs for entries)
INSERT INTO Students (StudentName, Age, Marks)
VALUES ('Abhi', 20, 95);

-- WRITE YOUR OUTPUT BELOW
-- 10:00:33	INSERT INTO Students (StudentName, Age, Marks) VALUES ('Abhi', 20, 95)	1 row(s) affected	0.015 sec


-- ======================================================================
-- Task 3: AFTER UPDATE Trigger
-- Create a trigger that logs any update made to a student’s marks.
-- WRITE YOUR TRIGGER CREATION QUERY BELOW

DELIMITER $$

CREATE TRIGGER after_student_update
AFTER UPDATE ON Students
FOR EACH ROW
BEGIN
    IF OLD.Marks <> NEW.Marks THEN
        INSERT INTO StudentLogs (ActionType, ActionDate, Description)
        VALUES (
            'UPDATE',
            NOW(),
            CONCAT('Marks updated for ', NEW.StudentName, 
                   ' from ', OLD.Marks, ' to ', NEW.Marks)
        );
    END IF;
END $$

DELIMITER ;


-- OUTPUT: 10:01:49	CREATE TRIGGER after_student_update AFTER UPDATE ON Students FOR EACH ROW BEGIN     IF OLD.Marks <> NEW.Marks THEN         INSERT INTO StudentLogs (ActionType, ActionDate, Description)         VALUES (             'UPDATE',             NOW(),             CONCAT('Marks updated for ', NEW.StudentName,                     ' from ', OLD.Marks, ' to ', NEW.Marks)         );     END IF; END	0 row(s) affected	0.000 sec

-- (Update marks of a student and verify the StudentLogs table)
-- Update Abhi's marks
UPDATE Students
SET Marks = 98
WHERE StudentName = 'Abhi';

SELECT * FROM StudentLogs;


-- WRITE YOUR OUTPUT BELOW
-- 10:02:20	UPDATE Students SET Marks = 98 WHERE StudentName = 'Abhi'	Error Code: 1175. You are using safe update mode and you tried to update a table without a WHERE that uses a KEY column.  To disable safe mode, toggle the option in Preferences -> SQL Editor and reconnect.	0.016 sec
-- # LogID, ActionType, ActionDate, Description
-- '1', 'INSERT', '2025-10-27 10:00:33', 'New student added: Abhi, Marks: 95.00'


-- ======================================================================
-- Task 4: AFTER DELETE Trigger
-- Create a trigger that logs when a student record is deleted.
-- WRITE YOUR TRIGGER CREATION QUERY BELOW
DELIMITER $$

CREATE TRIGGER after_student_delete
AFTER DELETE ON Students
FOR EACH ROW
BEGIN
    INSERT INTO StudentLogs (ActionType, ActionDate, Description)
    VALUES (
        'DELETE',
        NOW(),
        CONCAT('Student deleted: ', OLD.StudentName, ', Marks were: ', OLD.Marks)
    );
END $$

DELIMITER ;


-- OUTPUT: 10:04:02	CREATE TRIGGER after_student_delete AFTER DELETE ON Students FOR EACH ROW BEGIN     INSERT INTO StudentLogs (ActionType, ActionDate, Description)     VALUES (         'DELETE',         NOW(),         CONCAT('Student deleted: ', OLD.StudentName, ', Marks were: ', OLD.Marks)     ); END	0 row(s) affected	0.016 sec

-- (Delete a student and check StudentLogs for the corresponding entry)

DELETE FROM Students
WHERE StudentName = 'Abhi';
SELECT * FROM StudentLogs;

-- WRITE YOUR OUTPUT BELOW

-- # LogID, ActionType, ActionDate, Description
-- '1', 'INSERT', '2025-10-27 10:00:33', 'New student added: Abhi, Marks: 95.00'


-- ======================================================================
-- END OF EXPERIMENT – Implementation of Triggers
-- ======================================================================