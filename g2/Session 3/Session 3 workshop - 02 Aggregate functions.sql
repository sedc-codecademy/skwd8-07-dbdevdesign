/*
Calculate the total amount on all orders in the system
Calculate the total amount per BusinessEntity on all orders in the system
Calculate the total amount per BusinessEntity on all orders in the system from Customers with ID < 20
Find the Maximal Order amount, and the Average Order amount per BusinessEntity on all orders in the system
*/


SELECT SUM(TotalPrice) as Total
from dbo.[Order]
GO

SELECT BusinessEntityId, SUM(TotalPrice) as Total
FROM dbo.[Order]
GROUP BY BusinessEntityId
GO

SELECT BusinessEntityId, SUM(TotalPrice) as Total
FROM dbo.[Order]
WHERE CustomerId < 20
GROUP BY BusinessEntityId
HAVING SUM(TotalPrice) > 628920


SELECT BusinessEntityId, Max(TotalPrice) as Total, AVG(TotalPrice) as Average
FROM dbo.[Order]
GROUP BY BusinessEntityId
GO
