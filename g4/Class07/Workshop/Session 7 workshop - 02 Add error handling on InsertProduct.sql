ALTER TABLE [dbo].[Product] WITH CHECK
ADD CONSTRAINT UC_Product_Code UNIQUE ([Code])
GO

CREATE OR ALTER PROCEDURE dbo.usp_InsertProduct
(
	@Code nvarchar(50), @Name nvarchar(100), @Description nvarchar(max), @Weight decimal(18,2), @Price decimal(18,2), @Cost decimal(18,2)
,	@ProductID int OUT
)
AS
BEGIN
	BEGIN TRY
		INSERT INTO [dbo].[Product]([Code], [Name], [Description], [Weight], [Price], [Cost])
		VALUES (@Code, @Name, @Description, @Weight, @Price, @Cost)

		set @ProductID = Scope_Identity()
		select * from [dbo].[Product] where ID = @ProductID
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
,	@ProductIdOut int

EXEC @ReturnValue = dbo.usp_InsertProduct
	@Code = 'TestCode'
,	@Name = 'TestName'
,	@Description = 'TestDescription'
,	@Weight = 0
,	@Price = 0
,	@Cost = 0
,	@ProductId = @ProductIdOut OUT

SELECT @ReturnValue as ReturnValue, @ProductIdOut as ProductIdOut

select * from Product order by ID desc
