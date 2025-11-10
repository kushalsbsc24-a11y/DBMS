-- ======================================================================
-- Lab Experiment – Implementation of Procedures in SQL
-- ======================================================================

-- Objective:
-- 1. To understand and create stored procedures in MySQL.
-- 2. To implement procedures for performing INSERT, UPDATE, and DELETE operations.

-- ======================================================================
-- Step 1: Create Database
DROP DATABASE IF EXISTS CompanyDB;
CREATE DATABASE CompanyDB;
USE CompanyDB;

-- ======================================================================
-- Step 2: Create Table
CREATE TABLE Employees (
    EmpID INT PRIMARY KEY AUTO_INCREMENT,
    EmpName VARCHAR(50),
    Department VARCHAR(50),
    Salary DECIMAL(10,2)
);

-- OUTPUT: 10:06:34	CREATE TABLE Employees (     EmpID INT PRIMARY KEY AUTO_INCREMENT,     EmpName VARCHAR(50),     Department VARCHAR(50),     Salary DECIMAL(10,2) )	0 row(s) affected	0.047 sec

-- (Run DESC Employees; to verify structure)
DESC Employees;


-- WRITE YOUR OUTPUT BELOW
-- # Field, Type, Null, Key, Default, Extra
-- 'EmpID', 'int', 'NO', 'PRI', NULL, 'auto_increment'
-- 'EmpName', 'varchar(50)', 'YES', '', NULL, ''
-- 'Department', 'varchar(50)', 'YES', '', NULL, ''
-- 'Salary', 'decimal(10,2)', 'YES', '', NULL, ''



-- ======================================================================
-- Step 3: Insert Sample Data
INSERT INTO Employees (EmpName, Department, Salary) VALUES
('John', 'IT', 55000),
('Alice', 'HR', 48000),
('Bob', 'Finance', 60000);

-- OUTPUT: 10:07:22	INSERT INTO Employees (EmpName, Department, Salary) VALUES ('John', 'IT', 55000), ('Alice', 'HR', 48000), ('Bob', 'Finance', 60000)	3 row(s) affected Records: 3  Duplicates: 0  Warnings: 0	0.015 sec

-- (Run SELECT * FROM Employees; to verify data)
SELECT * FROM Employees;

-- WRITE YOUR OUTPUT BELOW
-- # EmpID, EmpName, Department, Salary
-- '1', 'John', 'IT', '55000.00'
-- '2', 'Alice', 'HR', '48000.00'
-- '3', 'Bob', 'Finance', '60000.00'




-- ======================================================================
-- Task 1: Create a Basic Procedure
-- Create a procedure named `DisplayEmployees` that retrieves all records from the Employees table.
-- WRITE YOUR PROCEDURE CREATION QUERY BELOW
DELIMITER $$

CREATE PROCEDURE DisplayEmployees()
BEGIN
    SELECT * FROM Employees;
END $$

DELIMITER ;


CALL DisplayEmployees();
-- OUTPUT:
-- # EmpID, EmpName, Department, Salary
-- '1', 'John', 'IT', '55000.00'
-- '2', 'Alice', 'HR', '48000.00'
-- '3', 'Bob', 'Finance', '60000.00'

-- WRITE YOUR OUTPUT BELOW



-- ======================================================================
-- Task 2: Procedure for INSERT Operation

-- Create a procedure named `AddEmployee` that inserts a new employee record.
-- Parameters: (p_name VARCHAR(50), p_dept VARCHAR(50), p_salary DECIMAL(10,2))
-- WRITE YOUR PROCEDURE CREATION QUERY BELOW

DELIMITER $$

CREATE PROCEDURE AddEmployee(
    IN p_name VARCHAR(50),
    IN p_dept VARCHAR(50),
    IN p_salary DECIMAL(10,2)
)
BEGIN
    INSERT INTO Employees (EmpName, Department, Salary)
    VALUES (p_name, p_dept, p_salary);
END $$

DELIMITER ;



CALL AddEmployee('David', 'Marketing', 52000);
-- OUTPUT: 10:09:17	CALL AddEmployee('David', 'Marketing', 52000)	1 row(s) affected	0.000 sec

-- (Run SELECT * FROM Employees; to verify insertion)

CALL AddEmployee('David', 'Marketing', 52000);
SELECT * FROM Employees;

-- WRITE YOUR OUTPUT BELOW
-- # EmpID, EmpName, Department, Salary
-- '1', 'John', 'IT', '55000.00'
-- '2', 'Alice', 'HR', '48000.00'
-- '3', 'Bob', 'Finance', '60000.00'
-- '4', 'David', 'Marketing', '52000.00'
-- '5', 'David', 'Marketing', '52000.00'



-- ======================================================================
-- Task 3: Procedure for UPDATE Operation
-- Create a procedure named `UpdateSalary` to update an employee’s salary based on EmpID.
-- Parameters: (p_empid INT, p_salary DECIMAL(10,2))
-- WRITE YOUR PROCEDURE CREATION QUERY BELOW

DELIMITER $$

CREATE PROCEDURE UpdateSalary(
    IN p_empid INT,
    IN p_salary DECIMAL(10,2)
)
BEGIN
    UPDATE Employees
    SET Salary = p_salary
    WHERE EmpID = p_empid;
END $$

DELIMITER ;


CALL UpdateSalary(2, 50000);
-- OUTPUT: 10:10:02	CALL UpdateSalary(2, 50000)	1 row(s) affected	0.000 sec

-- (Run SELECT * FROM Employees; to verify update)
CALL UpdateSalary(2, 50000);
SELECT * FROM Employees;

-- WRITE YOUR OUTPUT BELOW

-- # EmpID, EmpName, Department, Salary
-- '1', 'John', 'IT', '55000.00'
-- '2', 'Alice', 'HR', '50000.00'
-- '3', 'Bob', 'Finance', '60000.00'
-- '4', 'David', 'Marketing', '52000.00'
-- '5', 'David', 'Marketing', '52000.00'



-- ======================================================================
-- Task 4: Procedure for DELETE Operation
-- Create a procedure named `RemoveEmployee` to delete an employee record based on EmpID.
-- Parameters: (p_empid INT)
-- WRITE YOUR PROCEDURE CREATION QUERY BELOW

DELIMITER $$

CREATE PROCEDURE RemoveEmployee(
    IN p_empid INT
)
BEGIN
    DELETE FROM Employees
    WHERE EmpID = p_empid;
END $$

DELIMITER ;



CALL RemoveEmployee(3);
-- OUTPUT:  10:10:53	CALL RemoveEmployee(3)	1 row(s) affected	0.000 sec

-- (Run SELECT * FROM Employees; to verify deletion)

-- WRITE YOUR OUTPUT BELOW
CALL RemoveEmployee(3);
SELECT * FROM Employees;

-- output
-- 	EmpID	EmpName	Department	Salary
-- 	1	John	IT	55000.00
-- 	2	Alice	HR	50000.00
-- 	4	David	Marketing	52000.00
-- 	5	David	Marketing	52000.00
				


-- ======================================================================
-- END OF EXPERIMENT – Implementation of Procedures
-- ======================================================================