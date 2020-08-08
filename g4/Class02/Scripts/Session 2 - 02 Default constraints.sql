--USE [SEDC]
GO

DROP TABLE IF EXISTS [dbo].[ProductTest]
GO
--1. Defined during table creation
CREATE TABLE [dbo].[ProductTest]
(
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Code] [nvarchar](50) NULL,
	[Name] [nvarchar](100) NULL,
	[Description] [nvarchar](max) NULL,
	[Weight] [decimal](18, 2) NULL CONSTRAINT DF_ProductTest_Weight DEFAULT 100,
	[Price] [decimal](18, 2) NULL,
	[Cost] [decimal](18, 2) NULL,
)
GO

insert into [dbo].[ProductTest] ([Name]) values ('Musli bar')
GO

insert into [dbo].[ProductTest] ([Name],[Weight]) values ('Musli bar', 20)


select * from [dbo].[ProductTest]
GO

--2. Added later for new inserts
alter table [dbo].[ProductTest]
add constraint DF_ProductTest_Price
default 0 for Price
GO

insert into [dbo].[ProductTest] ([Name]) values ('Musli bar 2')
GO

select * from [dbo].[ProductTest]
GO

--3. Added later for all rows (newly inserted and existing) for existing Column
alter table [dbo].[ProductTest]
add constraint DF_ProductTest_Cost default 0 for [Cost]
GO

insert into [dbo].[ProductTest] ([Name]) values ('Musli bar 3')
GO

select * from [dbo].[ProductTest]
GO

update [dbo].[ProductTest]
set Cost = 0
where Cost is null
GO

select * from [dbo].[ProductTest]
GO

--4. Added later for all rows (newly inserted and existing) for new Column
alter table [dbo].[ProductTest]
add Cost2 [decimal](18, 2) NULL constraint DF_ProductTest_Cost2 default 0 with values
GO
alter table [dbo].[ProductTest]
add Cost3 [decimal](18, 2) NULL constraint DF_ProductTest_Cost3 default 0 --with values
GO
insert into [dbo].[ProductTest] ([Name]) values ('Musli bar 4')
GO

select * from [dbo].[ProductTest]
GO

DROP TABLE IF EXISTS dbo.ProductTest;
GO