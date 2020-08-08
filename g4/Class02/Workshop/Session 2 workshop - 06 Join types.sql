/*
List all possible combinations of Customer names and Product 
names that can be ordered from specific customer
List all Business Entities that has any order 
List all Entities without orders
List all Customers without orders (using Right Join)
*/
select c.Name as CustomerName, p.Name as ProductName 
from dbo.Customer c
cross join dbo.Product p
--List all Business Entities that has any order
select distinct b.name as  BusinessEntity
from dbo.[Order] o
inner join dbo.BusinessEntity b on o.BusinessEntityId = b.Id

select distinct b.name as  BusinessEntity
from dbo.[Order] o
left join dbo.BusinessEntity b on o.BusinessEntityId = b.Id
where b.Id is not null

--List all Entities without orders
select distinct b.Name as  BusinessEntity
from dbo.BusinessEntity b
left join dbo.[Order] o on b.Id = o.BusinessEntityId
where o.Id is null

--List all Customers without orders (using Right Join)
select distinct c.Name
from dbo.[Order] o 
right join dbo.Customer c on c.Id = o.CustomerId 
where o.CustomerId is null

select distinct c.Name
from dbo.Customer c
left join dbo.[Order] o  on o.CustomerId = c.Id
where o.CustomerId is null


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

