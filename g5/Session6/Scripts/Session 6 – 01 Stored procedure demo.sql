
CREATE or alter PROCEDURE dbo.NewCustomer (@Name nvarchar(100), @AccountNumber nvarchar(50), 
	@City nvarchar(100), @RegionName nvarchar(100),@isActive bit)
AS
BEGIN
	
	INSERT INTO dbo.Customer ([Name], [AccountNumber], [City], [RegionName], [isActive])
	VALUES (@Name, @AccountNumber, @City, @RegionName, @isActive)

	select count(*) as TotalCostomersFirstLetter
	FROM dbo.Customer
	where substring(Name,1,1) = substring(@name,1,1)

	select count(*) as CustomersInRegion
	FROM dbo.Customer
	where regionName = @RegionName

END
GO

-- Test

exec dbo.NewCustomer 
 @Name = 'Viva',
 @AccountNumber = '123',
 @City  = 'Skopje',
 @RegionName ='Skopski',
 @isActive = 1


 select * 
 from dbo.Customer
 where name = 'Viva'



 /*update or add new customer*/
 go
 CREATE or alter PROCEDURE dbo.NewCustomer (@Name nvarchar(100), @AccountNumber nvarchar(50), 
	@City nvarchar(100), @RegionName nvarchar(100),@isActive bit)
AS
BEGIN
	
	DECLARE @NewId INT
	
	IF EXISTS (SELECT * FROM dbo.Customer WHERE name = @Name and RegionName = @RegionName)
	begin 
		UPDATE dbo.Customer
			SET AccountNumber = @AccountNumber,
				City = @City,
				isActive = @isActive 
		WHERE Name = @Name AND RegionName = @RegionName

	end
	ELSE
	BEGIN
		INSERT INTO dbo.Customer ([Name], [AccountNumber], [City], [RegionName], [isActive])
		VALUES (@Name, @AccountNumber, @City, @RegionName, @isActive)

		SET @NewId = SCOPE_IDENTITY()
	END

	select count(*) as TotalCostomersFirstLetter
	FROM dbo.Customer
	where substring(Name,1,1) = substring(@name,1,1)

	select count(*) as CustomersInRegion
	FROM dbo.Customer
	where regionName = @RegionName

	SELECT @NewId

END
GO


exec dbo.NewCustomer 
 @Name = 'Viva1',
 @AccountNumber = '123',
 @City  = 'Skopje',
 @RegionName ='Skopski',
 @isActive = 1


 select * 
 from dbo.Customer
 where name = 'Viva1'


 

 /*OUTPut parameter - update or add new customer*/
 go
 CREATE or alter PROCEDURE dbo.NewCustomer (@Name nvarchar(100), @AccountNumber nvarchar(50), 
	@City nvarchar(100), @RegionName nvarchar(100),@isActive bit,
	@CustId INT OUTPUT
	)
AS
BEGIN
	
	DECLARE @NewId INT
	
	IF EXISTS (SELECT * FROM dbo.Customer WHERE name = @Name and RegionName = @RegionName)
	begin 
		UPDATE dbo.Customer
			SET AccountNumber = @AccountNumber,
				City = @City,
				isActive = @isActive 
		WHERE Name = @Name AND RegionName = @RegionName

	end
	ELSE
	BEGIN
		INSERT INTO dbo.Customer ([Name], [AccountNumber], [City], [RegionName], [isActive])
		VALUES (@Name, @AccountNumber, @City, @RegionName, @isActive)

		SET @NewId = SCOPE_IDENTITY()
	END

	select count(*) as TotalCostomersFirstLetter
	FROM dbo.Customer
	where substring(Name,1,1) = substring(@name,1,1)

	select count(*) as CustomersInRegion
	FROM dbo.Customer
	where regionName = @RegionName

	set @CustId = @NewId

END
GO

DECLARE @NewIdOut INT;

exec dbo.NewCustomer 
 @Name = 'Viva2',
 @AccountNumber = '123',
 @City  = 'Skopje',
 @RegionName ='Skopski',
 @isActive = 1,
  @CustId = @NewIdOut OUTPUT;

SELECT @NewIdOut AS 'new Customer Id';

 select * 
 from dbo.Customer
 where name = 'Viva1'


 select * from product