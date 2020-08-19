--5--
create function dbo.fn_ProductQuantitySold(@productid int, @businessentityid int)
returns decimal (18,2)
as
begin

declare @result decimal(18,2)
select @result = sum(od.quantity)
from dbo.product p
inner join OrderDetails od on p.id= od.productid
inner join [order] o on o.id = od.OrderId
where p.id = @productid and o.BusinessEntityId = @businessentityid

return @result
end

go

--6--
create function dbo.fn_ProductPriceSold(@productid int, @businessentityid int)
returns decimal (18,2)
as
begin

declare @result decimal(18,2)
select @result = sum(od.price*od.quantity)
from dbo.product p
inner join OrderDetails od on p.id= od.productid
inner join dbo.[Order] o on o.id = od.OrderId
where p.id = @productid and o.BusinessEntityId = @businessentityid

return @result
end

go

--7--
create view dbo.report 
as

select distinct [dbo].[ToCyrillic](be.name) as [Име на компанија],
                concat(be.Zipcode, N' - ', [dbo].[ToCyrillic](be.Region)) as [Регион],
				bed.accountnumber as [Број на сметка],
				replace(bed.address,'XXXX', N'Улица број') as [Адреса],
                [dbo].[ToCyrillic](p.name) as [Име на продукт],
				cast(dbo.fn_ProductQuantitySold(p.id, o.BusinessEntityId) as int)as [Количина],
				cast(dbo.fn_ProductPriceSold(p.id,o.BusinessEntityId) as nvarchar(50)) + N' МКД' [Цена]
from product p
inner join OrderDetails od on p.id=od.ProductId
inner join [order] o on o.id=od.OrderId
inner join BusinessEntity be on be.id = o.BusinessEntityId
inner join dbo.businessentity_details bed on bed.businessentityid = be.id
where p.name = 'Granola'

go

select *
from dbo.report 
order by 1 desc