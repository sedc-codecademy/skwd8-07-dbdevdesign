DROP FUNCTION IF EXISTS dbo.fn_OrdersPerCustomer;
GO

CREATE FUNCTION dbo.fn_OrdersPerCustomer (@BusinessEntityId int,@CustomerId int)
RETURNS @output TABLE (ProducName nvarchar(100),TotalQuantity int, TotalPrice decimal(18,2))
AS
BEGIN
	INSERT INTO @output
	SELECT p.Name as ProductName, sum(d.Quantity) as TotalQuantity, sum(d.Quantity*d.Price) as TotalPrice
	FROM dbo.[Order] o
	inner join dbo.OrderDetails d on o.Id = d.OrderId
	inner join dbo.Product p on p.id = d.ProductId
	WHERE o.BusinessEntityId = @BusinessEntityId
	and o.CustomerId = @CustomerId
	GROUP BY  p.name
	ORDER BY TotalQuantity
	RETURN 
END
GO

-- Execution

declare @BusinessEntityId int = 1
declare @CustomerId int = 4

select * from dbo.fn_OrdersPerCustomer (@BusinessEntityId,@CustomerId)

