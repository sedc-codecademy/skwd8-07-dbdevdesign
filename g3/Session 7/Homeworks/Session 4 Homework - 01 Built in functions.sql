/*
Declare scalar variable for storing FirstName values
	Assign value ‘Antonio’ to the FirstName variable
	Find all Students having FirstName same as the variable

Declare table variable that will contain StudentId, Student Name and DateOfBirth
	Fill the table variable with all Female students

Declare temp table that will contain LastName and EnrolledDate columns
	Fill the temp table with all Male students having First Name starting with ‘A’
	Retrieve the students from the table which last name is with 7 characters

Find all teachers whose FirstName length is less than 5
	, and the first 3 characters of their FirstName and LastName are the same
*/

-- scalar variable
DECLARE @FirstName nvarchar(100)
SET @FirstName = 'Antonio'

SELECT * 
FROM Student
WHERE FirstName = @FirstName
GO

-- table variable
DECLARE @StudentList TABLE 
(StudentId int, FirstName NVARCHAR(100), DateOfBirth date);

INSERT INTO @StudentList
SELECT Id, FirstName, DateOfBirth
FROM dbo.Student
WHERE Gender = 'F'

SELECT * FROM @StudentList
GO

-- Temp table 
IF OBJECT_ID('tempdb..#StudentList') IS NOT NULL DROP TABLE #StudentList;
GO

CREATE TABLE #StudentList 
(LastName NVARCHAR(100), HireDate date);

INSERT INTO #StudentList
SELECT LastName, EnrolledDate 
FROM dbo.Student
WHERE
	FirstName like 'A%'
and	Gender = 'M'

SELECT * 
FROM #StudentList
WHERE Len(LastName) = 7

--
SELECT * FROM Teacher
WHERE LEFT(FirstName, 3) = LEFT (LastName, 3)
AND LEN(FirstName) < 5