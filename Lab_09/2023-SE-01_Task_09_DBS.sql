-- Create Library Database
CREATE DATABASE Library_System;
GO
USE Library_System;
GO

-- Book Entity
CREATE TABLE Book (
    ISBN VARCHAR(20) PRIMARY KEY,
    Title VARCHAR(100) NOT NULL,
    Author VARCHAR(100),
    Category VARCHAR(50)
);

-- Member Entity
CREATE TABLE Member (
    Member_ID INT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Address VARCHAR(200),
    Phone VARCHAR(20)
);

-- Librarian Entity
CREATE TABLE Librarian (
    Emp_ID INT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Shift VARCHAR(50),
    Section VARCHAR(100)
);

-- Insert sample Books
INSERT INTO Book (ISBN, Title, Author, Category)
VALUES 
('978-1234567890', 'Database Systems', 'Elmasri', 'Education'),
('978-0987654321', 'Computer Networks', 'Tanenbaum', 'Education'),
('978-1111111111', 'The Silent Patient', 'Alex Michaelides', 'Novel'),
('978-2222222222', 'Artificial Intelligence', 'Russell & Norvig', 'Education');

-- Insert sample Members
INSERT INTO Member (Member_ID, Name, Address, Phone)
VALUES 
(1, 'Asif Khan', 'Muzaffarabad, AJK', '03001234567'),
(2, 'Sara Hameed', 'Islamabad, PK', '03111234567'),
(3, 'Bilawal Malik', 'Lahore, PK', '03211234567');

-- Insert sample Librarians
INSERT INTO Librarian (Emp_ID, Name, Shift, Section)
VALUES 
(101, 'Mr. Imran', 'Morning', 'Computer Science'),
(102, 'Ms. Nadia', 'Evening', 'Literature'),
(103, 'Mr. Faisal', 'Night', 'General');

-- Display Data
SELECT * FROM Book;
SELECT * FROM Member;
SELECT * FROM Librarian;
