/*Create new procedure called CreateProduct with input parameters (Code,Name,Description,Weight,Price,Cost)
Procedure should create new product only if id does not exist in the system by Name (Unique)
If it exists then we need to update all information related in the parameters
Procedure to return the newly inserted/updated product in the result set

Insert/update few Product in the system

Modify the stored procedure to return newly created/updated id as outputparameter @RecordId, instead of whole row
*/



 /*update or add new CreateProduct*/
 go
 CREATE or alter PROCEDURE dbo.CreateProduct (@Code nvarchar(50), @Name nvarchar(100), @Description nvarchar(max),
	@Weight decimal(18,2), @Price decimal(18,2),@Cost decimal(18,2))
AS
BEGIN
	
	DECLARE @NewId INT

	SET @NewId = (SELECT iD FROM dbo.Product WHERE Code = @Code)
	
	IF @NewId IS NOT NULL
	BEGIN 
		UPDATE dbo.Product
			SET Name = @Name,
				Description = @Description,
				Weight = @Weight ,
				Price = @Price ,
				Cost = @Cost 
		WHERE Code = @Code

	END
	ELSE
	BEGIN

		INSERT INTO dbo.Product ([Code],[Name],[Description],[Weight],[Price],[Cost])
		VALUES (@Code, @Name, @Description, @Weight, @Price, @Cost)

		SET @NewId = SCOPE_IDENTITY()
	END

	select *
	from dbo.Product
	where Id = @NewId

END
GO

select * from Product where code = 'Cru2'

exec dbo.CreateProduct 
 @Code = 'Cru0',
 @Name = 'Crunchy',
 @Description = 'Crunchy description',
 @Weight  = 0.00,
 @Price =26.00,
 @Cost = 20.00


 exec dbo.CreateProduct 
 @Code = 'Cru1',
 @Name = 'Crunchy 1',
 @Description = 'Crunchy description 1',
 @Weight  = 0.00,
 @Price =26.00,
 @Cost = 20.00