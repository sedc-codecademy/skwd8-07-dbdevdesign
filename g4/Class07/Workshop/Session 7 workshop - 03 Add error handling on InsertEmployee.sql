ALTER TABLE [dbo].[Employee] WITH CHECK
ADD CONSTRAINT UC_Employee_NationalIdNumber UNIQUE ([NationalIdNumber])
GO

CREATE OR ALTER PROCEDURE dbo.usp_InsertEmployee
(
	@FirstName nvarchar(100), @LastName nvarchar(100), @DateOfBirth date, @Gender nchar(1), @HireDate date, @NationalIdNumber nvarchar(20)
,	@EmployeeID int OUT
)
AS
BEGIN
	BEGIN TRY
		INSERT INTO [dbo].[Employee] ([FirstName], [LastName], [DateOfBirth], [Gender], [HireDate], [NationalIdNumber])
		VALUES (@FirstName, @LastName, @DateOfBirth, @Gender, @HireDate, @NationalIdNumber)

		--Scope_Identity() - Returns the last identity value inserted into an identity column in the same scope. A scope is a module: a stored procedure, function, or batch
		set @EmployeeID = Scope_Identity()

		select * from [dbo].[Employee] where ID = @EmployeeID
	END TRY
	BEGIN CATCH  
		SELECT  
			ERROR_NUMBER() AS ErrorNumber
		,	ERROR_SEVERITY() AS ErrorSeverity
		,	ERROR_STATE() AS ErrorState
		,	ERROR_PROCEDURE() AS ErrorProcedure
		,	ERROR_LINE() AS ErrorLine
		,	ERROR_MESSAGE() AS ErrorMessage;
		--THROW;
	END CATCH;
END
GO

DECLARE
	@ReturnValue int
,	@EmployeeIdOut int

EXEC @ReturnValue = dbo.usp_InsertEmployee
	@FirstName = 'TestName'
,	@LastName = 'TestLastName'
,	@DateOfBirth = '1900-01-01'
,	@Gender = 'M'
,	@HireDate = '1900-01-01'
,	@NationalIdNumber = '1111111'
,	@EmployeeId = @EmployeeIdOut OUT

SELECT @ReturnValue as ReturnValue, @EmployeeIdOut as EmployeeIdOut

select * from Employee order by ID desc