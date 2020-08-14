--use [SEDCG12020]
alter FUNCTION dbo.fn_EmployeeFullName (@EmployeeID int)
RETURNS NVARCHAR(2000)
AS 
BEGIN

DECLARE @Result NVARCHAR(2000)

--set @Result = (select e.FirstName + N' ' + e.LastName
--FROM dbo.Employee e
--WHERE Id = @EmployeeID)


select @Result= e.FirstName + N' ' + e.LastName
FROM dbo.Employee e
WHERE Id = @EmployeeID

RETURN @Result

END
GO

-- how to call
select dbo.fn_EmployeeFullName(1)
go

create function dbo.employeefullname (@employeeid int)
returns nvarchar(100)
as
begin

declare @result nvarchar(100)
set @result = (select FirstName + ''+ LastName
from Employee
where id = @employeeid)

return @result

end

select dbo.employeefullname(1)


create view dbo.test 
as
select dbo.employeefullname(id)fullname, DateOfBirth, Gender
from dbo.employee


go

CREATE FUNCTION dbo.RunningTotalOrdersPerBe (@BeID INT, @orderID INT)
RETURNS Decimal(18,2)
AS
BEGIN
	DECLARE @Result DECIMAL(18,2)

	SELECT @Result = SUM(TotalPrice)
	FROM dbo.[Order] 
	WHERE BusinessEntityID=@BeID
	AND id<=@orderID

	RETURN @Result
END

SELECT *, dbo.RunningTotalOrdersPerBe (BusinessEntityid, Id) AS Saldo
FROM dbo.[Order]
--WHERE id=1690
ORDER BY BusinessEntityID desc