DROP FUNCTION IF EXISTS dbo.fn_EmployeeDetails_Inline;
GO

CREATE FUNCTION dbo.fn_EmployeeDetails_Inline (@EmployeeID int)
RETURNS TABLE
AS 
RETURN
SELECT Id,FirstName,LastName,DateOfBirth
FROM dbo.Employee e
WHERE Id = @EmployeeID
GO

select * from dbo.fn_EmployeeDetails_Inline(1)
GO
