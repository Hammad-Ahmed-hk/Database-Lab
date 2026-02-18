CREATE DATABASE Hammad_Ahmed_lab_task_07;
USE Hammad_Ahmed_lab_task_07;
GO

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
DROP TABLE PRODUCTS;
CREATE TABLE PRODUCTS (
    Product_ID VARCHAR(5) PRIMARY KEY NOT NULL,
    Name VARCHAR(50) NOT NULL,
    Category VARCHAR(20),
    Price NUMERIC(8,2),   -- ✅ Increased from (6,2) to (8,2)
    Stock NUMERIC(5),
    Supplier VARCHAR(50)
);

DELETE FROM CUSTOMERS; -- Be careful! This removes all existing records.

-- Then insert again:
INSERT INTO CUSTOMERS (Cust_ID, Name, City, Email, Phone, Status)
VALUES 
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


SELECT c.Name, o.Order_ID, o.Total_Amount
FROM CUSTOMERS c
INNER JOIN ORDERS o ON c.Cust_ID = o.Cust_ID;
SELECT c.Name, o.Order_ID, o.Total_Amount
FROM CUSTOMERS c
LEFT JOIN ORDERS o ON c.Cust_ID = o.Cust_ID;
SELECT c.Name, o.Order_ID
FROM CUSTOMERS c
RIGHT JOIN ORDERS o ON c.Cust_ID = o.Cust_ID;

SELECT c.Name, o.Order_ID
FROM CUSTOMERS c
FULL OUTER JOIN ORDERS o ON c.Cust_ID = o.Cust_ID;

SELECT c.Name, o.Order_ID, o.Remarks
FROM CUSTOMERS c
JOIN ORDERS o ON c.Cust_ID = o.Cust_ID
WHERE o.Remarks IS NOT NULL;


--TASK 4



CREATE TABLE ORDER_DETAILS (
    Order_ID VARCHAR(6),
    Product_ID VARCHAR(5),
    Quantity INT,
    PRIMARY KEY (Order_ID, Product_ID),
    FOREIGN KEY (Order_ID) REFERENCES ORDERS(Order_ID),
    FOREIGN KEY (Product_ID) REFERENCES PRODUCTS(Product_ID)
);

SELECT 
    C.Name AS Customer_Name,
    P.Name AS Product_Name,
    OD.Quantity
FROM 
    CUSTOMERS C
JOIN 
    ORDERS O ON C.Cust_ID = O.Cust_ID
JOIN 
    ORDER_DETAILS OD ON O.Order_ID = OD.Order_ID
JOIN 
    PRODUCTS P ON OD.Product_ID = P.Product_ID;







	SELECT c.Name, o.Total_Amount
FROM CUSTOMERS c
JOIN ORDERS o ON c.Cust_ID = o.Cust_ID
WHERE c.City = 'Karachi' AND o.Total_Amount > 2000;

SELECT c.City, COUNT(DISTINCT c.Cust_ID) AS Total_Customers
FROM CUSTOMERS c
JOIN ORDERS o ON c.Cust_ID = o.Cust_ID
GROUP BY c.City;


SELECT c.Name, AVG(o.Total_Amount) AS Avg_Amount
FROM CUSTOMERS c
JOIN ORDERS o ON c.Cust_ID = o.Cust_ID
GROUP BY c.Name;