Lab Experiment – GROUP BY, HAVING, ORDER BY and INDEXING
-- ======================================================================

-- Objective:
-- 1. To understand and apply the SQL GROUP BY clause to group rows based on column values and perform aggregate operations.
-- 2. To explore the HAVING clause for filtering grouped data post aggregation.
-- 3. To use the ORDER BY clause to sort query results in ascending or descending order.
-- 4. To implement Indexing in SQL for improving query performance.

-- ======================================================================
-- Step 1: Create Database
DROP DATABASE IF EXISTS HospitalDB;
CREATE DATABASE HospitalDB;
USE HospitalDB;

-- ======================================================================
-- Step 2: Create Tables
-- Create the relational schema for Patients and Visits.

CREATE TABLE Patients (
    patient_id INT PRIMARY KEY AUTO_INCREMENT,
    patient_name VARCHAR(50),
    age INT,
    gender VARCHAR(10)
);

CREATE TABLE Visits (
    visit_id INT PRIMARY KEY AUTO_INCREMENT,
    patient_id INT,
    visit_date DATE,
    doctor_id INT,
    diagnosis VARCHAR(100),
    treatment_cost DECIMAL(10,2),
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id)
);

-- OUTPUT:
-- (After creating tables, run DESC Patients; and DESC Visits; to verify structure.)
-- WRITE YOUR OUTPUT BELOW
DESC Patients;
-- +-------------+-------------+------+-----+---------+----------------+
-- | Field       | Type        | Null | Key | Default | Extra          |
-- +-------------+-------------+------+-----+---------+----------------+
-- | patient_id  | int         | NO   | PRI | NULL    | auto_increment |
-- | patient_name| varchar(50) | YES  |     | NULL    |                |
-- | age         | int         | YES  |     | NULL    |                |
-- | gender      | varchar(10) | YES  |     | NULL    |                |
-- +-------------+-------------+------+-----+---------+----------------+

-- DESC Visits;
-- +---------------+---------------+------+-----+---------+----------------+
-- | Field         | Type          | Null | Key | Default | Extra          |
-- +---------------+---------------+------+-----+---------+----------------+
-- | visit_id      | int           | NO   | PRI | NULL    | auto_increment |
-- | patient_id    | int           | YES  | MUL | NULL    |                |
-- | visit_date    | date          | YES  |     | NULL    |                |
-- | doctor_id     | int           | YES  |     | NULL    |                |
-- | diagnosis     | varchar(100)  | YES  |     | NULL    |                |
-- | treatment_cost| decimal(10,2) | YES  |     | NULL    |                |
-- +---------------+---------------+------+-----+---------+----------------+



-- ======================================================================
-- Step 3: Insert Sample Data
-- Insert sample records into both tables.
-- Add at least 5 patients and 8–10 visit records with varying diagnoses and treatment costs.
-- WRITE YOUR QUERIES BELOW
INSERT INTO Patients (patient_name, age, gender) VALUES
('Ravi Kumar', 34, 'Male'),
('Priya Sharma', 28, 'Female'),
('Anil Mehta', 45, 'Male'),
('Neha Singh', 31, 'Female'),
('Rahul Verma', 52, 'Male');

INSERT INTO Visits (patient_id, visit_date, doctor_id, diagnosis, treatment_cost) VALUES
(1, '2025-01-10', 101, 'Fever', 150.00),
(2, '2025-01-12', 102, 'Cold', 100.00),
(3, '2025-02-05', 103, 'Diabetes', 500.00),
(1, '2025-02-14', 104, 'Cough', 200.00),
(4, '2025-03-10', 105, 'Fever', 180.00),
(5, '2025-03-15', 106, 'Heart Disease', 800.00),
(3, '2025-03-20', 107, 'Diabetes', 550.00),
(4, '2025-03-25', 108, 'Cold', 120.00),
(2, '2025-04-01', 109, 'Allergy', 300.00),
(5, '2025-04-07', 110, 'Heart Disease', 950.00);
SELECT * FROM Patients;
SELECT * FROM Visits;




-- OUTPUT:
-- (Run SELECT * FROM Patients; and SELECT * FROM Visits; to verify inserted data.)
-- WRITE YOUR OUTPUT BELOW
SELECT * FROM Patients;
-- 1	Ravi Kumar	34	Male
-- 2	Priya Sharma	28	Female
-- 3	Anil Mehta	45	Male
-- 4	Neha Singh	31	Female
-- 5	Rahul Verma	52	Male
-- 6	Ravi Kumar	34	Male
-- 7	Priya Sharma	28	Female
-- 8	Anil Mehta	45	Male
-- 9	Neha Singh	31	Female
-- 10	Rahul Verma	52	Male

SELECT * FROM Visits;
-- 11	1	2025-01-10	101	Fever	150.00
-- 12	2	2025-01-12	102	Cold	100.00
-- 13	3	2025-02-05	103	Diabetes	500.00
-- 14	1	2025-02-14	104	Cough	200.00
-- 15	4	2025-03-10	105	Fever	180.00
-- 16	5	2025-03-15	106	Heart Disease	800.00
-- 17	3	2025-03-20	107	Diabetes	550.00
-- 18	4	2025-03-25	108	Cold	120.00
-- 19	2	2025-04-01	109	Allergy	300.00
-- 20	5	2025-04-07	110	Heart Disease	950.00
					
			


-- ======================================================================
-- QUICK INTRODUCTION (for notes)
-- GROUP BY: Groups rows sharing a value and performs aggregate functions like SUM(), COUNT(), AVG().
-- HAVING: Filters grouped data after aggregation.
-- ORDER BY: Sorts query results (ASC by default, DESC for descending order).
-- INDEXING: Improves query performance by creating a quick lookup on key columns.

-- ======================================================================
-- STUDENT ACTIVITY TASKS
-- ======================================================================

-- Task 1: Grouping Data by Diagnosis
-- Group the data based on diagnosis and calculate the average treatment cost for each diagnosis.
-- WRITE YOUR QUERY BELOW
SELECT 
    diagnosis, 
    AVG(treatment_cost) AS avg_treatment_cost
FROM Visits
GROUP BY diagnosis;



-- OUTPUT:
-- WRITE YOUR OUTPUT BELOW
-- Fever	165.000000
-- Cold	110.000000
-- Diabetes	525.000000
-- Cough	200.000000
-- Heart Disease	875.000000
-- Allergy	300.000000


-- ======================================================================
-- Task 2: Filtering with HAVING Clause
-- Filter the grouped data to show only diagnoses where the average treatment cost is greater than 200.
-- WRITE YOUR QUERY BELOW
SELECT 
    diagnosis, 
    AVG(treatment_cost) AS avg_treatment_cost
FROM Visits
GROUP BY diagnosis
HAVING AVG(treatment_cost) > 200;



-- OUTPUT:
-- WRITE YOUR OUTPUT BELOW
-- Diabetes	525.000000
-- Heart Disease	875.000000
-- Allergy	300.000000


-- ======================================================================
-- Task 3: Sorting the Results
-- Sort the results from Task 1 in descending order of average treatment cost.
-- WRITE YOUR QUERY BELOW
SELECT 
    diagnosis, 
    AVG(treatment_cost) AS avg_treatment_cost
FROM Visits
GROUP BY diagnosis
ORDER BY avg_treatment_cost DESC;



-- OUTPUT:
-- WRITE YOUR OUTPUT BELOW
-- Heart Disease	875.000000
-- Diabetes	525.000000
-- Allergy	300.000000
-- Cough	200.000000
-- Fever	165.000000
-- Cold	110.000000


-- ======================================================================
-- Task 4: Optimizing with Indexes
-- Create an index on the patient_id column in the Visits table to improve performance.
-- Then run a query that retrieves all visits for a particular patient.
-- WRITE YOUR QUERIES BELOW
CREATE INDEX idx_patient_id ON Visits(patient_id);
SHOW INDEX FROM Visits;



-- OUTPUT:
-- (Verify index creation using SHOW INDEX FROM Visits;)
-- WRITE YOUR OUTPUT BELOW
-- visits	0	PRIMARY	1	visit_id	A	0				BTREE			YES	
-- visits	1	idx_patient_id	1	patient_id	A	5			YES	BTREE			YES	


-- ======================================================================
-- END OF EXPERIMENT
-- ======================================================================