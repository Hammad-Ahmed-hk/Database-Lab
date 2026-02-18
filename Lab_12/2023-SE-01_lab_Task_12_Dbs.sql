-- Task 01: Database and Table Setup
CREATE DATABASE Hammad_Ahmed_Lab_Task_12;
GO

USE Hammad_Ahmed_Lab_Task_12;
GO

-- Create Students table
CREATE TABLE Students (
    StudentID INT PRIMARY KEY,
    FullName VARCHAR(100) NOT NULL,
    Program VARCHAR(50),
    AdmissionYear INT,
    CGPA DECIMAL(3,2)
);
GO

-- Insert sample records
INSERT INTO Students (StudentID, FullName, Program, AdmissionYear, CGPA) VALUES
(1, 'Hammad Ahmed', 'BSSE', 2020, 3.45),
(2, 'Zain Malik', 'BSSE', 2019, 3.80),
(3, 'Bushra bibi', 'BSCS', 2021, 2.95),
(4, 'Asim Chaudary', 'BSIT', 2020, 3.20),
(5, 'Hania Kanwa', 'BSSE', 2018, 3.60),
(6, 'Syeda Anab', 'BSCS', 2019, 3.10);
GO

-- View inserted records
SELECT * FROM Students;
GO


-- Task 02: Years Since Admission (direct calculation, no parameters)
SELECT FullName, AdmissionYear,
       YEAR(GETDATE()) - AdmissionYear AS Years_Since_Admission
FROM Students;
GO


-- Example 1: Using direct values
SELECT CASE 
           WHEN (90 + 85 + 80) / 3.0 >= 85 THEN 'A'
           WHEN (90 + 85 + 80) / 3.0 >= 70 THEN 'B'
           WHEN (90 + 85 + 80) / 3.0 >= 50 THEN 'C'
           ELSE 'F'
       END AS Grade1;
GO

-- Example 2: Using direct values
SELECT CASE 
           WHEN (45 + 55 + 60) / 3.0 >= 85 THEN 'A'
           WHEN (45 + 55 + 60) / 3.0 >= 70 THEN 'B'
           WHEN (45 + 55 + 60) / 3.0 >= 50 THEN 'C'
           ELSE 'F'
       END AS Grade2;
GO



-- Task 04: Get Students by Program and CGPA (direct query)
SELECT * FROM Students
WHERE Program = 'BSCS' AND CGPA > 3.0;

SELECT * FROM Students
WHERE Program = 'BSSE' AND CGPA > 3.5;
GO


-- Task 05: Insert new student and retrieve records
INSERT INTO Students (StudentID, FullName, Program, AdmissionYear, CGPA)
VALUES (7, 'New Student', 'BSIT', 2022, 3.50);

-- Get all students
SELECT * FROM Students;

-- Get only BSSE students
SELECT * FROM Students WHERE Program = 'BSSE';
GO
