use [SEDCG]
go
alter PROCEDURE dbo.NewCustomer (@Name nvarchar(100), @AccountNumber nvarchar(50), 
	@City nvarchar(100), @RegionName nvarchar(100),@isActive bit = 1)
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

	print 'Uspeshno vnesen customer'
END
GO

-- Test

--exec dbo.NewCustomer 
-- @Name = 'Viva',
-- @AccountNumber = '123',
-- @City  = 'Skopje',
-- @RegionName ='Skopski',
-- @isActive = 1

  --1--
  exec dbo.NewCustomer 'test2','222','Prilepski','Prilepski',1
  --2--
declare @Name nvarchar(100), @AccountNumber nvarchar(50), 
	@City nvarchar(100), @RegionName nvarchar(100),@isActive bit

set  @Name = 'Viva';
set @AccountNumber = '123';
 set @City  = 'Skopje';
set  @RegionName ='Skopski';
 set @isActive = 1;

 exec dbo.NewCustomer @Name,@AccountNumber,@City,@RegionName,@isActive

 --3--
 exec dbo.NewCustomer 
 @Name = 'Viva',
 @AccountNumber = '123',
 @City  = 'Skopje',
 @RegionName ='Skopski',
 @isActive = 1

