/*Create inline table valued function dbo.fn_EmployeeDetails_InlineDate that for specific Date 
	will return list of all Employee FirstName,lastName, DateOfBirth which were hired in that Date

Modify dbo.fn_EmployeeDetails_InlineDate to accept 2 date parameters and will return all employee that were hired between those 2 dates

*/

DROP FUNCTION IF EXISTS dbo.fn_EmployeeDetails_InlineDate;
GO

CREATE FUNCTION dbo.fn_EmployeeDetails_InlineDate (@HireDate date)
RETURNS TABLE
AS 
RETURN
SELECT Id,FirstName,LastName,DateOfBirth
FROM dbo.Employee e
WHERE HireDate = @HireDate
GO

select * from dbo.fn_EmployeeDetails_InlineDate('2001-01-01')
go

select FirstName,LastName,DateOfBirth 
from dbo.Employee  
where HireDate = '2001-01-01'

GO

CREATE or alter FUNCTION dbo.fn_EmployeeDetails_InlineDate (@HireDateFrom date,@HireDateTo date)
RETURNS TABLE
AS 
RETURN
SELECT Id,FirstName,LastName,DateOfBirth
FROM dbo.Employee e
WHERE HireDate BETWEEN @HireDateFrom AND @HireDateTo
GO

select * from dbo.fn_EmployeeDetails_InlineDate('2001-01-01','2010-01-01')



CREATE or alter FUNCTION dbo.fn_EmployeeOrders (@EmployeeId INT)
RETURNS TABLE
AS 
RETURN
SELECT e.Id,Count(*) AS TotalOrdersCount
FROM dbo.Employee e
INNER JOIN dbo.[Order] o on o.EmployeeId = e.Id
WHERE e.Id = @EmployeeId
GROUP BY e.Id
GO


select * 
from dbo.fn_EmployeeOrders(3) 


select *
from Employee e
outer apply dbo.fn_EmployeeOrders(e.id)  
