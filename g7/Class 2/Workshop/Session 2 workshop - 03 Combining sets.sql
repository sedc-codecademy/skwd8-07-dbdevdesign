/*

List all BusinessEntity Names and Customer Names in single result set with duplicates
List all regions where some BusinessEntity is based, or some Customer is based. Remove duplicates
List all regions where we have BusinessEntities and Customers in the same time

*/

SELECT Name
FROM BusinessEntity
UNION ALL
SELECT Name 
FROM dbo.Customer
GO

SELECT Region
FROM BusinessEntity
UNION
SELECT RegionName 
FROM dbo.Customer
GO

SELECT Region
FROM BusinessEntity
INTERSECT
--EXCEPT
SELECT RegionName 
FROM dbo.Customer
GO
