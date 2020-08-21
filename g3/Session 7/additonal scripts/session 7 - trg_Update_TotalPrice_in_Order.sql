-- ================================================
-- Template generated from Template Explorer using:
-- Create Trigger (New Menu).SQL
--
-- Use the Specify Values for Template Parameters 
-- command (Ctrl-Shift-M) to fill in the parameter 
-- values below.
--
-- See additional Create Trigger templates for more
-- examples of different Trigger statements.
--
-- This block of comments will not be included in
-- the definition of the function.
-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE OR ALTER TRIGGER trg_Update_TotalPrice_in_Order
   ON  dbo.OrderDetails
   AFTER INSERT,DELETE,UPDATE
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @TotalPrice DECIMAL(18,2)

    -- Insert statements for trigger here
	if (select count(*) from deleted)>0
	BEGIN
		SET @TotalPrice = 
		(
			SELECT sum(o.Quantity * o.Price)
			FROM dbo.[OrderDetails] o
			INNER JOIN deleted i
				ON  o.OrderId = i.OrderId
		)

		-- correct the total price
		update o set TotalPrice = @TotalPrice
		from [Order] o
		INNER JOIN deleted i
			ON i.OrderId = o.Id
	END

	if (select count(*) from inserted)>0
	BEGIN
		SET @TotalPrice = 
		(
			SELECT sum(o.Quantity * o.Price)
			FROM dbo.[OrderDetails] o
			INNER JOIN inserted i
				ON  o.OrderId = i.OrderId
		)

		-- correct the total price
		update o set TotalPrice = @TotalPrice
		from [Order] o
		INNER JOIN inserted i
			ON i.OrderId = o.id
	END

END
GO
