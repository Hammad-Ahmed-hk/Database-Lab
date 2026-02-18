
CREATE DATABASE Hammad_Ahmed_lab_task_06;
s

DELETE FROM PUBLISHERS;

INSERT INTO PUBLISHERS (P_ID, Name, State, Address, Contact, Email) 
VALUES 
('PUB2', 'Sunshine Publishers Ltd.', 'New Jersey', '45 Second St, Newark', '6548909', NULL),
('PUB3', 'Bright Publications', 'Hawaii', '123 Main St, Honolulu', '7678985', 'bright@bp.com'),
('PUB4', 'Paramount Publishing House', 'New York', '789 Oak St, New York', '9254834', 'param_house@param.com'),
('PUB5', 'Wesley Publications', 'Nevada', '456 First St, Las Vegas', '5683452', NULL);

-- Ensure required Publishers exist (Only insert if they don’t exist)
IF NOT EXISTS (SELECT * FROM PUBLISHERS WHERE P_ID = 'PUB1')
INSERT INTO PUBLISHERS (P_ID, Name, State, Address, Email, Contact) 
VALUES ('PUB1', 'Hills Publications', 'Georgia', '12 Park St, Atlanta', 'h_pub@hills.com', '7134019');

UPDATE PUBLISHERS SET Contact = '9256774' WHERE Name = 'Wesley Publications';
-- Drop and recreate BOOKS table
DROP TABLE IF EXISTS BOOKS;
Drop TABLE BOOKS;
CREATE TABLE BOOKS (
    ISBN VARCHAR(15) PRIMARY KEY,
    Title VARCHAR(50) NOT NULL,
    Genre VARCHAR(20),
    Pages NUMERIC(4),
    Year_Published NUMERIC(4),
    Release_Year NUMERIC(4),
    Cost NUMERIC(6,2),
    Publisher_ID VARCHAR(4),
    FOREIGN KEY (Publisher_ID) REFERENCES PUBLISHERS(P_ID)
);

-- Insert records into BOOKS



IF NOT EXISTS (SELECT * FROM PUBLISHERS WHERE P_ID = 'PUB1')
INSERT INTO PUBLISHERS (P_ID, Name, State, Address, Email, Contact)
VALUES ('PUB1', 'Hills Publications', 'Georgia', '12 Park St, Atlanta', 'h_pub@hills.com', '7134019');

IF NOT EXISTS (SELECT * FROM PUBLISHERS WHERE P_ID = 'PUB2')
INSERT INTO PUBLISHERS (P_ID, Name, State, Address, Email, Contact)
VALUES ('PUB2', 'Sunshine Publishers Ltd.', 'New Jersey', '45 Second St, Newark', NULL, '6548909');

IF NOT EXISTS (SELECT * FROM PUBLISHERS WHERE P_ID = 'PUB3')
INSERT INTO PUBLISHERS (P_ID, Name, State, Address, Email, Contact)
VALUES ('PUB3', 'Bright Publications', 'Hawaii', '123 Main St, Honolulu', 'bright@bp.com', '7678985');

IF NOT EXISTS (SELECT * FROM PUBLISHERS WHERE P_ID = 'PUB4')
INSERT INTO PUBLISHERS (P_ID, Name, State, Address, Email, Contact)
VALUES ('PUB4', 'Paramount Publishing House', 'New York', '789 Oak St, New York', 'param_house@param.com', '9254834');
-- [3] Insert records into BOOKS
INSERT INTO BOOKS (ISBN, Title, Genre, Pages, Year_Published, Release_Year, Cost, Publisher_ID) VALUES
('001-354921-1', 'Ransack', 'Fiction', 200, 2005, 2006, 22.00, 'PUB1'),
('001-987650-5', 'Differential Calculus', 'Academic', 450, 2003, 2003, 30.00, 'PUB1'),
('001-987760-9', 'C++', 'Academic', 800, 2004, 2005, 40.00, 'PUB1'),
('002-678880-2', 'Call Away', 'Fiction', 200, 2001, 2002, 22.00, 'PUB2'),
('002-678980-4', 'Database Systems', 'Academic', 800, 2004, 2006, 40.00, 'PUB2'),
('003-456433-6', 'German Language Basics', 'Language', 200, 2003, 2004, 22.00, 'PUB4'),
('003-456533-8', 'French Language Guide', 'Language', 500, 2005, 2006, 32.00, 'PUB4'),
('004-765359-3', 'Coordinate Geometry', 'Academic', 650, 2006, 2006, 35.00, 'PUB3'),
('004-765409-5', 'UNIX Essentials', 'Academic', 550, 2006, 2007, 26.00, 'PUB3');
-- Perform queries
SELECT * FROM BOOKS;
UPDATE BOOKS SET Genre = 'Language' WHERE Title = 'C++';
SELECT ISBN, Title FROM BOOKS WHERE Genre = 'Language';
SELECT * FROM BOOKS WHERE Release_Year = 2006;
SELECT Title FROM BOOKS WHERE Pages < 600;
SELECT DISTINCT Genre FROM BOOKS;
SELECT * FROM BOOKS WHERE Genre = 'Academic' AND Cost >= 35;
DELETE FROM BOOKS WHERE Genre = 'Fiction';

-- Final select to verify results
SELECT * FROM BOOKS;
SELECT * FROM PUBLISHERS;
