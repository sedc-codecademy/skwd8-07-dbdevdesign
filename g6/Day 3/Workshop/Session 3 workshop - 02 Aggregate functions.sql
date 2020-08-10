/*
Calculate the total amount on all orders in the system
Calculate the total amount per BusinessEntity on all orders in the system
Calculate the total amount per BusinessEntity on all orders in the system from Customers with ID < 20
Find the Maximal Order amount, and the Average Order amount per BusinessEntity on all orders in the system
Concatenate product names with separator ", " per each order
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
--HAVING SUM(TotalPrice) > 628920

SELECT BusinessEntityId, Max(TotalPrice) as Total, AVG(TotalPrice) as Average
FROM dbo.[Order]
GROUP BY BusinessEntityId
GO

SELECT o.ID, STRING_AGG(p.Name, ', ') as Products
FROM [Order] as o
INNER JOIN OrderDetails as od on o.ID = od.OrderId
INNER JOIN Product as p on od.ProductId = p.ID
GROUP BY o.ID
ORDER BY o.ID
GO