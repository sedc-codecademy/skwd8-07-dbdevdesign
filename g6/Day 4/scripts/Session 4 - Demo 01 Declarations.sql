-- scalar variable
DECLARE
	@FirstName nvarchar(100),
	@LastName nvarchar(100)

SET @FirstName = 'Aleksandar'
SELECT @LastName = 'Stojanovski'

SELECT * FROM Employee
WHERE FirstName = @FirstName and LastName = @LastName
GO

-- table variable
DECLARE @FemaleEmployeeList TABLE 
(EmployeeID int not null, FirstName nvarchar(100) null, LastName nvarchar(100));

INSERT INTO @FemaleEmployeeList (EmployeeID, FirstName, LastName)
VALUES (101, 'Ana', 'Nikolova')
INSERT INTO @FemaleEmployeeList (EmployeeID, FirstName, LastName)
VALUES (102, 'Aleksandra', 'Nikolova')

INSERT INTO @FemaleEmployeeList (EmployeeID, FirstName, LastName)
VALUES
	(103, 'Bile', 'Markova'),
	(104, 'Bojana', 'Markova')

INSERT INTO @FemaleEmployeeList (EmployeeID, FirstName, LastName)
SELECT ID, FirstName, LastName
FROM Employee
WHERE Gender = 'F'

-- Visible only in the BATCH where is declared
SELECT * FROM @FemaleEmployeeList
GO
-- Not visible
select * from @FemaleEmployeeList

-- Temp table
CREATE TABLE #FemaleEmployeeList
(EmployeeID int not null, FirstName nvarchar(100) null, LastName nvarchar(100));

INSERT INTO #FemaleEmployeeList (EmployeeID, FirstName, LastName)
VALUES (101, 'Ana', 'Nikolova')
INSERT INTO #FemaleEmployeeList (EmployeeID, FirstName, LastName)
VALUES (102, 'Aleksandra', 'Nikolova')

INSERT INTO #FemaleEmployeeList (EmployeeID, FirstName, LastName)
VALUES
	(103, 'Bile', 'Markova'),
	(104, 'Bojana', 'Markova')

INSERT INTO #FemaleEmployeeList (EmployeeID, FirstName, LastName)
SELECT ID, FirstName, LastName
FROM Employee
WHERE Gender = 'F'

-- Visible in the Sesion where is declared
SELECT * FROM #FemaleEmployeeList
GO
-- Visible
select * from #FemaleEmployeeList

--drop table #FemaleEmployeeList
--GO