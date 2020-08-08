CREATE DATABASE SEDC
GO

USE [SEDC]
GO

DROP TABLE IF EXISTS [dbo].OrderDetails;
DROP TABLE IF EXISTS [dbo].[Order];
DROP TABLE IF EXISTS [dbo].[BusinessEntity];
DROP TABLE IF EXISTS [dbo].Customer;
DROP TABLE IF EXISTS [dbo].Product;
DROP TABLE IF EXISTS [dbo].Employee;
GO

CREATE TABLE [dbo].[BusinessEntity](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NULL,
	[Region] [nvarchar](1000) NULL,
	[Zipcode] [nvarchar](10) NULL,
	[Size] [nvarchar](10) NULL,
 CONSTRAINT [PK_BusinessEntity] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
))
GO

CREATE TABLE [dbo].[Customer](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[AccountNumber] [nvarchar](50) NULL,
	[City] [nvarchar](100) NULL,
	[RegionName] [nvarchar](100) NULL,
	[CustomerSize] [nvarchar](10) NULL,
	[PhoneNumber] [nvarchar](20) NULL,
	[isActive] [bit] NOT NULL,
 CONSTRAINT [PK_Customer] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
))
GO

CREATE TABLE [dbo].[Employee](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [nvarchar](100) NOT NULL,
	[LastName] [nvarchar](100) NOT NULL,
	[DateOfBirth] [date] NULL,
	[Gender] [nchar](1) NULL,
	[HireDate] [date] NULL,
	[NationalIdNumber] [nvarchar](20) NULL,
 CONSTRAINT [PK_Employee] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
))
GO

CREATE TABLE [dbo].[Product](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Code] [nvarchar](50) NULL,
	[Name] [nvarchar](100) NULL,
	[Description] [nvarchar](max) NULL,
	[Weight] [decimal](18, 2) NULL,
	[Price] [decimal](18, 2) NULL,
	[Cost] [decimal](18, 2) NULL,
 CONSTRAINT [PK_Product] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
))
GO

CREATE TABLE [dbo].[Order](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[OrderDate] [date] NULL,
	[Status] [smallint] NULL,
	[BusinessEntityId] [int] NULL,
	[CustomerId] [int] NULL,
	[EmployeeId] [int] NULL,
	[TotalPrice] [decimal](18, 2) NULL,
	[Comment] [nvarchar](max) NULL,
 CONSTRAINT [PK_Order] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
))
GO

CREATE TABLE [dbo].[OrderDetails](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[OrderId] [bigint] NULL,
	[ProductId] [int] NULL,
	[Quantity] [int] NULL,
	[Price] [decimal](18, 2) NULL,
 CONSTRAINT [PK_OrderDetails] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
))
GO



