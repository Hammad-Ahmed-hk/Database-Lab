

-- Task 01: Create Database
CREATE DATABASE hammad_ahmed_lab_task_08;
GO
USE hammad_ahmed_lab_task_08;
GO


-- Task 01: Table Setup (using Lab 07 structure)


CREATE TABLE CUSTOMERS (
    Cust_ID VARCHAR(5) PRIMARY KEY NOT NULL,
    Name VARCHAR(50) NOT NULL,
    City VARCHAR(30),
    Email VARCHAR(50) UNIQUE,
    Phone VARCHAR(15),
    Status VARCHAR(10)
);

CREATE TABLE ORDERS (
    Order_ID VARCHAR(6) PRIMARY KEY NOT NULL,
    Order_Date DATE NOT NULL,
    Cust_ID VARCHAR(5),
    Total_Amount NUMERIC(8,2),
    Status VARCHAR(15),
    Remarks VARCHAR(50),
    FOREIGN KEY (Cust_ID) REFERENCES CUSTOMERS(Cust_ID)
);

CREATE TABLE PRODUCTS (
    Product_ID VARCHAR(5) PRIMARY KEY NOT NULL,
    Name VARCHAR(50) NOT NULL,
    Category VARCHAR(20),
    Price NUMERIC(8,2),
    Stock NUMERIC(5),
    Supplier VARCHAR(50)
);

-- Insert sample data
INSERT INTO CUSTOMERS (Cust_ID, Name, City, Email, Phone, Status) VALUES
('C001', 'Sarah Khan', 'Lahore', 'sarah@xyz.com', '0345123456', 'Active'),
('C002', 'Ali Raza', 'Karachi', 'ali@abc.com', '0322123456', 'Active'),
('C003', 'Farah Malik', 'Islamabad', 'farah@abc.com', '0333456789', 'Inactive'),
('C004', 'Bilal Ahmed', 'Multan', 'bilal@xyz.com', '0300123456', 'Active'),
('C005', 'Amna Saeed', 'Peshawar', 'amna@xyz.com', '0311123456', 'Active'),
('C006', 'Zain Shah', 'Quetta', 'zain@xyz.com', '0344456789', 'Inactive');

INSERT INTO ORDERS VALUES
('O1001', '2024-05-01', 'C001', 1200.00, 'Delivered', 'On time'),
('O1002', '2024-05-03', 'C003', 3000.00, 'Cancelled', 'Customer request'),
('O1003', '2024-05-05', 'C002', 2500.00, 'Delivered', NULL),
('O1004', '2024-05-06', 'C005', 1750.00, 'Processing', 'Urgent delivery'),
('O1005', '2024-05-10', 'C001', 4500.00, 'Delivered', 'Gift included'),
('O1006', '2024-05-12', 'C004', 800.00, 'Processing', NULL);

INSERT INTO PRODUCTS VALUES
('P101', 'HP Laptop', 'Electronics', 85000.00, 15, 'HP Official'),
('P102', 'USB Cable', 'Accessories', 500.00, 150, 'Access Corp'),
('P103', 'Samsung Galaxy', 'Electronics', 95000.00, 10, 'Samsung Pvt Ltd'),
('P104', 'Notebook A5', 'Stationery', 100.00, 500, 'Papers Co.'),
('P105', 'Flash Drive 64GB', 'Accessories', 1200.00, 100, 'Access Corp'),
('P106', 'Wireless Mouse', 'Accessories', 900.00, 200, 'Logitech Distributors');

-- Task 02: Aggregate Functions


-- 1. Total number of customers
SELECT COUNT(*) AS Total_Customers
FROM CUSTOMERS;

-- 2. Count total orders
SELECT COUNT(*) AS Total_Orders
FROM ORDERS;

-- 3. Average order amount
SELECT AVG(Total_Amount) AS Average_Order_Amount
FROM ORDERS;

-- 4. Maximum & Minimum order amount
SELECT MAX(Total_Amount) AS Max_Order, MIN(Total_Amount) AS Min_Order
FROM ORDERS;

-- 5. Products with stock > 100
SELECT COUNT(*) AS Products_In_Stock
FROM PRODUCTS
WHERE Stock > 100;


-- Task 03: GROUP BY


-- 1. Total order amount per customer
SELECT Cust_ID, SUM(Total_Amount) AS Total_Order
FROM ORDERS
GROUP BY Cust_ID;

-- 2. Average price per category
SELECT Category, AVG(Price) AS Avg_Price
FROM PRODUCTS
GROUP BY Category;

-- 3. Count customers by status
SELECT Status, COUNT(*) AS Total_Customers
FROM CUSTOMERS
GROUP BY Status;

-- 4. Total stock per supplier
SELECT Supplier, SUM(Stock) AS Total_Stock
FROM PRODUCTS
GROUP BY Supplier;

-- =============================================
-- Task 04: HAVING Clause
-- =============================================

-- 1. Customers with more than one order
SELECT Cust_ID, COUNT(Order_ID) AS Order_Count
FROM ORDERS
GROUP BY Cust_ID
HAVING COUNT(Order_ID) > 1;

-- 2. Suppliers with stock > 200
SELECT Supplier, SUM(Stock) AS Total_Stock
FROM PRODUCTS
GROUP BY Supplier
HAVING SUM(Stock) > 200;

-- 3. Cities with more than one active customer
SELECT City, COUNT(Cust_ID) AS Active_Customers
FROM CUSTOMERS
WHERE Status = 'Active'
GROUP BY City
HAVING COUNT(Cust_ID) > 1;

-- 4. Categories with average price above 1000
SELECT Category, AVG(Price) AS Avg_Price
FROM PRODUCTS
GROUP BY Category
HAVING AVG(Price) > 1000;