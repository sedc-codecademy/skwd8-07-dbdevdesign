--------------------
--View

DROP VIEW IF EXISTS dbo.vv_EmployeeDetails
GO
CREATE VIEW dbo.vv_EmployeeDetails
AS
	select
		Id,FirstName,LastName,DateOfBirth
	from
		dbo.Employee
	where
		Gender = 'F'
GO

--------------------
--Inline TVF

DROP FUNCTION IF EXISTS dbo.fn_EmployeeDetails_Inline;
GO
CREATE FUNCTION dbo.fn_EmployeeDetails_Inline (@Gender nchar(1))
RETURNS TABLE
AS 
	RETURN
	select
		Id,FirstName,LastName,DateOfBirth
	from
		dbo.Employee
	where
		Gender = @Gender
GO

--------------------
--MultiStatement TVF

DROP FUNCTION IF EXISTS dbo.fn_EmployeeDetails_MultiStatement;
GO
CREATE FUNCTION dbo.fn_EmployeeDetails_MultiStatement (@Gender nchar(1))
RETURNS @output TABLE (Id int, FirstName NVARCHAR(100), LastName NVARCHAR(100), DateOfBirth date)
AS
BEGIN
	IF @Gender =  'F'
	BEGIN
		insert into @output (Id,FirstName,LastName,DateOfBirth)
		select
			Id,FirstName,LastName,DateOfBirth
		from
			dbo.Employee
		where
			Gender = @Gender
	END
RETURN 
END
GO

select * from dbo.vv_EmployeeDetails
go
select * from dbo.fn_EmployeeDetails_Inline('F')
go
select * from dbo.fn_EmployeeDetails_MultiStatement('F')
go

select
	o.*
from
	dbo.[Order] as o
	inner join dbo.vv_EmployeeDetails as e on o.EmployeeId = e.Id
order by
	o.EmployeeId

select
	o.*
from
	dbo.[Order] as o
	inner join dbo.fn_EmployeeDetails_Inline('F') as e on o.EmployeeId = e.Id
order by
	o.EmployeeId

select
	o.*
from
	dbo.[Order] as o
	inner join dbo.fn_EmployeeDetails_MultiStatement('F') as e on o.EmployeeId = e.Id
order by
	o.EmployeeId