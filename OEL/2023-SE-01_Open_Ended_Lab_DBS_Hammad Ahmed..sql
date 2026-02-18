CREATE DATABASE Hammad_Ahmed_Open_Ended_Lab;
GO
USE Hammad_Ahmed_Open_Ended_Lab;
GO

-- ##########################################################################
-- # Task 02: SCHEMA IMPLEMENTATION (DDL) and DATA INSERTION (DML)###########
-- ##########################################################################

-- 1. CAMPUS Table
CREATE TABLE CAMPUS (
    CampusID TINYINT IDENTITY(1,1) PRIMARY KEY,
    Name NVARCHAR(50) NOT NULL UNIQUE,
    Location NVARCHAR(50) NOT NULL
);

-- 2. MANAGER Table
CREATE TABLE MANAGER (
    ManagerID INT IDENTITY(100,1) PRIMARY KEY,
    Name NVARCHAR(100) NOT NULL,
    Email NVARCHAR(100) UNIQUE NOT NULL,
    Phone VARCHAR(20)
);

-- 3. TUTOR Table
CREATE TABLE TUTOR (
    TutorID INT IDENTITY(200,1) PRIMARY KEY,
    Name NVARCHAR(100) NOT NULL,
    Salary MONEY NOT NULL CHECK (Salary >= 30000),
    TutorType NVARCHAR(50) NOT NULL,
    Qualifications NVARCHAR(255),
    Email NVARCHAR(100) UNIQUE NOT NULL,
    ManagerID INT,
    CONSTRAINT FK_Tutor_Manager FOREIGN KEY (ManagerID) REFERENCES MANAGER(ManagerID)
);

-- 4. LEARNER Table
CREATE TABLE LEARNER (
    LearnerID INT IDENTITY(3000,1) PRIMARY KEY,
    Name NVARCHAR(100) NOT NULL,
    Email NVARCHAR(100) UNIQUE NOT NULL,
    Age TINYINT CHECK (Age BETWEEN 15 AND 99),
    Gender CHAR(1) CHECK (Gender IN ('M','F','O')),
    Phone VARCHAR(20),
    LearningStyle NVARCHAR(10) NOT NULL CHECK (LearningStyle IN ('full-time','part-time'))
);

-- 5. COURSE Table
CREATE TABLE COURSE (
    CourseID TINYINT IDENTITY(1,1) PRIMARY KEY,
    CourseName NVARCHAR(100) NOT NULL UNIQUE,
    Language NVARCHAR(50) NOT NULL,
    CampusID TINYINT,
    CONSTRAINT FK_Course_Campus FOREIGN KEY (CampusID) REFERENCES CAMPUS(CampusID)
);

-- 6. SEMESTER Table
CREATE TABLE SEMESTER (
    SemesterID INT IDENTITY(10,1) PRIMARY KEY,
    Name NVARCHAR(50) NOT NULL UNIQUE,
    StartDate DATE NOT NULL,
    EndDate DATE NOT NULL,
    IsFullTime BIT NOT NULL
);

-- 7. CLASS Table
CREATE TABLE CLASS (
    ClassID INT IDENTITY(1000,1) PRIMARY KEY,
    StartDate DATETIME NOT NULL,
    EndDate DATETIME NOT NULL,
    Size TINYINT CHECK (Size BETWEEN 5 AND 20) NOT NULL,
    CourseID TINYINT,
    TutorID INT,
    SemesterID INT,
    CONSTRAINT FK_Class_Course FOREIGN KEY (CourseID) REFERENCES COURSE(CourseID),
    CONSTRAINT FK_Class_Tutor FOREIGN KEY (TutorID) REFERENCES TUTOR(TutorID),
    CONSTRAINT FK_Class_Semester FOREIGN KEY (SemesterID) REFERENCES SEMESTER(SemesterID)
);

-- 8. LEARNING_RESOURCE Table
CREATE TABLE LEARNING_RESOURCE (
    ResourceID INT IDENTITY(500,1) PRIMARY KEY,
    Type NVARCHAR(50) NOT NULL CHECK (Type IN ('video','audio','PPT','text')),
    Duration INT,
    Author NVARCHAR(100),
    IssueDate DATE
);

-- 9. LEARNING_ACTIVITY Table
CREATE TABLE LEARNING_ACTIVITY (
    ActivityID INT IDENTITY(600,1) PRIMARY KEY,
    ActivityType NVARCHAR(50) NOT NULL,
    IssueDate DATE NOT NULL,
    Marks_Max TINYINT NOT NULL,
    ResourceID INT,
    CONSTRAINT FK_Activity_Resource FOREIGN KEY (ResourceID) REFERENCES LEARNING_RESOURCE(ResourceID)
);

-- 10. ENROLLMENT Table
CREATE TABLE ENROLLMENT (
    EnrollmentID INT IDENTITY(1,1) PRIMARY KEY,
    LearnerID INT NOT NULL,
    CourseID TINYINT NOT NULL,
    SemesterID INT NOT NULL,
    EnrollmentDate DATE DEFAULT GETDATE(),
    CourseDuration SMALLINT,
    FeesBase MONEY NOT NULL,
    FeesPaid MONEY,
    Contact NVARCHAR(50),
    CONSTRAINT UQ_Enrollment UNIQUE (LearnerID, CourseID, SemesterID),
    CONSTRAINT FK_Enrollment_Learner FOREIGN KEY (LearnerID) REFERENCES LEARNER(LearnerID),
    CONSTRAINT FK_Enrollment_Course FOREIGN KEY (CourseID) REFERENCES COURSE(CourseID),
    CONSTRAINT FK_Enrollment_Semester FOREIGN KEY (SemesterID) REFERENCES SEMESTER(SemesterID)
);

-- 11. COURSE_RESOURCE Table
CREATE TABLE COURSE_RESOURCE (
    CourseID TINYINT NOT NULL,
    ResourceID INT NOT NULL,
    PRIMARY KEY (CourseID, ResourceID),
    CONSTRAINT FK_CR_Course FOREIGN KEY (CourseID) REFERENCES COURSE(CourseID),
    CONSTRAINT FK_CR_Resource FOREIGN KEY (ResourceID) REFERENCES LEARNING_RESOURCE(ResourceID)
);

-- 12. ENROLLMENT_CLASS Table
CREATE TABLE ENROLLMENT_CLASS (
    EnrollmentID INT NOT NULL,
    ClassID INT NOT NULL,
    Attendance BIT DEFAULT 0,
    PRIMARY KEY (EnrollmentID, ClassID),
    CONSTRAINT FK_EC_Enrollment FOREIGN KEY (EnrollmentID) REFERENCES ENROLLMENT(EnrollmentID),
    CONSTRAINT FK_EC_Class FOREIGN KEY (ClassID) REFERENCES CLASS(ClassID)
);

------------------------------------------------------------------------------------
-- After Table creation now insertion of data in table
------------------------------------------------------------------------------------
INSERT INTO CAMPUS (Name, Location) VALUES
('NBS neelum','neelum'),
('NBS Bagh','Bagh'),
('NBS Mzd','Mzd'),
('NBS Jehlum','Jehlum'),
('NBS Bhimber','Bhimber');

INSERT INTO MANAGER (Name, Email, Phone) VALUES
('Alex Johnson','alex.j@nbs.edu','555-1001'),
('Maria Sanchez','maria.s@nbs.edu','555-1002'),
('Kenji Tanaka','kenji.t@nbs.edu','555-1003'),
('Zara Ali','zara.a@nbs.edu','555-1004'),
('Paul OMalley','paul.o@nbs.edu','555-1005');

INSERT INTO TUTOR (Name, Salary, TutorType, Qualifications, Email, ManagerID) VALUES
('Eva Mendes',60000,'Full-Time','PhD Linguistics','eva.m@nbs.edu',101),
('David Lee',55000,'Part-Time','MA German','david.l@nbs.edu',101),
('Sophie Dubois',75000,'Full-Time','Prof French','sophie.d@nbs.edu',102),
('Omar Khan',45000,'Part-Time','BA TESOL','omar.k@nbs.edu',103),
('Elena Rossi',62000,'Full-Time','MA Spanish','elena.r@nbs.edu',105);

INSERT INTO LEARNER (Name, Email, Age, Gender, Phone, LearningStyle) VALUES
('Alice Chen','alice.c@mail.com',22,'F','123-4567','full-time'),
('Ben Carter','ben.c@mail.com',35,'M','234-5678','part-time'),
('Chloe Davis','chloe.d@mail.com',28,'F',NULL,'full-time'),
('Dev Patel','dev.p@mail.com',41,'M','456-7890','part-time'),
('Fiona Green','fiona.g@mail.com',19,'F','567-8901','full-time');

INSERT INTO COURSE (CourseName, Language, CampusID) VALUES
('Intro English','English',1),
('Advanced German','German',4),
('Business French','French',2),
('Survival Spanish','Spanish',1),
('Cultural English','English',3);

INSERT INTO SEMESTER (Name, StartDate, EndDate, IsFullTime) VALUES
('S1-2025 FT','2025-01-15','2025-05-15',1),
('S2-2025 FT','2025-06-01','2025-09-30',1),
('S1-2025 PT','2025-01-15','2025-06-30',0),
('S3-2025 FT','2025-10-15','2026-02-15',1),
('S2-2025 PT','2025-07-01','2025-12-30',0);

INSERT INTO CLASS (StartDate, EndDate, Size, CourseID, TutorID, SemesterID) VALUES
('2025-01-20 10:00','2025-01-20 12:00',18,1,201,10),
('2025-01-20 14:00','2025-01-20 16:00',9,2,202,12),
('2025-06-05 09:00','2025-06-05 11:00',15,3,203,11),
('2025-10-20 18:00','2025-10-20 20:00',20,4,204,13),
('2025-01-25 11:00','2025-01-25 13:00',12,1,201,10);

INSERT INTO LEARNING_RESOURCE (Type, Duration, Author, IssueDate) VALUES
('video',15,'Smith','2024-11-01'),
('audio',8,'Jones','2024-12-10'),
('PPT',60,'King','2025-01-05'),
('text',NULL,'Lee','2024-10-20'),
('video',25,'Chen','2025-02-15');

INSERT INTO LEARNING_ACTIVITY (ActivityType, IssueDate, Marks_Max, ResourceID) VALUES
('drag-drop','2025-01-20',10,500),
('fill-in','2025-01-25',5,500),
('quiz','2025-02-01',15,502),
('essay','2025-02-10',20,503),
('matching','2025-03-01',10,501);

INSERT INTO ENROLLMENT (LearnerID, CourseID, SemesterID, FeesBase, FeesPaid, Contact) VALUES
(3000,1,10,300,300,'Friend'),
(3001,2,12,150,150,'Website'),
(3002,3,11,300,300,'Agent'),
(3003,4,13,150,150,'Alumnus'),
(3000,5,11,300,240,'Friend');

INSERT INTO COURSE_RESOURCE (CourseID, ResourceID) VALUES
(1,500),(1,501),(2,502),(3,503),(5,504);

INSERT INTO ENROLLMENT_CLASS (EnrollmentID, ClassID, Attendance) VALUES
(1,1000,1),(1,1004,1),(2,1001,1),(3,1002,0),(4,1003,1);

------------------------------------------------------------------------------------
--Task03: DATA ANALYSIS (DML)
------------------------------------------------------------------------------------

-- 1. INNER JOIN
SELECT T.Name AS TutorName, M.Name AS ManagerName, T.Email AS TutorEmail
FROM TUTOR T
INNER JOIN MANAGER M ON T.ManagerID = M.ManagerID;

-- 2. FULL JOIN
SELECT C.CourseName, LR.ResourceID, LR.Type AS ResourceType
FROM COURSE C
FULL JOIN COURSE_RESOURCE CR ON C.CourseID = CR.CourseID
FULL JOIN LEARNING_RESOURCE LR ON CR.ResourceID = LR.ResourceID;

-- 3. LEARNER FEE CALCULATION (STATIC VERSION)
-- Full-time fee = 300, part-time = 150, 20% discount if repeated enrollment
SELECT
    L.LearnerID,
    L.Name AS LearnerName,
    L.LearningStyle,
    CASE 
        WHEN COUNT(E.EnrollmentID) > 1 THEN 
            CASE 
                WHEN L.LearningStyle = 'full-time' THEN 300 * 0.8
                ELSE 150 * 0.8
            END
        ELSE 
            CASE 
                WHEN L.LearningStyle = 'full-time' THEN 300
                ELSE 150
            END
    END AS FinalFee
FROM LEARNER L
LEFT JOIN ENROLLMENT E ON L.LearnerID = E.LearnerID
GROUP BY L.LearnerID, L.Name, L.LearningStyle;

-- 4. TUTORS teaching class > average size
SELECT TutorID, Name
FROM TUTOR
WHERE TutorID IN (
    SELECT DISTINCT TutorID
    FROM CLASS
    WHERE Size > (SELECT AVG(CAST(Size AS DECIMAL(5,2))) FROM CLASS)
);

-- 5. LEARNERS with missing phone
SELECT LearnerID, Name, Email
FROM LEARNER
WHERE Phone IS NULL OR Phone = '';

------------------------------------------------------------------------------------
--Task 05: OPTIMIZATION (VIEWS, INDEXES, FUNCTION EQUIVALENTS)
------------------------------------------------------------------------------------

CREATE VIEW Learner_Financial_Summary AS
SELECT
    L.LearnerID,
    L.Name AS LearnerName,
    C.CourseName,
    S.Name AS Semester,
    E.FeesPaid,
    E.FeesBase
FROM LEARNER L
JOIN ENROLLMENT E ON L.LearnerID = E.LearnerID
JOIN COURSE C ON E.CourseID = C.CourseID
JOIN SEMESTER S ON E.SemesterID = S.SemesterID
WHERE E.FeesPaid IS NOT NULL;

SELECT * FROM Learner_Financial_Summary;
-- Simulated Function: Check tutor class load (static)
SELECT TutorID, COUNT(ClassID) AS ClassesTaught_2025
FROM CLASS
JOIN SEMESTER ON CLASS.SemesterID = SEMESTER.SemesterID
WHERE YEAR(SEMESTER.StartDate) = 2025
GROUP BY TutorID;

-- Index
CREATE UNIQUE NONCLUSTERED INDEX IDX_Learner_Email ON LEARNER (Email);
