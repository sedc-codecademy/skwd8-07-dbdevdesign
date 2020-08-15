DROP FUNCTION IF EXISTS dbo.fn_EmployeeDetails_MultiStatement;
GO

CREATE FUNCTION dbo.fn_EmployeeDetails_MultiStatement (@EmployeeID int)
RETURNS @output TABLE (Id int, FirstName NVARCHAR(100), LastName NVARCHAR(100), DateOfBirth date)
AS
BEGIN

-- Multi statement functions support more then 1 query in the function
-- example: return data only if employeeId is Male
IF @EmployeeID %2 = 0
BEGIN
	INSERT INTO @output
	SELECT Id,FirstName,LastName,DateOfBirth
	FROM dbo.Employee e
	WHERE Id = @EmployeeID
END 

RETURN 
END

GO

select * from dbo.fn_EmployeeDetails_MultiStatement(2)
go

