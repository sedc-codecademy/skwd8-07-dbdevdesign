/*
List all possible combinations of Customer names and Product names that can be ordered from specific customer
List all Business Entities that has any order 
List all Entities without orders
List all Customers without orders (using Right Join)
*/


select c.Name as CustomerName, p.Name as ProductName
from dbo.Customer c
cross join dbo.Product p
GO

select DISTINCT b.Name
from dbo.[Order] o
inner join dbo.BusinessEntity b on b.Id = o.BusinessEntityId
GO

select DISTINCT b.Name
from dbo.BusinessEntity b
left join dbo.[Order] o on b.Id = o.BusinessEntityId
where o.BusinessEntityId is null
GO

-- Customers without orders - RIGHT
select c.*
from dbo.[Order] o
right join dbo.Customer c on o.CustomerId = c.Id
where o.CustomerId is null

-- right can be writen with Left as well
select c.*
from dbo.Customer c 
left join dbo.[Order] o on o.CustomerId = c.Id
where o.CustomerId is null

