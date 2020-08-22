USE [SEDCG7]
GO

/****** Object:  StoredProcedure [dbo].[CreateOrderDetail]    Script Date: 8/22/2020 10:48:57 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- Second part
--------------
/*
Create new procedure called CreateOrderDetail
Procedure should add details for specific order (new record for new Product/Quantity for specific order)
Procedure should take the single price for item from Product table (Price column)
When the order detail is inserted procedure should correct the TotalPrice column in the main table (dbo.order)
Output from this procedure should be resultset with order details in a form of pairs: ProductName and TotalPrice per product (Price*Quantity)
*/

CREATE OR ALTER   PROCEDURE [dbo].[CreateOrderDetail] (@OrderId int, @ProductId int, @QuantityId int)
AS
BEGIN
	BEGIN TRY
	declare @Price decimal(18,9)
	declare @TotalPrice decimal(18,9)

		-- get the product price
		select @Price = Price 
		from dbo.Product 
		where  id = @ProductId

		 ----insert new order detail

			INSERT INTO dbo.OrderDetails ([OrderId], [ProductId], [Quantity], [Price])
			VALUES (@OrderId, @ProductId, @QuantityId, @Price)
	
		---- calculate the total price
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


	 -- -- output
		SELECT p.Name, sum(o.Quantity) as TotalQuantity, sum(o.Quantity * o.Price) as TotalPricePerProduct
		FROM dbo.[OrderDetails] o
		INNER JOIN dbo.Product p on p.id = o.ProductId
		WHERE o.OrderId = @OrderId
		GROUP BY p.Name

		

	END TRY
	BEGIN CATCH 
			EXEC usp_GetErrorInfo  
	END CATCH
END
GO


exec dbo.CreateOrderDetail @OrderId = 1544444, @ProductId = 12313122, @QuantityId = 5
GO


exec dbo.CreateOrderDetail @OrderId = 1544444, @ProductId = 11, @QuantityId = 5
GO

exec dbo.CreateOrderDetail @OrderId = 4200, @ProductId = 11, @QuantityId = 5
GO



select * from [dbo].[DetailLog]


select * from dbo.[Order]
where Id=4206

select * from Product
where Id = 12313122

