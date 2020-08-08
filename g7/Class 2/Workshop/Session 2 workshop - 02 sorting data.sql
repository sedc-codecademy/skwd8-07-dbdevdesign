/*
Find all Employees with FirstName = Aleksandar ordered by Last Name
List all Employees ordered by FirstName
Find all Male employees ordered by HireDate, starting from the last hired

*/

SELECT * 
FROM Employee
WHERE FirstName = 'Aleksandar'
Order by LastName
GO

SELECT * 
FROM Employee
Order by LastName 
GO


SELECT * 
FROM Employee
WHERE Gender = 'M'
ORDER by HireDate desc
GO

