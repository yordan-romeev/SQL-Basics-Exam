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

-- 05. Find Students Without Courses

SELECT s.Name as StudentName
FROM Students s
WHERE StudentID NOT IN (SELECT DISTINCT StudentID FROM Enrollments)

-- Database Seeding Script

CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    Name VARCHAR(100),
    Department VARCHAR(50),
    Salary DECIMAL(10,2)
);

CREATE TABLE Projects (
    ProjectID INT PRIMARY KEY,
    ProjectName VARCHAR(100),
    Budget DECIMAL(10,2)
);

CREATE TABLE EmployeeProjects (
    EmployeeID INT,
    ProjectID INT,
    Role VARCHAR(50),
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID),
    FOREIGN KEY (ProjectID) REFERENCES Projects(ProjectID),
    PRIMARY KEY (EmployeeID, ProjectID)
);

INSERT INTO Employees (EmployeeID, Name, Department, Salary) VALUES
(1, 'John Doe', 'IT', 5000),
(2, 'Jane Smith', 'HR', 4000),
(3, 'Alice Johnson', 'IT', 5500),
(4, 'Bob Brown', 'Finance', 4500);

INSERT INTO Projects (ProjectID, ProjectName, Budget) VALUES
(101, 'Website Redesign', 20000),
(102, 'Database Migration', 30000),
(103, 'Security Audit', 15000);

INSERT INTO EmployeeProjects (EmployeeID, ProjectID, Role) VALUES
(1, 101, 'Developer'),
(1, 102, 'Database Admin'),
(2, 103, 'HR Specialist'),
(3, 101, 'Lead Developer'),
(4, 102, 'Finance Analyst');

-- 06. List of Employees and Their Projects

SELECT e.Name, p.ProjectName, ep.Role
FROM EmployeeProjects ep 
JOIN Employees e ON e.EmployeeID = ep.EmployeeID
JOIN Projects p ON p.ProjectID = ep.ProjectID

-- 07. Department with the Highest Total Salary

SELECT TOP 1 Department, SUM(Salary) AS TotalSalary
FROM Employees
GROUP BY Department
ORDER BY SUM(Salary) DESC

-- 08. Employees Working on More Than One Project

SELECT EmployeeID, COUNT(DISTINCT ProjectID) AS ProjectCount
FROM EmployeeProjects 
GROUP BY EmployeeID
HAVING COUNT(DISTINCT ProjectID) > 1

-- 09. Budget Per Project

SELECT p.ProjectName, SUM(e.Salary) AS BudgetSpent
FROM EmployeeProjects ep 
JOIN Employees e ON e.EmployeeID = ep.EmployeeID
JOIN Projects p ON p.ProjectID = ep.ProjectID
GROUP BY p.ProjectName

-- 10. Employees Without Projects

SELECT *
FROM Employees
WHERE EmployeeID NOT IN (SELECT DISTINCT EmployeeID FROM EmployeeProjects)

-- 11. Create a Stored Procedure

GO 

CREATE PROCEDURE sp_GetEmployeesByDepartment @DepartmentName VARCHAR(50)
AS
BEGIN
    SELECT * FROM Employees WHERE Department = @DepartmentName;
END

GO

-- Sample Usage
-- EXEC sp_GetEmployeesByDepartment 'IT'

-- 12. Implement a User-Defined Function
GO

CREATE FUNCTION fn_GetProjectBudget(@ProjectID INT)
RETURNS DECIMAL(10,2)
AS
BEGIN
    DECLARE @Result DECIMAL(10,2);
    SELECT @Result = Budget FROM Projects WHERE ProjectID = @ProjectID;
    RETURN @Result;
END

GO

-- Sample Usage
-- SELECT dbo.fn_GetProjectBudget(101)

-- 13. Implement a Transaction

BEGIN TRANSACTION;

INSERT INTO Employees (EmployeeID, Name, Department, Salary) 
VALUES (6, 'Huge Axeman', 'Finance', 3000);

INSERT INTO EmployeeProjects (EmployeeID, ProjectID, Role) 
VALUES (6, 103, 'Auditor');

IF @@ERROR <> 0
    ROLLBACK TRANSACTION;
ELSE
    COMMIT TRANSACTION;

