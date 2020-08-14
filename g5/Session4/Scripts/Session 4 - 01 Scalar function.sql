
CREATE FUNCTION dbo.fn_EmployeeFullName (@EmployeeID int)
RETURNS NVARCHAR(2000)
AS 
BEGIN

DECLARE @Result NVARCHAR(2000)

SELECT @Result = e.FirstName + N' ' + e.LastName
FROM dbo.Employee e
WHERE Id = @EmployeeID

RETURN @Result

END
GO

-- how to call
select dbo.fn_EmployeeFullName(1)
select dbo.fn_EmployeeFullName(1),dbo.fn_EmployeeFullName(2) + ' AND ' + dbo.fn_EmployeeFullName(3)
--select dbo.fn_EmployeeFullName(2)