-- 1. Create Database
CREATE DATABASE Hammad_Ahmed_Lab_Task_11;
GO
-- 2. Use the database
USE Hammad_Ahmed_Lab_Task_11;
GO

-- 3. Create DEPARTMENTS table
CREATE TABLE DEPARTMENTS (
    Dept_ID INT PRIMARY KEY,
    Dept_Name VARCHAR(50) NOT NULL,
    Location VARCHAR(50) NOT NULL
);

-- 4. Create EMPLOYEES table
CREATE TABLE EMPLOYEES (
    Emp_ID INT PRIMARY KEY,
    Name VARCHAR(50) NOT NULL,
    Department INT,
    Salary DECIMAL(10,2) CHECK (Salary > 0),
    Status VARCHAR(10) CHECK (Status IN ('Active', 'Inactive')),
    CONSTRAINT FK_Dept FOREIGN KEY (Department) REFERENCES DEPARTMENTS(Dept_ID)
);

-- 5. Insert sample data into DEPARTMENTS
INSERT INTO DEPARTMENTS (Dept_ID, Dept_Name, Location) VALUES
(1, 'IT', 'Muzaffarabad'),
(2, 'HR', 'Islamabad'),
(3, 'Finance', 'Lahore'),
(4, 'Marketing', 'Karachi'),
(5, 'Research', 'Peshawar'),
(6, 'Operations', 'Quetta');

-- 6. Insert sample data into EMPLOYEES
INSERT INTO EMPLOYEES (Emp_ID, Name, Department, Salary, Status) VALUES
(101, 'Hammad Ahmed', 1, 65000, 'Active'),
(102, 'Haider Zaman', 2, 50000, 'Inactive'),
(103, 'Asif FATA', 3, 80000, 'Active'),
(104, 'Atif Iqbal', 4, 55000, 'Active'),
(105, 'Bilal Hussain', 1, 70000, 'Inactive'),
(106, 'Ayesha Noor', 5, 75000, 'Active'),
(107, 'Fahad Malik', 6, 60000, 'Active');

-- 7. View all records
SELECT * FROM DEPARTMENTS;
SELECT * FROM EMPLOYEES;

-- 8. Create views
CREATE VIEW vw_active_employees AS
SELECT Emp_ID, Name, Department, Salary
FROM EMPLOYEES
WHERE Status = 'Active';

CREATE VIEW vw_emp_details AS
SELECT E.Emp_ID, E.Name, D.Dept_Name, D.Location, E.Salary, E.Status
FROM EMPLOYEES E
JOIN DEPARTMENTS D ON E.Department = D.Dept_ID;

-- 9. Queries on views
SELECT Name, Salary
FROM vw_emp_details
WHERE Dept_Name = 'IT';

SELECT Dept_Name, AVG(Salary) AS Avg_Salary
FROM vw_emp_details
GROUP BY Dept_Name;

SELECT SUM(Salary) AS Total_Active_Salary
FROM vw_active_employees;

-- 10. Update (should be done on base table, not view)
UPDATE EMPLOYEES
SET Salary = 80000
WHERE Name = 'Hammad Ahmed';

-- 11. Create Index
CREATE INDEX idx_department ON EMPLOYEES(Department);

-- 12. Delete (again, safer on base table)
DELETE FROM EMPLOYEES
WHERE Name = 'Hina Iqbal';

-- 13. Drop and recreate view (if needed)
DROP VIEW vw_emp_details;
GO

CREATE VIEW vw_emp_details AS
SELECT E.Name, D.Dept_Name, D.Location
FROM EMPLOYEES E
JOIN DEPARTMENTS D ON E.Department = D.Dept_ID;
