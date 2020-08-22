---------------------------
--Employee without orders

select
	e.*
from
	Employee as e
	left outer join [Order] as o on e.ID = o.EmployeeId
where
	o.EmployeeId is null

select
	e.*
from
	Employee as e
where
	not exists
	(
		select 1 from [Order] as o where o.EmployeeId = e.Id
	)

---------------------------
--Customer without orders

select
	c.*
from
	Customer as c
	left outer join [Order] as o on c.ID = o.CustomerId
where
	o.CustomerId is null