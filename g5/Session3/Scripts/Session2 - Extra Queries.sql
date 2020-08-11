select * 
from dbo.BusinessEntity

select * 
from dbo.Customer

select * from Employee
select * from Product where Description like '%tea%'

select *
from dbo.[Order]

select *
from dbo.[OrderDetails]

-- Find all different products that one employee Aleksandar	Stojanovski can order

select e.FirstName as Ime, e.LastName as prezime, p.Description as Produkt
from dbo.Employee e
cross join dbo.Product p 
where FirstName = 'Aleksandar' and LastName = 'Stojanovski'


-- Find all orders from Vitalia Bitola, Ordered by Tinex, Ordered in 2019 before christmas
select * from dbo.Customer

select o.*
from dbo.[Order] o
inner join dbo.BusinessEntity be on be.id = o.BusinessEntityId
inner join dbo.Customer c on c.id = o.CustomerId
WHERE BE.Name = 'Vitalia Bitola' AND C.Name = 'Zito Bitola'
	and o.OrderDate between '2019-01-01' and '2019-04-01'



-- Find TOP 10 Employees Names, and How much they sold who sold procuct from Ohridski region
		--, for Granola products, order by highest sale

select TOP 10 E.FirstName, E.LastName, O.TotalPrice
from dbo.[Order] o
inner join dbo.OrderDetails od on od.OrderId = o.id
inner join dbo.BusinessEntity be on be.id = o.BusinessEntityId
inner join dbo.Customer c on c.id = o.CustomerId
inner join dbo.Employee e on e.Id = o.EmployeeId
inner join dbo.Product p on p.id = od.ProductId
WHERE P.Description LIKE '%GRANOLA%' 
		AND be.Region = 'Ohridski'
ORDER BY O.TotalPrice DESC


-- fIND ALL employees who dont have any order

SELECT *
FROM dbo.Employee e
LEFT JOIN dbo.[Order] o on o.EmployeeId = e.Id
WHERE o.BusinessEntityId IS NULL

-- fIND ALL employees who made any order on christmas 2019

SELECT *
FROM dbo.Employee e
--LEFT JOIN dbo.[Order] o on o.EmployeeId = e.Id
INNER JOIN dbo.[Order] o on o.EmployeeId = e.Id
WHERE O.OrderDate = '2019-01-07'
	


-- fIND which employee made the highest order on christmas 2019
-- With tie braker


SELECT TOP 2 e.FirstName, e.LastName, o.TotalPrice, od.*
FROM dbo.Employee e
--LEFT JOIN dbo.[Order] o on o.EmployeeId = e.Id
INNER JOIN dbo.[Order] o on o.EmployeeId = e.Id
INNER JOIN dbo.OrderDetails od on od.OrderId = o.Id
WHERE O.OrderDate = '2019-01-07'
order by o.TotalPrice DESC, OD.Price DESC


