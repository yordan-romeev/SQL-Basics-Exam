-- 01. Create a Database and Tables

CREATE TABLE Students (
    StudentID INT PRIMARY KEY IDENTITY,
    Name VARCHAR(100),
    Age INT
)

GO

CREATE TABLE Courses (
    CourseID INT PRIMARY KEY IDENTITY(101, 1),
    CourseName VARCHAR(100)
)

GO

CREATE TABLE Enrollments (
    EnrollmentID INT PRIMARY KEY IDENTITY,
    StudentID INT,
    CourseID INT,
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID)
)

GO

-- 02. Insert Sample Data

INSERT INTO Students (Name, Age) VALUES
('Alice', 20),
('Bob', 22),
('Charlie', 21)

GO

INSERT INTO Courses (CourseName) VALUES
('Mathematics'),
('Physics'),
('Computer Science')

GO

INSERT INTO Enrollments (StudentID, CourseID) VALUES
(1,101),
(1,103),
(2,103),
(3,101),
(3,102),
(3,103)

GO

-- 03. All Students and Their Courses

SELECT s.Name, c.CourseName
FROM Students s
JOIN Enrollments e ON e.StudentID = s.StudentID
JOIN Courses c ON c.CourseID = e.CourseID

-- 04. Count Students Per Course

SELECT c.CourseName, COUNT(DISTINCT e.StudentID) AS StudentCount
FROM Enrollments e
JOIN Courses c ON c.CourseID = e.CourseID
GROUP BY c.CourseName