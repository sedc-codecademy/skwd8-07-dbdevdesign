DROP TABLE IF EXISTS [dbo].[ProductTest]
GO

--1. Defined during table creation
CREATE TABLE [dbo].[ProductTest]
(
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Code] [nvarchar](50) NULL,
	[Name] [nvarchar](100) NULL,
	[Description] [nvarchar](max) NULL,
	[Weight] [decimal](18, 2) NULL CONSTRAINT CHK_ProductTest_Weight CHECK ([Weight] <= 1000),
	[Price] [decimal](18, 2) NULL,
	[Cost] [decimal](18, 2) NULL
	)
GO

insert into [dbo].[ProductTest] ([Name], [Weight], Price, Cost) values ('Musli bar', 100, -100, -10)
GO
insert into [dbo].[ProductTest] ([Name], [Weight], Price, Cost) values ('Musli bar 2', 2000, 200, 20)
GO

select * from [dbo].[ProductTest]
GO

--2. Added later for new inserts
ALTER TABLE [dbo].[ProductTest] WITH NOCHECK
ADD CONSTRAINT CHK_ProductTest_Price CHECK (Price >= 0);
GO

insert into [dbo].[ProductTest] ([Name], [Weight], Price, Cost) values ('Musli bar 3', 300, 300, 30)
GO
insert into [dbo].[ProductTest] ([Name], [Weight], Price, Cost) values ('Musli bar 4', 400, -400, 40)
GO

select * from [dbo].[ProductTest]
GO

--3. Added later for all rows (newly inserted and existing)
ALTER TABLE [dbo].[ProductTest] WITH CHECK
ADD CONSTRAINT CHK_ProductTest_Cost CHECK (Cost >= 0);
GO

DROP TABLE IF EXISTS [dbo].[Product_test]
GO