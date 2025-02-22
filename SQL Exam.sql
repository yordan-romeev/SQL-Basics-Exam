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

