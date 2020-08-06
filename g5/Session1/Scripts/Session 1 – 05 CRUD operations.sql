USE [master]
GO

CREATE DATABASE SEDC 
GO

USE SEDC
GO

-- CREATE
CREATE TABLE [Customer](
[Id] [int] IDENTITY(1,1) NOT NULL,
[Name] [nvarchar](100) NOT NULL,
[City] [nvarchar](100) NULL,
 CONSTRAINT [PK_Customer] PRIMARY KEY CLUSTERED 
(
[Id] ASC
))
GO

-- INSERT
INSERT INTO [Customer] ([Name], [City])
VALUES  ('Vero Skopje', 'Skopje')

INSERT INTO [Customer] ([Name], [City])
VALUES  ('Vero Strumica', 'Strumica')

-- SELECT
SELECT * FROM Customer

SELECT ID, Name, City
FROM Customer

SELECT ID, Name, City
FROM Customer
WHERE City = 'Skopje'

-- UPDATE
UPDATE Customer 
SET Name = 'Vero Bitola', City = 'Bitola'
WHERE Name = 'Vero Skopje'

-- DELETE
DELETE 
FROM Customer
WHERE Name = 'Vero Skopje'

-- DROP
DROP TABLE Customer





