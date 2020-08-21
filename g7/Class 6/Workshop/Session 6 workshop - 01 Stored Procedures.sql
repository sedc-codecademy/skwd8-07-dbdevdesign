/*
Create new procedure called CreateOrder
Procedure should create only Order header info (not Order details) 
Procedure should return the total number of orders in the system for the Customer from the new order (regardless the BusinessEntity)
Procedure should return second resultset with the total amount of all orders for the customer and business entity on input (regardless the BusinessEntity)

*/

CREATE PROCEDURE dbo.CreateOrder (@OrderDate date, @BusinessEntityId int, @CustomerId int, @EmployeeId int)
AS
BEGIN
	
	INSERT INTO dbo.[Order] (OrderDate, BusinessEntityId, CustomerId, EmployeeId)
	VALUES (@OrderDate, @BusinessEntityId, @CustomerId, @EmployeeId)

	
	select count(*) as TotalOrdersForCustomer
	FROM dbo.[Order] o
	where CustomerId = @CustomerId

	select sum(totalPrice) as TotalOrderPrice
	FROM dbo.[Order] o
	where CustomerId = @CustomerId
	and BusinessEntityId = @BusinessEntityId

END
GO

-- test execution

EXEC dbo.CreateOrder @OrderDate = '2019.05.23', @BusinessEntityId = 4, @CustomerId = 98, @EmployeeId = 5

select top 10 * 
from dbo.[Order]
order by 1 desc

-- Second part
--------------
/*
Create new procedure called CreateOrderDetail
Procedure should add details for specific order (new record for new Product/Quantity for specific order)
Procedure should take the single price for item from Product table (Price column)
When the order detail is inserted procedure should correct the TotalPrice column in the main table (dbo.order)
Output from this procedure should be resultset with order details in a form of pairs: ProductName and TotalPrice per product (Price*Quantity)
*/

CREATE OR ALTER PROCEDURE dbo.CreateOrderDetail (@OrderId int, @ProductId int, @QuantityId int)
AS
BEGIN

declare @Price decimal(18,9)
declare @TotalPrice decimal(18,9)

-- get the product price
select @Price = Price 
from dbo.Product 
where  id = @ProductId

-- insert new order detail
INSERT INTO dbo.OrderDetails ([OrderId], [ProductId], [Quantity], [Price])
VALUES (@OrderId, @ProductId, @QuantityId, @Price)

-- calculate the total price
SET @TotalPrice = 
(
	SELECT sum(Quantity * Price)
	FROM dbo.[OrderDetails] o
	WHERE o.OrderId = @OrderId
)

-- correct the total price
update o set TotalPrice = @TotalPrice
from [Order] o 
where id = @OrderId

-- output
	SELECT p.Name, sum(o.Quantity) as TotalQuantity, sum(o.Quantity * o.Price) as TotalPricePerProduct
	FROM dbo.[OrderDetails] o
	INNER JOIN dbo.Product p on p.id = o.ProductId
	WHERE o.OrderId = @OrderId
	GROUP BY p.Name

END
GO
	
-- test execution

-- add details to specific order
exec dbo.CreateOrderDetail @OrderId = 4206, @ProductId = 1, @QuantityId = 5
exec dbo.CreateOrderDetail @OrderId = 4206, @ProductId = 2, @QuantityId = 10

-- check the totals
select * from dbo.[Order] 
where id = 4206