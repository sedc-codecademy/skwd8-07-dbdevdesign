CREATE FUNCTION dbo.fn_OrderDetailTotalPrice (@OrderDetailID int)
RETURNS decimal(18,2)
AS 
BEGIN
	declare
		@Result decimal(18,2)

	select
		@Result = od.Quantity * Price
	from
		dbo.OrderDetails as od
	where
		Id = @OrderDetailID

	RETURN @Result
END
GO

--------------------
--View

DROP VIEW IF EXISTS dbo.vv_EmployeeOrders
GO
CREATE VIEW dbo.vv_EmployeeOrders
AS
	select
		Concat(e.FirstName, ' ', e.LastName) as EmployeeName
	,	p.[Name] as ProductName
	,	o.OrderDate
	,	od.Quantity
	,	od.Price
	,	dbo.fn_OrderDetailTotalPrice (od.ID) as TotalPrice
	from
		[dbo].[Order] as o
		inner join [dbo].[OrderDetails] as od on o.Id = od.OrderId
		inner join [dbo].[Product] as p on od.ProductId = p.Id
		inner join [dbo].[Employee] as e on o.EmployeeId = e.Id
	where
		o.OrderDate between '2019-05-01' and '2019-05-31'
	and	e.Gender = 'F'
GO
select * from vv_EmployeeOrders

--------------------
--Inline TVF

DROP FUNCTION IF EXISTS dbo.fn_EmployeeOrders_Inline;
GO
CREATE FUNCTION dbo.fn_EmployeeOrders_Inline (@Gender nchar(1), @StartDate date, @EndDate date)
RETURNS TABLE
AS 
	RETURN
	select
		Concat(e.FirstName, ' ', e.LastName) as EmployeeName
	,	p.[Name] as ProductName
	,	o.OrderDate
	,	od.Quantity
	,	od.Price
	,	dbo.fn_OrderDetailTotalPrice (od.ID) as TotalPrice
	from
		[dbo].[Order] as o
		inner join [dbo].[OrderDetails] as od on o.Id = od.OrderId
		inner join [dbo].[Product] as p on od.ProductId = p.Id
		inner join [dbo].[Employee] as e on o.EmployeeId = e.Id
	where
		o.OrderDate between @StartDate and @EndDate
	and	e.Gender = @Gender
GO

--------------------
--MultiStatement TVF

DROP FUNCTION IF EXISTS dbo.fn_EmployeeOrders_MultiStatement;
GO
CREATE FUNCTION dbo.fn_EmployeeOrders_MultiStatement (@Gender nchar(1), @StartDate date, @EndDate date)
RETURNS @output TABLE (EmployeeName nvarchar(200), ProductName nvarchar(100), OrderDate date, Quantity int, Price decimal(18,2), TotalPrice decimal(18,2))
AS
BEGIN
	IF @Gender =  'F'
	BEGIN
		insert into @output (EmployeeName, ProductName, OrderDate, Quantity, Price, TotalPrice)
		select
			Concat(e.FirstName, ' ', e.LastName) as EmployeeName
		,	p.[Name] as ProductName
		,	o.OrderDate
		,	od.Quantity
		,	od.Price
		,	dbo.fn_OrderDetailTotalPrice (od.ID) as TotalPrice
		from
			[dbo].[Order] as o
			inner join [dbo].[OrderDetails] as od on o.Id = od.OrderId
			inner join [dbo].[Product] as p on od.ProductId = p.Id
			inner join [dbo].[Employee] as e on o.EmployeeId = e.Id
		where
			o.OrderDate between @StartDate and @EndDate
		and	e.Gender = @Gender
	END
RETURN 
END
GO

select * from dbo.vv_EmployeeOrders
go
select * from dbo.fn_EmployeeOrders_Inline('F', '2019-05-01', '2019-05-31')
go
select * from dbo.fn_EmployeeOrders_MultiStatement('F', '2019-05-01', '2019-05-31')
go
