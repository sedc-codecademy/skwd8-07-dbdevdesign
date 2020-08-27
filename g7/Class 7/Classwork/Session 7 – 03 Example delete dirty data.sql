
select * from [dbo].[OrderDetails] od
left join dbo.[Order] oo on oo.Id=od.OrderId
WHERE oo.Id is null


delete od
from [dbo].[OrderDetails] od
left join dbo.[Order] oo on oo.Id=od.OrderId
WHERE oo.Id is null


select * from [dbo].[OrderDetails] od
left join  [dbo].[Product] pr on od.ProductId=pr.Id
WHERE pr.Id is null


delete od
from [dbo].[OrderDetails] od
left join  [dbo].[Product] pr on od.ProductId=pr.Id
WHERE pr.Id is null