--ALTER 

CREATE FUNCTION dbo.fn_EmployeeFullName(@EmployeeID int)
	RETURNS nvarchar(2000)
	AS
	BEGIN
		
		declare @Result nvarchar(2000)

			select @Result = FirstName + ' ' + LastName
			from dbo.Employee
			where id = @EmployeeID

		RETURN @Result
	END

--- Povik
--	select dbo.fn_EmployeeFullName(1) + ' test'

--select dbo.fn_efn(1) + ' test'