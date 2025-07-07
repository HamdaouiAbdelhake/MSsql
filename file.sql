--Create a database named University.
CREATE DATABASE University;

--Users (UserId INT PRIMARY KEY, UserName VARCHAR(64) NOT NULL, FirstName VARCHAR(64) NOT NULL, LastName VARCHAR(64) NOT NULL, EmailAddress VARCHAR(128) NOT NULL, PhoneNumber VARCHAR(16) NOT NULL, Role VARCHAR(32) NOT NULL)
--An email address must be unique in the user table.
CREATE TABLE [dbo].[Users] (
    [UserId]       INT           IDENTITY (1, 1) NOT NULL,
    [UserName]     VARCHAR (64)  NOT NULL,
    [FirstName]    VARCHAR (64)  NOT NULL,
    [LastName]     VARCHAR (64)  NOT NULL,
    [EmailAddress] VARCHAR (128) NOT NULL,
    [PhoneNumber]  VARCHAR (16)  NOT NULL,
    [Role]         VARCHAR (32)  NOT NULL,
    CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED ([UserId] ASC),
    CONSTRAINT UQ_Users_Email UNIQUE (EmailAddress)
);

--Courses (CourseId INT PRIMARY KEY, CourseName VARCHAR(100) NOT NULL, TeacherId INT NULL, StartDate DateTime NOT NULL, EndDate DateTime NOT NULL, SyllabusId NULL)
CREATE TABLE [dbo].[Courses] (
    [CourseId]      INT           IDENTITY (1, 1) NOT NULL,
    [CourseName]    VARCHAR (100)  NOT NULL,
    [TeacherId]     INT  NOT NULL,
    [StartDate]     DATETIME NOT NULL,
    [EndDate]       DATETIME NOT NULL,
    [SyllabusId]    INT  NOT NULL,
    CONSTRAINT [PK_Courses] PRIMARY KEY CLUSTERED ([CourseId] ASC)
);

--Assignments (AssignmentId INT PRIMARY KEY, CourseId INT NOT NULL, AssignmentTitle VARCHAR(128) NOT NULL, Description TEXT NULL, Weight float NOT NULL, MaxGrade INT NOT NULL, DueDate DATE NOT NULL)
CREATE TABLE [dbo].[Assignments] (
    [AssignmentId]      INT           IDENTITY (1, 1) NOT NULL,
    [CourseId]          INT  NOT NULL,
    [AssignmentTitle]   VARCHAR (128)  NOT NULL,
    [Description]       TEXT NULL,
    [Weight]            FLOAT NOT NULL,
    [MaxGrade]          INT  NOT NULL,
    [DueDate]           DATE NOT NULL,
    CONSTRAINT [PK_Assignments] PRIMARY KEY CLUSTERED ([AssignmentId] ASC)
);


--Comments(CommentId INT PRIMARY KEY, AssignmentId INT NOT NULL, CreatedByUserId not null, CreatedDate DATE TIME NOT NULL, CommentContent TEXT NULL)
CREATE TABLE [dbo].[Comments] (
    [CommentId]      INT           IDENTITY (1, 1) NOT NULL,
    [AssignmentId]     INT  NOT NULL,
    [CreatedByUserId]     INT  NOT NULL,
    [CreatedDate]     DATETIME NOT NULL,
    [CommentContent] TEXT NULL,
    CONSTRAINT [PK_Comments] PRIMARY KEY CLUSTERED ([CommentId] ASC)   
);

--Grades (GradeId INT PRIMARY KEY, AssignmentId INT NOT NULL, StudentId INT NOT NULL, Grade INT NULL)
CREATE TABLE [dbo].[Grades] (
    [GradeId]      INT           IDENTITY (1, 1) NOT NULL,
    [AssignmentId]     INT  NOT NULL,
    [StudentId]     INT  NOT NULL,
    [Grade]     INT  NOT NULL,
    CONSTRAINT [PK_Grades] PRIMARY KEY CLUSTERED ([GradeId] ASC)  
);

--Syllabus (SyllabusId INT PRIMARY KEY, Description TEXT NULL)
CREATE TABLE [dbo].[Syllabus] (
    [SyllabusId]      INT           IDENTITY (1, 1) NOT NULL,
    [Description]       TEXT NULL,
    CONSTRAINT [PK_Syllabus] PRIMARY KEY CLUSTERED ([SyllabusId] ASC)
);

    
--Constraints:
ALTER TABLE Courses
ADD CONSTRAINT [FK_COURSES_TEACHERID] FOREIGN KEY ([TeacherId]) REFERENCES [dbo].[Users] ([UserId]),
    CONSTRAINT [FK_COURSES_SYLLABUSID] FOREIGN KEY ([SyllabusId]) REFERENCES [dbo].[Syllabus] ([SyllabusId]);

ALTER TABLE Assignments
ADD CONSTRAINT [FK_ASSIGNMENTS_COURSEID] FOREIGN KEY ([CourseId]) REFERENCES [dbo].[Courses] ([CourseId]);

ALTER TABLE Comments
ADD CONSTRAINT [FK_COMMENT_ASSIGNMENTID] FOREIGN KEY ([AssignmentId]) REFERENCES [dbo].[Assignments] ([AssignmentId]),
    CONSTRAINT [FK_COMMENT_CREATEDBYUSERID] FOREIGN KEY ([CreatedByUserId]) REFERENCES [dbo].[Users] ([UserId]);

ALTER TABLE Grades
ADD CONSTRAINT [FK_GRADES_ASSIGNMENTID] FOREIGN KEY ([AssignmentId]) REFERENCES [dbo].[Assignments] ([AssignmentId]),
    CONSTRAINT [FK_GRADES_STUDENTID] FOREIGN KEY ([StudentId]) REFERENCES [dbo].[Users] ([UserId]);


--Write SQL statements to INSERT data for all the interns into the user table with Role ‘Student’
INSERT INTO [dbo].[Users](UserName, FirstName, LastName, EmailAddress, PhoneNumber, Role)
VALUES 
('AbdelhakeHamdaoui', 'Abdelhake', 'Hamdaoui', 'abdelhakehamdaoui@test.com', '5378527466' ,'Student'),
('HouzifaHabbo', 'Houzifa', 'Habbo', 'houzifahabbo@test.com', '5300560001' ,'Student'),
('AyaKhalifa', 'Aya', 'Khalifa', 'ayakhalifa@test.com', '5300000001', 'Student'),
('FarahSilk', 'Farah', 'Silk', 'farahsilk@test.com', '5300000002', 'Student'),
('MasaSoudan', 'Masa', 'Soudan', 'masasoudan@test.com', '5300000007', 'Student'),
('MohammadRamez', 'Mohammad', 'Ramez', 'mohammadramez@test.com', '5300000008', 'Student'),
('MosaMosa', 'Mosa', 'Mosa', 'mosamosa@test.com', '5300000009', 'Student'),
('NouhadElHallab', 'Nouhad', 'El Hallab', 'nouhadelhallab@test.com', '5300000010', 'Student'),
('ShamJamous', 'Sham', 'Jamous', 'shamjamous@test.com', '5300000012', 'Student'),
('YasinYildiz', 'Yasin', 'Yildiz', 'yasinyildiz@test.com', '5300000013', 'Student'),
('ZaidAlmoughrabl', 'Zaid', 'Almoughrabl', 'zaidalmoughrabl@test.com', '5300000014', 'Student'),
('ZomorodahBakhit', 'Zomorodah', 'Bakhit', 'zomorodahbakhit@test.com', '5300000015', 'Student');


--Write SQL statements to INSERT data for Sami, Feryal into the user table with Role ‘Teacher’
INSERT INTO [dbo].[Users](UserName, FirstName, LastName, EmailAddress, PhoneNumber, Role)
VALUES 
('SamiHijazi', 'Sami', 'Hijazi', 'samihijazi@test.com', '5300000011', 'Teacher'),
('FeryalTulaimat', 'Feryal', 'Tulaimat', 'feryaltulaimat@test.com', '5300000003', 'Teacher');


--Write SQL Statement to INSERT Syllabus for each Course.( I moved it up because we need syllabuses before making courses)
INSERT INTO [dbo].[Syllabus](Description)
VALUES 
('Syllabus for the SQL Course'),
('Syllabus for the C# Course'),
('Syllabus for the Entity Framework Course'),
('Syllabus for the Web API Course'),
('Syllabus for the React Course');


--Write SQL statements to INSERT data for SQL, C#, Entity Framework, Web API and React Courses.
INSERT INTO [dbo].[Courses](CourseName, TeacherId, StartDate, EndDate, SyllabusId)
VALUES 
('SQL',1,'2025-07-07', '2025-07-17', 1),
('C#',2,'2025-07-07', '2025-07-17', 2),
('Entity Framework',1,'2025-07-07', '2025-07-17', 3),
('Web API',2,'2025-07-07', '2025-07-17', 4),
('React',1,'2025-07-07', '2025-07-17', 5);


--Write SQL Statements to INSERT at least 5 Assignments for each Course with random due dates (past & future).
INSERT INTO [dbo].[Assignments](CourseId, AssignmentTitle, Description, Weight, MaxGrade, DueDate)
VALUES 
(1,'Create db', 'Create a db', 0.2, 100, '2025-07-07'),
(1,'Create db', 'Create a db', 0.2, 100, '2024-09-17'),
(1,'Create db', 'Create a db', 0.2, 100, '2025-03-28'),
(1,'Create db', 'Create a db', 0.2, 100, '2023-05-07'),
(1,'Create db', 'Create a db', 0.2, 100, '2024-09-01'),
(2,'Create C# Program', 'Create a C# Program', 0.2, 100, '2024-09-01'),
(2,'Create C# Program', 'Create a C# Program', 0.2, 100, '2025-08-01'),
(2,'Create C# Program', 'Create a C# Program', 0.2, 100, '2023-04-01'),
(2,'Create C# Program', 'Create a C# Program', 0.2, 100, '2022-02-01'),
(2,'Create C# Program', 'Create a C# Program', 0.2, 100, '2025-09-01'),
(3,'EF Intro', 'Intro to EF', 0.2, 100, '2025-07-07'),
(3,'EF Intro', 'Intro to EF', 0.2, 100, '2024-09-17'),
(3,'EF Intro', 'Intro to EF', 0.2, 100, '2025-03-28'),
(3,'EF Intro', 'Intro to EF', 0.2, 100, '2023-05-07'),
(3,'EF Intro', 'Intro to EF', 0.2, 100, '2024-09-01'),
(4,'Make a basic Web API', 'Create an API', 0.2, 100, '2024-09-01'),
(4,'Make a basic Web API', 'Create an API', 0.2, 100, '2025-08-01'),
(4,'Make a basic Web API', 'Create an API', 0.2, 100, '2023-04-01'),
(4,'Make a basic Web API', 'Create an API', 0.2, 100, '2022-02-01'),
(4,'Make a basic Web API', 'Create an API', 0.2, 100, '2025-09-01'),
(5,'Create an SPA', 'Create an SPA using React', 0.2, 100, '2024-09-01'),
(5,'Create an SPA', 'Create an SPA using React', 0.2, 100, '2025-08-01'),
(5,'Create an SPA', 'Create an SPA using React', 0.2, 100, '2023-04-01'),
(5,'Create an SPA', 'Create an SPA using React', 0.2, 100, '2022-02-01'),
(5,'Create an SPA', 'Create an SPA using React', 0.2, 100, '2025-09-01');
 

SELECT * FROM Grades
DBCC CHECKIDENT ('Grades', RESEED, 0);

--Write SQL Statements to INSERT at least 10 comments for random assignments.
INSERT INTO [dbo].[Comments](AssignmentId, CreatedByUserId, CreatedDate, CommentContent)
VALUES 
('7',2,'2025-07-07', 'Hard'),
('3',2,'2025-07-07', 'Easy'),
('5',2,'2025-07-07', 'Doable'),
('6',2,'2025-07-07', 'Super Hard'),
('9',2,'2025-07-07', 'Piece of cake'),
('12',2,'2025-07-07', 'Hard'),
('2',2,'2025-07-07', 'Not that Hard'),
('23',2,'2025-07-07', 'Really Easy'),
('19',2,'2025-07-07', 'not finished'),
('15',2,'2025-07-07', 'Hard');


--Write SQL Statement to INSERT random grades for all students for every assignment.
INSERT INTO [dbo].[Grades](AssignmentId, StudentId, Grade) 
SELECT T1.AssignmentId, T2.UserId, ROUND((99 * RAND(CHECKSUM(NEWID()))), 0)
FROM Assignments as T1 CROSS JOIN USERS as T2
WHERE T2.Role = 'Student';
 

--Write a SELECT query to list all courses.
SELECT * FROM Courses;

--Write a SELECT query to find all assignments for a specific course.
SELECT T2.CourseId,T2.CourseName,T1.AssignmentId, T1.AssignmentTitle
FROM Assignments as T1
INNER JOIN Courses as T2
ON T1.CourseId = T2.CourseId;

--Write a SELECT query to find all students (users with the role 'Student').
SELECT * FROM Users
WHERE Role = 'Student';

--Write an UPDATE statement to change a student's role.
UPDATE Users
SET Role = 'New Student'
WHERE UserId =3;

--Write a DELETE statement to remove a specific comment.
DELETE FROM Comments WHERE CommentId =1;

--Write a query to list all students along with their grades for a specific course.(WEB API COURSE)
SELECT T1.UserId,T1.UserName,T1.FirstName,T1.LastName,T4.CourseName,T3.AssignmentTitle,T2.Grade
FROM Users as T1
INNER JOIN Grades as T2
ON T1.UserId = T2.StudentId
INNER JOIN Assignments as T3
ON T2.AssignmentId = T3.AssignmentId
INNER JOIN Courses as T4
ON T3.CourseId = T4.CourseId
WHERE T1.Role = 'Student'AND T4.CourseId = 4;

--Write a query to calculate the average grade for each course.
SELECT T1.UserId,T1.UserName,T1.FirstName,T1.LastName,T4.CourseId,T4.CourseName,SUM(T2.Grade*T3.Weight) as Average
FROM USERS as T1
INNER JOIN Grades as T2
ON T1.UserId = T2.StudentId
INNER JOIN Assignments as T3
ON T2.AssignmentId = T3.AssignmentId
INNER JOIN Courses as T4
ON T3.CourseId = T4.CourseId
WHERE T1.Role = 'Student'
GROUP BY T1.UserId,T1.UserName,T1.FirstName,T1.LastName,T4.CourseId,T4.CourseName,T3.Weight;


--Write a query to list all courses with their respective syllabuses.
SELECT T1.CourseId, T1.CourseName, T2.SyllabusId,T2.Description
FROM Courses as T1
INNER JOIN Syllabus as T2
ON T1.SyllabusId = T2.SyllabusId;

--Write a query to find all comments for a specific course.
SELECT T1.CourseId, T1.CourseName, T3.AssignmentId,T2.AssignmentTitle,T3.CommentContent
FROM Courses as T1
INNER JOIN Assignments as T2
ON T1.CourseId = T2.CourseId
INNER JOIN Comments as T3
ON T3.AssignmentId = T2.AssignmentId;

--Create a stored procedure to add a new student.
GO
CREATE PROCEDURE sp_ADD_STUDENT
    @UserName [varchar](64) ,
	@FirstName [varchar](64) ,
	@LastName [varchar](64) ,
	@EmailAddress [varchar](128) ,
	@PhoneNumber [varchar](16)
AS
BEGIN
    INSERT INTO [dbo].[Users](UserName, FirstName, LastName, EmailAddress, PhoneNumber, Role)
    VALUES (@UserName,@FirstName,@LastName,@EmailAddress,@PhoneNumber,'Student')
END
GO

--Create a stored procedure to add a new Assignment. Make sure the course assignments weights don’t go above 100.
CREATE PROCEDURE sp_ADD_ASSIGNMENT
    @CourseId [int] ,
	@AssignmentTitle [varchar](128) ,
	@Description [text] ,
	@Weight [float] ,
	@MaxGrade [int] ,
	@DueDate [date] 
AS
BEGIN

    IF @Weight > 1
    BEGIN
        RAISERROR('Weights can''t go above 100%%', 16, 1)
        RETURN
    END
    INSERT INTO [dbo].[Assignments](CourseId, AssignmentTitle, Description, Weight, MaxGrade, DueDate)
    VALUES (@CourseId,@AssignmentTitle,@Description,@Weight,@MaxGrade,@DueDate)
END
GO

--Calculate function to calculate the Student Grade in a Course. Return ‘A', 'B’, etc…
CREATE FUNCTION fn_STUDENT_GRADE(@StudentId int, @CourseId int)
RETURNS CHAR(1)
AS
BEGIN
    DECLARE @AverageGrade as FLOAT
    DECLARE @Grade as CHAR(1)

    SELECT @AverageGrade = SUM(T2.Grade*T3.Weight)
    FROM USERS as T1
    INNER JOIN Grades as T2
    ON T1.UserId = T2.StudentId
    INNER JOIN Assignments as T3
    ON T2.AssignmentId = T3.AssignmentId
    INNER JOIN Courses as T4
    ON T3.CourseId = T4.CourseId
    WHERE T1.UserId = @StudentId
    AND T3.CourseId = @CourseId;

    IF @AverageGrade > 90
    BEGIN
        SET @Grade = 'A'
    END
    ELSE IF @AverageGrade > 80
    BEGIN
        SET @Grade = 'B'
    END
    ELSE IF @AverageGrade > 60
    BEGIN
        SET @Grade = 'C'
    END
    ELSE IF @AverageGrade > 50
    BEGIN
        SET @Grade = 'D'
    END
    ELSE IF @AverageGrade < 50
    BEGIN
        SET @Grade = 'F'
    END

    RETURN @Grade
END
GO

--Create a function to calculate the GPA of a student.
CREATE FUNCTION fn_STUDENT_GPA(@StudentId int)
RETURNS FLOAT
AS
BEGIN
    DECLARE @GPA as FLOAT

    SELECT @GPA = AVG(CourseAVG)/25
    FROM (
        SELECT SUM(T2.Grade*T3.Weight) as CourseAVG
        FROM USERS as T1
        INNER JOIN Grades as T2
        ON T1.UserId = T2.StudentId
        INNER JOIN Assignments as T3
        ON T2.AssignmentId = T3.AssignmentId
        INNER JOIN Courses as T4
        ON T3.CourseId = T4.CourseId
        WHERE T1.UserId = @StudentId
        GROUP BY T3.CourseId
    ) as CalculateAVG

    RETURN @GPA
END
GO

