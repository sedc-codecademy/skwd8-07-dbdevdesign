create function dbo.fn_ProductQuantitySold(@productid int)
returns decimal (18,2)
as
begin

declare @result decimal(18,2)
select @result = count(od.quantity)--, sum(od.price)
from dbo.product p
inner join OrderDetails od on p.id= od.productid
where p.id = @productid

return @result
end

go

create function dbo.fn_ProductPriceSold(@productid int)
returns decimal (18,2)
as
begin

declare @result decimal(18,2)
select @result = sum(od.price)
from dbo.product p
inner join OrderDetails od on p.id= od.productid
where p.id = @productid

return @result
end
GO


create view dbo.report
as

select distinct be.name as BEName,p.name as ProductName,dbo.fn_ProductQuantitySold(p.id)as quantity,dbo.fn_ProductPriceSold(p.id)price
from product p
inner join OrderDetails od on p.id=od.ProductId
inner join [order] o on o.id=od.OrderId
inner join BusinessEntity be on be.id = o.BusinessEntityId
GO

select *
from dbo.report
order by 1 desc