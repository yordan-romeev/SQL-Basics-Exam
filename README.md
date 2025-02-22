# SQL Exam - Feb 2025

## 1. Create a Database and Tables

Write a script to create a database `SchoolDB` and two related tables:

- **Students**:
  - `StudentID` -- PRIMARY KEY INT,
  - `Name` VARCHAR(100),
  - `Age` INT

- **Courses**:
  - `CourseID` PRIMARY KEY - INT,
  - `CourseName` VARCHAR(100)

- **Enrollments**:
  - `EnrollmentID` - INT PRIMARY KEY,
  - `StudentID` INT,
  - `CourseID` INT,
  - Respective foreign keys for `StudentID` and `CourseID`

## 2. Insert Sample Data

Insert the following students and courses:

### Students

| StudentID | Name    | Age |
|-----------|---------|-----|
| 1         | Alice   | 20  |
| 2         | Bob     | 22  |
| 3         | Charlie | 21  |

### Courses

| CourseID | CourseName       |
|----------|------------------|
| 101      | Mathematics      |
| 102      | Physics          |
| 103      | Computer Science |

### Enrollments

| EnrollmentID | StudentID | CourseID |
|--------------|-----------|----------|
| 1            | 1         | 101      |
| 2            | 1         | 103      |
| 3            | 2         | 103      |
| 4            | 3         | 101      |
| 5            | 3         | 102      |
| 6            | 3         | 103      |

## 3. All Students and Their Courses

Retrieve all students along with the courses they are enrolled in.

**Expected Output:**

| Student Name | CourseName       |
|--------------|------------------|
| Alice        | Mathematics      |
| Alice        | Computer Science |
| Bob          | Physics          |
| ...          | ...              |

## 4. Count Students Per Course

Display each course name along with the number of students enrolled.

**Expected Output:**

| CourseName       | StudentCount |
|------------------|--------------|
| Mathematics      | 3            |
| ...              | ...          |

## 5. Find Students Without Courses

Return a list of student names of students who are not enrolled in any course.

**Example Output:**

| StudentName |
|-------------|
| Alice       |

### Database Seeding Script
```sql
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
```

### Insert Sample Data
```sql
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
```

## 6. List Employees and Their Projects

Retrieve all employees and the projects they are working on.

## 7. Department with the Highest Total Salary

Return the department name with the highest total salaries combined.

**Expected Output:**

| Department | TotalSalary |
|------------|-------------|
| IT         | 10500       |

## 8. Employees Working on More Than One Project

Retrieve employees who are assigned to multiple projects.

**Example Output:**

| EmployeeID | ProjectsCount |
|------------|---------------|
| 123        | 12            |

## 9. Budget Utilization Per Project

For each project, show the budget spent (assumed as the sum of employee salaries working on that project).

## 10. Employees Without Projects

List employees that are **not assigned** to any project.

## 11. Create a Stored Procedure

Create a stored procedure `sp_GetEmployeesByDepartment @DepartmentName VARCHAR(50)` that retrieves all employees in a given department.

## 12. Implement a User-Defined Function

Create a function `fn_GetProjectBudget(@ProjectID INT)` that returns the **budget of a project**.

## 13. Implement a Transaction

Write a **transaction** to insert a new employee and assign them to a project. If any step **fails**, rollback.

## 14. Optimize a Query

Given this inefficient query, rewrite it for better performance:

```sql
SELECT e.Name, p.ProjectName, p.Budget
FROM Employees e
JOIN EmployeeProjects ep ON e.EmployeeID = ep.EmployeeID
JOIN Projects p ON ep.ProjectID = p.ProjectID
WHERE p.Budget > (SELECT AVG(Budget) FROM Projects);
```

## 15. Archive Completed Projects

Move all projects with no active employees to a table ArchivedProjects and delete them from Projects.
