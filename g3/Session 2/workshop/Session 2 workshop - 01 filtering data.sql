/*
Find all Employees with FirstName = Goran
Find all Employees with LastName starting With ‘S’
Find all Employees with DateOfBirth greater than ‘01.01.1988’
Find all Male employees
Find all employees hired in January/1998
Find all Employees with LastName starting With ‘A’ hired in January/1998
*/

SELECT * 
FROM Employee
WHERE FirstName = 'Goran'
GO

SELECT * 
FROM Employee
WHERE DateOfBirth > '1988.01.01'
GO


SELECT * 
FROM Employee
WHERE Gender = 'M'
GO

SELECT * 
FROM Employee
WHERE LastName like 'S%'
GO

SELECT * 
FROM Employee
WHERE HireDate >='1998.01.01' and HireDate < '1998.02.01'
GO

SELECT * 
FROM Employee
WHERE HireDate >='1998.01.01' and HireDate < '1998.02.01'
and LastName like 'A%'
GO
