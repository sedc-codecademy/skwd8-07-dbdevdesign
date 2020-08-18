--Create multi-statement table value function that for specific BusinessEntity and Customer
--will return list of products sold, together with the total quantity sold and total price per product


ALTER FUNCTION dbo.fn_OrdersPerCustomer (@month int, @BusinessEntityId int, @CustomerId int)
RETURNS @output TABLE (OrderMonth nvarchar(20), ProductName nvarchar(100),TotalQuantity int, TotalPrice decimal(18,9))
AS
BEGIN

	INSERT INTO @output
	SELECT MONTH([Order].OrderDate), Product.Name, sum(OrderDetails.Quantity) as TotalQunatity, sum(OrderDetails.Quantity*OrderDetails.Price) as TotalPrice
	FROM dbo.[Order]
	inner join dbo.OrderDetails  on OrderDetails.OrderId=[Order].Id
	inner join dbo.Product on Product.Id=OrderDetails.ProductId
	WHERE [Order].BusinessEntityId = @BusinessEntityId
	AND [Order].CustomerId = @CustomerId
	and MONTH([Order].OrderDate)=@month
	GROUP BY MONTH([Order].OrderDate), Product.Name
	ORDER BY TotalPrice desc

	RETURN
END
GO

select *  from dbo.fn_OrdersPerCustomer(2, 1, 4)
order by TotalPrice desc
	
	

