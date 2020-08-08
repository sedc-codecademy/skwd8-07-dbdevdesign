DROP TABLE IF EXISTS [dbo].[ProductTest]
GO

--1. Defined during table creation
CREATE TABLE [dbo].[ProductTest]
(
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Code] [nvarchar](50) NULL CONSTRAINT UC_ProductTest_Code UNIQUE (Code),
	[Name] [nvarchar](100) NULL,
	[Description] [nvarchar](max) NULL,
	[Weight] [decimal](18, 2) NULL,
	[Price] [decimal](18, 2) NULL,
	[Cost] [decimal](18, 2) NULL
)
GO

insert into [dbo].[ProductTest] (Code, [Name]) values ('msb', 'Musli bar')
GO
insert into [dbo].[ProductTest] (Code, [Name]) values ('msb', 'Musli bar 2')
GO

select * from [dbo].[ProductTest]
GO

--2. Added later for all rows (newly inserted and existing)
ALTER TABLE [dbo].[ProductTest] WITH CHECK
ADD CONSTRAINT UC_ProductTest_Name UNIQUE ([Name])
GO

insert into [dbo].[ProductTest] (Code, [Name]) values ('msb3', 'Musli bar 3')
GO
insert into [dbo].[ProductTest] (Code, [Name]) values ('msb4', 'Musli bar 3')
GO

select * from [dbo].[ProductTest]
GO

DROP TABLE IF EXISTS [dbo].[Product_test]
GO
